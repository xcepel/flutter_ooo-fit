import 'package:ooo_fit/model/entity.dart';
import 'package:ooo_fit/service/auth_service.dart';

import 'database_service.dart';

class EntityService<T extends Entity> {
  final DatabaseService<T> repository;
  final AuthService authService;

  const EntityService(
    this.repository,
    this.authService,
  );

  Future<String?> delete(String id) async {
    await repository.delete(id);
    return null;
  }

  String getCurrentUserId() {
    return authService.currentUser!.uid;
  }

  List<T> _filterByCurrentUserId(List<T> entities) {
    final String currentUserId = getCurrentUserId();
    return entities.where((piece) => piece.userId == currentUserId).toList();
  }

  Stream<List<T>> getAllStream() {
    return repository.observeDocuments().map(_filterByCurrentUserId);
  }

  Stream<T?> getByIdStream(String id) {
    return repository.observeDocument(id);
  }

  Stream<Map<String, T>> getByIdsStream(Set<String> ids) {
    return repository.observeDocumentsByIds(ids).map(
      (entities) {
        return {for (final entity in entities) entity.id: entity};
      },
    );
  }
}
