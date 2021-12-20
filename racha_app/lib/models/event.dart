import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:racha_app/models/user.dart';

class Event with ChangeNotifier {
  final String id;
  final String image = 'package:';
  final String name;
  final double paidValue = 0;
  final double totalValue;
  final double missingValue = 0;
  final String address;

  Event({
    required this.id,
    required this.name,
    required this.totalValue,
    required this.address,
  });
}
