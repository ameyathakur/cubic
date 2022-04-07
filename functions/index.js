const functions = require("firebase-functions");

// Get a reference to the Pub/Sub component
const {PubSub} = require('@google-cloud/pubsub');
const pubsub = new PubSub();
// Get a reference to the Cloud Storage component
const {Storage} = require('@google-cloud/storage');
const storage = new Storage();

// Get a reference to the Cloud Vision API component
const Vision = require('@google-cloud/vision');
const vision = new Vision.ImageAnnotatorClient();

// Get a reference to the Translate API component
const {Translate} = require('@google-cloud/translate').v2;
const translate = new Translate();

exports.extractText = functions.storage.object().onFinalize(async (object) => {
   const filename = object.name;
   bucketName = object.bucket;
   console.log(`Looking for text in image ${filename}`);
     const [textDetections] = await vision.textDetection(
       `gs://${bucketName}/${filename}`
     );
     const [annotation] = textDetections.textAnnotations;
     const text = annotation ? annotation.description : '';
     console.log('Extracted text from image:', text);

     let [translateDetection] = await translate.detect(text);
     if (Array.isArray(translateDetection)) {
       [translateDetection] = translateDetection;
     }
     console.log(
       `Detected language "${translateDetection.language}" for ${filename}`
     );

     // Submit a message to the bus for each language we're going to translate to
     const TO_LANGS = process.env.TO_LANG.split(',');
     const topicName = process.env.TRANSLATE_TOPIC;

     const tasks = TO_LANGS.map(lang => {
       const messageData = {
         text: text,
         filename: filename,
         lang: lang,
       };

       // Helper function that publishes translation result to a Pub/Sub topic
       // For more information on publishing Pub/Sub messages, see this page:
       //   https://cloud.google.com/pubsub/docs/publisher
       return publishResult(topicName, messageData);
     });

     return Promise.all(tasks);

});