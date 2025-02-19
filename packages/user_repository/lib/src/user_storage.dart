part of 'user_repository.dart';

/// Storage keys for the [UserStorage].
abstract class UserStorageKeys {
  /// Number of times that a user opened the application.
  static const appOpenedCount = '__app_opened_count_key__';
}

class UserStorage {
  const UserStorage({
    required PersistentStorage storage,
  }) : _storage = storage;

  final PersistentStorage _storage;

  Future<void> setAppOpenedCount({required int count}) => _storage.writeString(
        key: UserStorageKeys.appOpenedCount,
        value: count.toString(),
      );

  /// Fetches the number of times the app was opened value from Storage.
  Future<int> fetchAppOpenedCount() async {
    final count = await _storage.readString(key: UserStorageKeys.appOpenedCount);
    return int.parse(count ?? '0');
  }
}
