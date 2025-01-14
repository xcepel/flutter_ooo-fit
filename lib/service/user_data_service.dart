import 'package:ooo_fit/model/user_data.dart';
import 'package:ooo_fit/service/entity_service.dart';

class UserDataService extends EntityService<UserData> {
  static const String errorStoreMessage =
      "There was a problem with saving your data. Please try again.";

  UserDataService(
    super.repository,
    super.authService,
  );

  Future<String?> saveUserData({
    required String userId,
    String? name,
    String? city,
  }) async {
    print('saving user data');
    final UserData userData = UserData(
      id: '',
      userId: getCurrentUserId(),
      name: name,
      city: city,
    );

    try {
      await repository.add(userData);
    } catch (e) {
      print(e.toString());
      return errorStoreMessage;
    }
    return null;
  }

  Future<String?> updateUserData({
    required UserData userData,
    String? id,
    String? userId,
    String? name,
    String? city,
  }) async {
    final UserData newUserData = userData.copyWith(
      name: name,
      city: city,
    );

    try {
      await repository.setOrAdd(userData.id, newUserData);
    } catch (e) {
      return errorStoreMessage;
    }
    return null;
  }

  Stream<UserData?> getCurrentUsersDataStream() {
    return getAllStream().map(
      (List<UserData> userDataList) => userDataList[0],
    );
  }

  Future<UserData?> getCurrentUsersData() async {
    String currentUserId = getCurrentUserId();
    List<UserData> allUserDataList = await repository.getDocuments();
    return allUserDataList
        .where(
          (userData) => userData.userId == currentUserId,
        )
        .first;
  }
}
