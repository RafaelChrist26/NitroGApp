import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Registration Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      print("Error deleting account: $e");
      throw e;
    }
  }

  Future<bool> isAccountSetUp() async {
  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

      final userDocSnapshot = await userDoc.get();

      // Check if the document exists and if it contains any data
      return userDocSnapshot.exists && userDocSnapshot.data() != null;
    }
  } catch (e) {
    print("Error checking if account is set up: $e");
  }

  // Default to false if an error occurs
  return false;
}

// // Fungsi untuk mengirim email pengaturan ulang kata sandi
//   Future<String?> resetPassword({required String email}) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//       return 'Password reset email has been sent. Check your email.';
//     } catch (error) {
//       return error.toString();
//     }
//   }

  Future<String?> updatePassword({required String newPassword}) async {
    try {
      User? user = _auth.currentUser;
      await user?.updatePassword(newPassword);
      return 'Password updated successfully';
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> logout() async {
    try {
      // Jika pengguna menggunakan Google Sign-In
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Logout dari Firebase Auth
      await _auth.signOut();
    } catch (e) {
      print('Error during logout: $e');
      // Handle error during logout if necessary
    }
  }

  Future<String?> signInWithGoogle(
      GoogleSignInAccount googleSignInAccount) async {
    try {
      // Obtain the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? user = authResult.user;

      // Check if the user is new
      if (authResult.additionalUserInfo?.isNewUser ?? false) {
        // Additional actions for a new user (e.g., create a user profile)

        // You can customize this part based on your application's requirements
        await _auth.createUserWithEmailAndPassword(
          email: user?.email ?? '',
          password: 'randomPassword', // Provide a temporary password
        );

        // Perform additional actions for a new user, such as initializing user data
      }

      // Return a success message
      return 'Login Success';
    } catch (e) {
      // Return an error message
      print('Error signing in with Google: $e');
      return 'An error occurred';
    }
  }
}
