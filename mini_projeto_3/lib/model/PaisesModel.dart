import 'package:flutter/foundation.dart';
import 'package:mini_projeto_3/model/lugar.dart';

class PaisesModel with ChangeNotifier {
  List<Lugar> _lugaresFavoritos = [];


  List<Lugar>  get favoritos => _lugaresFavoritos;
  
  bool contains(Lugar lugar){
    return _lugaresFavoritos.contains(lugar);
  }

  void favorite(Lugar lugar){
   _lugaresFavoritos.contains(lugar) ? _lugaresFavoritos.remove(lugar) : _lugaresFavoritos.add(lugar);
   notifyListeners(); 
  }
}
