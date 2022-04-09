import * as functions from "firebase-functions";

import * as admin from "firebase-admin";
admin.initializeApp(functions.config().firebase);

import * as vision from "@google-cloud/vision";
const client = new vision.ImageAnnotatorClient();

export const imageTagger = functions.storage
    .object()
    .onFinalize( async (event) => {
      const filePath = event.name;
      const bucketName = event.bucket;
      const fileName = path.basename(filePath);

const outputPrefix = "results"
     const gcsSourceUri = "gs://${bucketName}/${fileName}";
     const gcsDestinationUri = "gs://${bucketName}/${outputPrefix}/";

     const inputConfig = {
       // Supported mime_types are: 'application/pdf' and 'image/tiff'
       mimeType: "application/pdf",
       gcsSource: {
         uri: gcsSourceUri,
       },
     };
     const outputConfig = {
       gcsDestination: {
         uri: gcsDestinationUri,
       },
     };
     const features = [{type: "DOCUMENT_TEXT_DETECTION"}];
     const request = {
       requests: [
         {
           inputConfig: inputConfig,
           features: features,
           outputConfig: outputConfig,
         },
       ],
     };

     const [operation] = await client.asyncBatchAnnotateFiles(request);
     const [filesResponse] = await operation.promise();
     const destinationUri =
       filesResponse.responses[0].outputConfig.gcsDestination.uri;
     console.log('Json saved to: ' + destinationUri);
    });
