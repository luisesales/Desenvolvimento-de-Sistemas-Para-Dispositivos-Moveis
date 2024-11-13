import 'package:flutter/foundation.dart';
import 'package:mini_projeto_3/model/lugar.dart';
import 'package:mini_projeto_3/model/pais.dart';
import 'package:mini_projeto_3/data/dados.dart';

class PaisesModel with ChangeNotifier {  
  
  List<Lugar> _lugaresFavoritos = [];
  List<Pais> _paises = [];

  List<Lugar>  get favoritos => _lugaresFavoritos;
  List<Pais> get todos_paises => _paises;    

  void initialize(){
    for(Pais p in paises){
      _paises.add(p);
    }    
    notifyListeners();
  }

  List<Lugar> getLugares(String id){
    return lugares.where((lugar) {return lugar.paises.contains(id);}).toList();
  }
  
  bool contains(Lugar lugar){
    return _lugaresFavoritos.contains(lugar);
  }

  void favorite(Lugar lugar){
   _lugaresFavoritos.contains(lugar) ? _lugaresFavoritos.remove(lugar) : _lugaresFavoritos.add(lugar);
   notifyListeners(); 
  }
}
