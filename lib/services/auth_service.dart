import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Invalid email format.');
        case 'user-disabled':
          throw AuthException('This user has been disabled.');
        case 'user-not-found':
          throw AuthException('No user found with this email.');
        case 'invalid-credential':
          throw AuthException('Invalid credential');
        default:
          throw AuthException('Login failed. Please try again.');
      }
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException('This email is already in use.');
        case 'invalid-email':
          throw AuthException('Invalid email format.');
        case 'weak-password':
          throw AuthException('The password is too weak.');
        default:
          throw AuthException('Sign up failed. Please try again.');
      }
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed. Please try again.');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
