// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.notifyNewMessage = functions.firestore
  .document("messages/{groupId1}/{groupId2}/{message}")
  .onCreate(async (snapshot) => {
    const database = admin.firestore();
    const messaging = admin.messaging();
    const message = snapshot.data();

    const receiver = await database.collection("users").doc(message.idTo).get();

    const sender = await database.collection("users").doc(message.idFrom).get();

    const token = receiver.data().token;

    const payload = {
      notification: {
        title: `Nouveau message de ${sender.data().name}`,
        body: message.content,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    };
    return messaging.sendToDevice(token, payload);
  });
