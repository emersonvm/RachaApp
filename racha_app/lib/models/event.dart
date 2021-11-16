import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:racha_app/utils/constants.dart';

class Event with ChangeNotifier {
  final String id;
  final String image = 'package:';
  final String name;
  final double totalValue;
  final double missingValue = 0;

  final String address;
  bool isFavorite;

  Event({
    required this.id,
    required this.name,
    required this.totalValue,
    required this.address,
    this.isFavorite = true,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
  }

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
        Uri.parse(
          '${Constants.USER_FAVORITES_URL}/$userId/$id.json',
        ),
        body: jsonEncode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (_) {
      _toggleFavorite();
    }
  }
}
