import 'package:ooo_fit/model/style.dart';
import 'package:ooo_fit/service/entity_service.dart';

class StyleService extends EntityService<Style> {
  static const String errorStoreMessage =
      "There was a problem with saving the style. Please try again.";

  const StyleService(
    super.repository,
    super.authService,
  );

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
      userId: getCurrentUserId(),
      name: name!,
      color: color!,
    );

    try {
      await repository.add(style);
    } catch (e) {
      return errorStoreMessage;
    }
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

    final newStyle = style.copyWith(name: name, color: color);

    try {
      await repository.setOrAdd(style.id, newStyle);
    } catch (e) {
      return errorStoreMessage;
    }
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

  Stream<List<Style>> getPiecesStylesByIdsStream(List<String> styleIds) {
    Set<String> styleIdsSet = Set<String>.from(styleIds);

    return repository.observeDocumentsByIds(styleIdsSet).map(
      (styles) {
        return styles;
      },
    );
  }
}
