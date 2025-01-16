import 'dart:io';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mini_projeto_5/models/place_location.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';
import '../utils/db_util.dart';

class PlacesModel with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, LatLng place) {
    final newPlace = Place(
        id: Random().nextDouble().toString(),
        title: title,
        location: PlaceLocation(
            latitude: place.latitude,
            longitude: place.longitude,
            address: place.toString()),
        image: null);

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': '',
      'latitude': place.latitude.toString(),
      'longitude': place.longitude.toString(),
      'address': place.toString()
    });
    notifyListeners();
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: item['image'] != '' ? File(item['image']) : null,
            location: PlaceLocation(
                latitude: item['latitude'] != ''
                    ? double.parse(item['latitude'])
                    : 0.0,
                longitude: item['longitude'] != ''
                    ? double.parse(item['longitude'])
                    : 0.0,
                address: item['address']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
