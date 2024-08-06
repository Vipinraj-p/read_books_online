import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:read_books_online/constants/api_endpoints.dart';
import 'package:read_books_online/models/searching_books_model/searching_books_model.dart';
import 'package:read_books_online/secrets/api_key.dart';
import 'package:http/http.dart' as http;

class SearchBooksProvider extends ChangeNotifier {
  String searchString = '';
  void refreshQuery(String q) {
    searchString = q;
    fetchSearchBooks(searchString);
    notifyListeners();
  }

  SearchingBooksModel? _searchingBooks;
  SearchingBooksModel? get searchingBooks => _searchingBooks;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = '';
  String get error => _error;
  Future<void> fetchSearchBooks(searchQuery) async {
    _isLoading = true;
    _error = "";
    try {
      final searchUrl = "$baseUrl/volumes?q=$searchQuery:keyes&key=$apiKey";
      log(searchUrl, name: "searchUrl");
      final responce = await http.get(Uri.parse(searchUrl));
      log(responce.statusCode.toString(), name: "status Code");
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        log(SearchingBooksModel.fromJson(jsonDecode(responce.body)).toString(),
            name: "log1");

        _searchingBooks =
            SearchingBooksModel.fromJson(jsonDecode(responce.body));
        log(_searchingBooks.toString());
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
