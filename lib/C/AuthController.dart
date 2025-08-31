import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Add this instance


  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        }
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      // Re-throw the exception to be handled by the UI
      throw e;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }


  // Method to sign in a user
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Method to register a new "Owner"
  Future<UserCredential?> signUpAsOwner({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String phoneNumber,
    required String businessName,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (userCredential.user != null) {
        // Save all the provided details to the user's document in Firestore.
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid, // Storing uid is good practice
          'name': name.trim(),
          'surname': surname.trim(),
          'phoneNumber': phoneNumber.trim(),
          'businessName': businessName.trim(),
          'email': email.trim(),
          'role': 'Owner', // Role is hardcoded to 'Owner'
          'createdAt': Timestamp.now(),
        });
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
  // NEW: Method to get user role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        // Make sure the 'role' field exists before trying to access it
        final data = doc.data() as Map<String, dynamic>;
        return data.containsKey('role') ? data['role'] : null;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}