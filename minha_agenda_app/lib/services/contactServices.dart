import 'package:firebase_database/firebase_database.dart';

class ProductService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref(); // Referência raiz
  Future<String> addProduct({
    required String id,
    required String name,
    required String surname,
    required String email,
    required String phone,
    required double latitude,
    required double longitude,
    required String address,
    required String avatar,
    required int status,
  }) async {
    try {
      await _dbRef.child('contacts/$id').set({
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'phone': phone,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'avatar': avatar,
        'status': status
      });
      return 'Produto adicionado com sucesso!';
    } catch (error) {
      return 'Erro ao adicionar contato: $error';
    }
  }

  Future<String> removeProduct(String id) async {
    try {
      await _dbRef
          .child('contacts/$id')
          .remove(); // Remove o nó correspondente ao ID
      return 'Produto removido com sucesso!';
    } catch (error) {
      return 'Erro ao adicionar contato: $error';
    }
  }

  Future<String> updateProduct({
    required String id,
    required String name,
    required String surname,
    required String email,
    required String phone,
    required double latitude,
    required double longitude,
    required String address,
    required String avatar,
    required int status,
  }) async {
    try {
      await _dbRef.child('contacts/$id').update({
        'name': name,
        'surname': surname,
        'email': email,
        'phone': phone,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'avatar': avatar,
        'status': status
      });
      return 'Produto atualizado com sucesso!';
    } catch (error) {
      return 'Erro ao atualizar contato: $error';
    }
  }
}
