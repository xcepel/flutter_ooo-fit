part of 'package:ooo_fit/service/database_service.dart';

T _deserializeJsonDocument<T>(DocumentSnapshot<Map<String, dynamic>> document,
    DocumentDeserializer<T> deserializer) {
  // write document id to object
  final json = document.data()!..['id'] = document.id;
  return deserializer(json);
}

Map<String, dynamic> _serializeJsonDocument<T>(
    T data, DocumentSerializer<T> serializer) {
  // remove id field, data is stored under the id in database
  final json = serializer(data)..remove('id');
  // add createdAt timestamp if is not already set
  json['createdAt'] ??= FieldValue.serverTimestamp();

  return json;
}
