import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:racha_app/Exceptions/http_exception.dart';
import 'package:racha_app/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:racha_app/utils/constants.dart';

class EventList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Event> _events = [];

  List<Event> get items => [..._events];
  List<Event> get favoriteEvents =>
      _events.where((prod) => prod.isFavorite).toList();

  EventList([
    this._token = '',
    this._userId = '',
    this._events = const [],
  ]);

  int get itemsCount {
    return _events.length;
  }

  Future<void> loadEvents() async {
    _events.clear();

    final response = await http.get(
      Uri.parse('${Constants.EVENT_BASE_URL}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.USER_FAVORITES_URL}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((eventId, eventData) {
      final isFavorite = favData[eventId] ?? false;
      _events.add(
        Event(
          id: eventId,
          name: eventData['name'],
          totalValue: eventData['totalValue'],
          missingValue: data['missingValue'],
          address: eventData['address'],
          dateEvent: eventData['dateEvent'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveEvent(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final event = Event(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      totalValue: data['totalValue'] as double,
      missingValue: data['missingValue'] as double,
      dateEvent: data['dateEvent'] as DateTime,
      address: data['address'] as String,
    );

    if (hasId) {
      return updateEvent(event);
    } else {
      return addEvent(event);
    }
  }

  Future<void> addEvent(Event event) async {
    final response = await http.post(
      Uri.parse('${Constants.EVENT_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": event.name,
          "totalValue": event.totalValue,
          "missingValue": event.missingValue,
          "dateEvent": event.dateEvent,
          "address": event.address,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _events.add(Event(
      id: id,
      name: event.name,
      totalValue: event.totalValue,
      missingValue: event.missingValue,
      dateEvent: event.dateEvent,
      address: event.address,
    ));
    notifyListeners();
  }

  Future<void> updateEvent(Event event) async {
    int index = _events.indexWhere((p) => p.id == event.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.EVENT_BASE_URL}/${event.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
            "name": event.name,
            "totalValue": event.totalValue,
            "missingValue": event.missingValue,
            "dateEvent": event.dateEvent,
            "address": event.address,
          },
        ),
      );

      _events[index] = event;
      notifyListeners();
    }
  }

  Future<void> removeEvent(Event event) async {
    int index = _events.indexWhere((p) => p.id == event.id);

    if (index >= 0) {
      final event = _events[index];
      _events.remove(event);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.EVENT_BASE_URL}/${event.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _events.insert(index, event);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o evento.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
