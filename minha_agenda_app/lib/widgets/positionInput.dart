import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minha_agenda_app/model/position.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:minha_agenda_app/pages/gMaps.dart';
import 'package:minha_agenda_app/utils/positionUtil.dart';

class PositionInput extends StatefulWidget {
  final Function onSelectLocation;
  PositionInput(this.onSelectLocation);

  @override
  _PositionInputState createState() => _PositionInputState();
}

class _PositionInputState extends State<PositionInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      if (locData.latitude == null || locData.longitude == null) {
        throw Exception('Falha ao obter localização');
      }
      final address = await PositionUtil.getPlaceAddress(
        locData.latitude!,
        locData.longitude!,
      );

      final location = Position(
        latitude: locData.latitude!,
        longitude: locData.longitude!,
        address: address,
      );

      widget.onSelectLocation(location);

      final staticMapImageUrl = PositionUtil.generateLocationPreviewImage(
        latitude: locData.latitude,
        longitude: locData.longitude,
      );

      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (error) {
      print('Erro ao obter localização: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível obter a localização atual.'),
        ),
      );
    }
  }

  Future<void> _selectOnMap() async {
    try {
      final LatLng? selectedPosition = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: ((context) => MapScreen()),
        ),
      );

      if (selectedPosition == null) {
        return; // Usuário cancelou
      }

      final location = Position(
        latitude: selectedPosition.latitude,
        longitude: selectedPosition.longitude,
        address: await PositionUtil.getPlaceAddress(
          selectedPosition.latitude,
          selectedPosition.longitude,
        ),
      );

      widget.onSelectLocation(location);

      final staticMapImageUrl = PositionUtil.generateLocationPreviewImage(
        latitude: selectedPosition.latitude,
        longitude: selectedPosition.longitude,
      );

      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (error) {
      print('Erro ao selecionar localização no mapa: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível selecionar a localização.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'Localização não informada!',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(height: 10), // Espaço entre os elementos
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.black, // Ícone azul escuro
                ),
                label: Text(
                  'Localização atual',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black), // Fonte menor e cor preta
                ),
                onPressed: _getCurrentUserLocation,
              ),
              SizedBox(width: 8), // Espaço entre os botões
              TextButton.icon(
                icon: Icon(
                  Icons.map,
                  color: Colors.black, // Ícone azul escuro
                ),
                label: Text(
                  'Selecione no Mapa',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black), // Fonte menor e cor preta
                ),
                onPressed: _selectOnMap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
