import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:read_books_online/constants/api_endpoints.dart';
import 'package:read_books_online/models/home_books_model/home_books_model.dart';
import 'package:read_books_online/secrets/api_key.dart';
import 'package:http/http.dart' as http;

class HomeBookProvider extends ChangeNotifier {
  List<String> catgList = ["fiction", "nonfiction", "science", "history"];
  int dropdownValue = 0;

  void refreshHome(int index) {
    fetchBooks(catgList[index]);
    log(fetchBooks(catgList[index]).toString());
    log(catgList[index]);
    notifyListeners();
  }

  HomeBooksModel? _homeBooks;
  HomeBooksModel? get homeBooks => _homeBooks;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = '';
  String get error => _error;
  Future<void> fetchBooks(category) async {
    _isLoading = true;
    _error = "";
    try {
      final searchUrl =
          "$baseUrl/volumes?q=e+subject:$category&orderBy=newest&key=$apiKey";
      log(searchUrl, name: "searchUrl");
      final responce = await http.get(Uri.parse(searchUrl));
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        _homeBooks = HomeBooksModel.fromJson(jsonDecode(responce.body));
        notifyListeners();
      } else {
        _error = "Server side Error...!";
      }
    } catch (e) {
      log(e.toString(), name: "client");
      _error = "Client side Error..!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
