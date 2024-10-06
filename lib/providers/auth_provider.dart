import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda_xh/services/auth_service.dart';

class AuthServiceProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;
  final _firestore = FirebaseFirestore.instance;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> signUp(String email, String password, String name) async {
    _setLoading(true);
    try {
      await _authService.signUpWithEmailPassword(email, password);
      _firestore
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"email": email, "name": name});
      _setErrorMessage(null);
    } on AuthException catch (e) {
      _setErrorMessage(e.message);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmailPassword(email, password);
      _setErrorMessage(null);
    } on AuthException catch (e) {
      _setErrorMessage(e.message);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _setErrorMessage(null);
    } on AuthException catch (e) {
      _setErrorMessage(e.message);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
