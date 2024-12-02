typedef DocumentDeserializer<T> = T Function(Map<String, dynamic> json);
typedef DocumentSerializer<T> = Map<String, dynamic> Function(T data);
