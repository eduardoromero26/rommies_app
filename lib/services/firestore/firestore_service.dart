import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new document in a collection
  Future<void> createDocument(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).add(data);
    } catch (e) {
      Exception('Error creating document: $e');
    }
  }

  // Read a document from a collection
  Future<DocumentSnapshot> readDocument(
      String collectionPath, String documentId) async {
    try {
      return await _firestore.collection(collectionPath).doc(documentId).get();
    } catch (e) {
      Exception('Error reading document: $e');
      rethrow;
    }
  }

  // Update a document in a collection
  Future<void> updateDocument(String collectionPath, String documentId,
      Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } catch (e) {
      Exception('Error updating document: $e');
    }
  }

  // Delete a document from a collection
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      Exception('Error deleting document: $e');
    }
  }

  // Read all documents from a collection
  Future<List<DocumentSnapshot>> readAllDocuments(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionPath).get();
      return querySnapshot.docs;
    } catch (e) {
      Exception('Error reading all documents: $e');
      rethrow;
    }
  }
}
