// Imports
const { functions } = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

// Cloud Function to handle HTTP requests
exports.getScannedCodes = functions.https.onRequest(async (req, res) => {
  try {
    // Access Firestore collection
    const scannedCodesCollection = admin.firestore().collection("scannedCodes");

    // Retrieve data from Firestore
    const documentSnapshot = await scannedCodesCollection.doc(userId).get();

    if (documentSnapshot.exists) {
      const data = documentSnapshot.data();
      // Process retrieved data
      // Example: Extract 'codes', 'product', 'response' from 'data'
      const codes = data.codes || [];
      const product = data.product || [];
      const response = data.response || [];

      // Return response to client
      res.status(200).json({ codes, product, response });
    } else {
      res.status(404).send("Document not found");
    }
  } catch (error) {
    console.error("Error getting scannedCodes data:", error);
    res.status(500).send("Internal Server Error");
  }
});
