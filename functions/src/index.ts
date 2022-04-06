import * as functions from "firebase-functions";

import * as admin from "firebase-admin";
admin.initializeApp(functions.config().firebase);

import * as vision from "@google-cloud/vision";
const visionClient = new vision.ImageAnnotatorClient();

export const imageTagger = functions.storage
    .object()
    .onFinalize( async (event) => {
      const filePath = event.name;
      const imageUri = "gs://${bucketName}/${filePath}";

      const docRef = admin.firestore().collection("Users")
          .doc("64hhzztX4pqgPkdHg51N").collection("Document").doc(filePath);

      const textRequest = await visionClient.documentTextDetection(imageUri);

      const fullText = textRequest[0].textAnnotations[0];
      const text = fullText ? fullText.description : null;

      const webRequest = await visionClient.webDetection(imageUri);

      const web = webRequest[0].webDetection;

      const faceRequest = await visionClient.faceDetection(imageUri);

      const faces = faceRequest[0].faceAnnotations;

      const landmarksRequest = await visionClient.landmarkDetection(imageUri);

      const landmarks = landmarksRequest[0].landmarkAnnotations;

      const data = {text, web, faces, landmarks};

      return docRef.set(data);
    });



// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
