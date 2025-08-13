import "package:flutter_secure_storage/flutter_secure_storage.dart";

/// A service that provides a secure storage for the application.
class SecureStorageService {
  /// Initializes the secure storage service
  static FlutterSecureStorage get initializeStorage =>
      const FlutterSecureStorage(
        iOptions: _iOSOptions,
        aOptions: _androidOptions,
      );

  ///Sets the android options for the secure storage service
  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    resetOnError: true,
  );

  ///Sets the ios options for the secure storage service
  static const IOSOptions _iOSOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
}
