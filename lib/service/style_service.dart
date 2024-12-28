import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/database_service.dart';

class StyleService {
  final DatabaseService<Style> _styleRepository;

  const StyleService(this._styleRepository);

  Future<String?> saveStyle({
    required String? name,
    required int? color,
  }) async {
    String? error = validate(name: name, color: color);
    if (error != null) {
      return error;
    }

    final style = Style(
      id: '',
      name: name!,
      color: color!,
    );

    await _styleRepository.add(style);
    return null;
  }

  Future<String?> updateStyle({
    required Style style,
    required String? name,
    required int? color,
  }) async {
    String? error = validate(name: name, color: color);
    if (error != null) {
      return error;
    }

    final newStyle = style.copyWith(name: name);
    //TODO: implement and use update
    await _styleRepository.setOrAdd(style.id, newStyle);
    return null;
  }

  String? validate({
    required String? name,
    required int? color,
  }) {
    if (name == null || color == null) {
      return 'All cells must contain a value';
    }
    return null;
  }

  Future<String?> delete({required String id}) async {
    await _styleRepository.delete(id);
    return null;
  }

  Stream<List<Style>> getAllStylesStream() {
    return _styleRepository.observeDocuments();
  }

  Stream<Map<String, Style>> getStylesByIdsStream(Set<String> styleIds) {
    return _styleRepository.observeDocumentsByIds(styleIds).map(
      (styles) {
        return {for (final style in styles) style.id: style};
      },
    );
  }
}
