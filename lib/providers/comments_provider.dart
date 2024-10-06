import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lingopanda_xh/models/comment_model.dart';

class CommentsProvider with ChangeNotifier {
  List<Comment> _comments = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isEmailFull = true;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEmailFull => _isEmailFull;

  Future<void> fetchComments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _fetchRemoteConfig();

      final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _comments = data.map((json) => Comment.fromJson(json)).toList();
      } else {
        _errorMessage = 'Failed to load comments: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.fetchAndActivate();
      _isEmailFull = remoteConfig.getBool('isEmailFull');
    } catch (error) {
      _errorMessage = 'Failed to fetch remote config: $error';
    }
  }
}
