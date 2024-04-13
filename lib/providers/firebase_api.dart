import 'package:firebase_database/firebase_database.dart';

class FirebaseApi {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<List<Map<String, dynamic>>> getData() async {
    List<Map<Object?, Object?>> listObjects = [];
    List<Map<String, dynamic>> data = [];
    final databaseEvent = await database.ref('data').once();
    final dataValue = databaseEvent.snapshot.value; // data is Object? type
    if (dataValue != null) {
      for (var item in dataValue as Iterable) {
        listObjects.add(item);
      }
    }
    // transform data to List<Map<String, dynamic>>
    for (var item in listObjects) {
      data.add(item.map((key, value) => MapEntry(key.toString(), value)));
    }
    return data;
  }

  // Implementar método para buscar dados no Firebase com um parâmetro de consulta iguais ou semelhantes
  Future<List<Map<String, dynamic>>> getDataByQuery(String query) async {
    List<Map<String, dynamic>> data = [];
    final databaseEvent = await database
        .ref('data')
        .orderByChild('title')
        .startAt(query)
        .endAt("$query\uf8ff")
        .once();
    final dataValue = databaseEvent.snapshot.value; // data is Object? type
    if (dataValue != null) {
      for (var item in dataValue as Iterable) {
        data.add(item.map((key, value) => MapEntry(key.toString(), value)));
      }
    }
    return data;
  }
}
