import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mini_projeto_5/provider/places_model.dart';
import 'package:provider/provider.dart';
import 'package:mini_projeto_5/screens/map_screen.dart';
import 'package:mini_projeto_5/widgets/LocationUtil.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  String? _previewImageUrl;
  LatLng? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true, builder: ((context) => MapScreen())),
    );
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    _pickedLocation = LatLng(locData.latitude!, locData.longitude!);
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude!,
      longitude: locData.longitude!,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedLocation == null) {
      return;
    }
    Provider.of<PlacesModel>(context, listen: false).addPlace(
      _titleController.text,
      _pickedLocation!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Novo Lugar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  SizedBox(height: 10),
                  if (_previewImageUrl != null)
                    Image.network(
                      _previewImageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  TextButton.icon(
                    icon: Icon(Icons.location_on),
                    label: Text('Localização Atual'),
                    onPressed: _getCurrentUserLocation,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Adicionar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: _submitForm,
            ),
          ),
        ],
      ),
    );
  }
}
