import 'package:finfx/features/brokers/data/services/platform_credentials_service.dart';
import 'package:finfx/features/brokers/domain/models/platform_credentials.dart';
import 'package:finfx/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/foundation.dart';

class BrokerCredentialsManager extends ChangeNotifier {
  final PlatformCredentialsService _platformCredentialsService;
  final ProfileProvider _profileProvider;

  BrokerCredentialsManager({
    required PlatformCredentialsService platformCredentialsService,
    required ProfileProvider profileProvider,
  })  : _platformCredentialsService = platformCredentialsService,
        _profileProvider = profileProvider;

  List<PlatformCredentials> _credentials = [];
  bool _isLoading = false;
  bool _isInitialized = false;
  String? _error;

  // Getters
  List<PlatformCredentials> get credentials => _credentials;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isInitialized => _isInitialized;

  // Helper methods to get specific platform credentials
  PlatformCredentials? getMT4Credentials() {
    return _credentials.where((cred) => cred.platformName == 'MT4').firstOrNull;
  }

  PlatformCredentials? getMT5Credentials() {
    return _credentials.where((cred) => cred.platformName == 'MT5').firstOrNull;
  }

  bool get isMT4Connected => getMT4Credentials() != null;
  bool get isMT5Connected => getMT5Credentials() != null;

  /// Initialize the manager by loading all platform credentials
  Future<void> initialize() async {
    // Prevent multiple initializations
    if (_isInitialized && _credentials.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ensure profile is loaded
      await _profileProvider.fetchProfile();
      final profile = _profileProvider.profile;

      if (profile != null) {
        _credentials = await _platformCredentialsService
            .getPlatformCredentials(profile.id);
      }
      _isInitialized = true;
    } catch (e) {
      _error = 'Failed to load platform credentials';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh all credentials
  Future<void> refresh() async {
    _isInitialized = false;
    await initialize();
  }

  /// Add or update credentials
  void updateCredentials(PlatformCredentials credentials) {
    final index = _credentials.indexWhere((cred) => cred.id == credentials.id);
    if (index != -1) {
      _credentials[index] = credentials;
    } else {
      _credentials.add(credentials);
    }
    notifyListeners();
  }

  /// Remove credentials
  void removeCredentials(String platformName) {
    _credentials.removeWhere((cred) => cred.platformName == platformName);
    notifyListeners();
  }

  /// Clear any error messages
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
