import 'package:finfx/features/brokers/data/services/platform_credentials_service.dart';
import 'package:finfx/features/brokers/domain/models/platform_credentials.dart';
import 'package:finfx/features/profile/presentation/providers/profile_provider.dart';
import 'package:finfx/services/auth_storage_service.dart';
import 'package:finfx/utils/api_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MT4Provider extends ChangeNotifier {
  final PlatformCredentialsService _platformCredentialsService;
  final ProfileProvider _profileProvider;

  MT4Provider({
    required PlatformCredentialsService platformCredentialsService,
    required AuthStorageService authStorage,
    required ProfileProvider profileProvider,
  })  : _platformCredentialsService = platformCredentialsService,
        _profileProvider = profileProvider;

  PlatformCredentials? _credentials;
  bool _isLoading = false;
  bool _isConnecting = false;
  bool _isInitialized = false;
  String? _error;

  // Getters
  PlatformCredentials? get credentials => _credentials;
  bool get isLoading => _isLoading;
  bool get isConnecting => _isConnecting;
  String? get error => _error;
  bool get isConnected => _credentials != null;
  bool get isInitialized => _isInitialized;

  /// Initialize the provider by loading stored credentials
  Future<void> initialize() async {
    // Prevent multiple initializations
    if (_isInitialized && _credentials != null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Ensure profile is loaded
      await _profileProvider.fetchProfile();
      final profile = _profileProvider.profile;

      if (profile != null) {
        final credentials = await _platformCredentialsService
            .getPlatformCredentials(profile.id);
        _credentials =
            credentials.where((cred) => cred.platformName == 'MT4').firstOrNull;
      }
      _isInitialized = true;
    } catch (e) {
      _error = 'Failed to load stored credentials';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Connect to MT4 with new credentials
  Future<bool> connect({
    required String broker,
    required String loginId,
    required String password,
    required String brokerServer,
  }) async {
    _isConnecting = true;
    _error = null;
    notifyListeners();

    try {
      // Ensure profile is loaded
      await _profileProvider.fetchProfile();
      final profile = _profileProvider.profile;

      if (profile == null) {
        _error = 'User not authenticated';
        return false;
      }

      final request = PlatformCredentialsRequest(
        userId: profile.id,
        platformName: 'MT4',
        credentials: {
          'broker': broker.trim(),
          'loginId': loginId.trim(),
          'password': password.trim(),
          'brokerServer': brokerServer.trim(),
        },
      );

      // Create or update credentials
      if (_credentials != null) {
        _credentials =
            await _platformCredentialsService.updatePlatformCredentials(
          _credentials!.id,
          request,
        );
      } else {
        _credentials = await _platformCredentialsService
            .createPlatformCredentials(request);
      }

      return true;
    } catch (e) {
      if (e is ApiError) {
        _error = e.message;
      } else {
        _error = 'Failed to connect to MT4: ${e.toString()}';
      }
      return false;
    } finally {
      _isConnecting = false;
      notifyListeners();
    }
  }

  /// Disconnect from MT4
  Future<void> disconnect() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (_credentials != null) {
        final profile = _profileProvider.profile;
        if (profile != null) {
          await _platformCredentialsService.deletePlatformCredentials(
            profile.id,
            'MT4',
          );
        }
        _credentials = null;
      }
      _error = null;
    } catch (e) {
      _error = 'Failed to disconnect: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update MT4 credentials
  Future<bool> updateCredentials({
    required String broker,
    required String loginId,
    required String password,
    required String brokerServer,
  }) async {
    if (_credentials == null) {
      _error = 'No MT4 credentials found';
      notifyListeners();
      return false;
    }

    _isConnecting = true;
    _error = null;
    notifyListeners();

    try {
      // Ensure profile is loaded
      await _profileProvider.fetchProfile();
      final profile = _profileProvider.profile;

      if (profile == null) {
        _error = 'User not authenticated';
        return false;
      }

      final request = PlatformCredentialsRequest(
        userId: profile.id,
        platformName: 'MT4',
        credentials: {
          'broker': broker.trim(),
          'loginId': loginId.trim(),
          'password': password.trim(),
          'brokerServer': brokerServer.trim(),
        },
      );

      _credentials =
          await _platformCredentialsService.updatePlatformCredentials(
        _credentials!.id,
        request,
      );

      return true;
    } catch (e) {
      if (e is ApiError) {
        _error = e.message;
      } else {
        _error = 'Failed to update MT4 credentials: ${e.toString()}';
      }
      return false;
    } finally {
      _isConnecting = false;
      notifyListeners();
    }
  }

  /// Clear any error messages
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Force refresh credentials (useful for manual refresh)
  Future<void> refresh() async {
    _isInitialized = false;
    await initialize();
  }
}
