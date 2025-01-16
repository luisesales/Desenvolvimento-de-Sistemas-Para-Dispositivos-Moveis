import 'dart:io';

import 'package:mini_projeto_5/models/place_location.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File? image;

  Place({
    required this.id,
    required this.title,
    this.location,
    this.image,
  });
}
