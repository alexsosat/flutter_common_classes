import "package:flutter_secure_storage/flutter_secure_storage.dart";

/// A service that provides a secure storage for the application.
class SecureStorageService {
  /// Initializes the secure storage service
  static FlutterSecureStorage initializeStorage({
    required String storageName,
    required SecurityAccessLevel unlockOption,
  }) => switch (unlockOption) {
    SecurityAccessLevel.none => FlutterSecureStorage(
      iOptions: _iOSBasicOptions,
      aOptions: _androidBasicOptions,
    ),
    SecurityAccessLevel.device => FlutterSecureStorage(
      iOptions: _iOSDeviceAuthOptions,
      aOptions: _androidDeviceAuthOptions,
    ),
    SecurityAccessLevel.biometric => FlutterSecureStorage(
      iOptions: _iOSDeviceAuthOptions,
      aOptions: _androidBiometricAuthOptions,
    ),
  };

  /// Basic configuration for Android secure storage
  static const AndroidOptions _androidBasicOptions = AndroidOptions(
    storageNamespace: "basic_storage",
    migrateOnAlgorithmChange: true,
    resetOnError: true,
  );

  /// Android options with required device authentication
  static AndroidOptions get _androidDeviceAuthOptions =>
      AndroidOptions.biometric(
        storageNamespace: "device_auth_storage",
        enforceBiometrics: true,
        resetOnError: true,
        migrateOnAlgorithmChange: true,
        biometricType: AndroidBiometricType.biometricOrDeviceCredential,
      );

  /// Android options with required biometric authentication
  static AndroidOptions get _androidBiometricAuthOptions =>
      AndroidOptions.biometric(
        storageNamespace: "biometric_auth_storage",
        enforceBiometrics: true,
        resetOnError: true,
        migrateOnAlgorithmChange: true,
        biometricType: AndroidBiometricType.strongBiometricOnly,
        biometricPromptNegativeButton: "Cancel",
      );

  /// Basic configuration for iOS secure storage
  static const IOSOptions _iOSBasicOptions = IOSOptions(
    accountName: "basic_storage",
    accessibility: KeychainAccessibility.first_unlock,
  );

  /// iOS options with required device authentication
  static const IOSOptions _iOSDeviceAuthOptions = IOSOptions(
    accountName: "device_auth_storage",
    accessibility: KeychainAccessibility.passcode,
    useSecureEnclave: true,
  );
}

enum SecurityAccessLevel {
  /// No security required, data is accessible without authentication
  none,

  /// Device security required, data is accessible
  /// through any means (PIN, Pattern, Password, etc.)
  device,

  /// Biometric security required
  biometric,
}
