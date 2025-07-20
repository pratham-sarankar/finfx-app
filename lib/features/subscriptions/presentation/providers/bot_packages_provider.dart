import 'package:flutter/foundation.dart';
import 'package:finfx/features/subscriptions/data/models/bot_package_model.dart';
import 'package:finfx/features/subscriptions/data/services/bot_packages_service.dart';
import 'package:finfx/utils/api_error.dart';

class BotPackagesProvider extends ChangeNotifier {
  final BotPackagesService _botPackagesService;

  BotPackagesProvider({
    required BotPackagesService botPackagesService,
  }) : _botPackagesService = botPackagesService;

  List<BotPackageModel> _packages = [];
  bool _isLoading = false;
  String? _error;
  String? _currentBotId;
  BotInfo? _currentBot;

  // Getters
  List<BotPackageModel> get packages => _packages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentBotId => _currentBotId;
  BotInfo? get currentBot => _currentBot;

  /// Fetch packages for a specific bot
  Future<void> fetchBotPackages(String botId) async {
    try {
      _isLoading = true;
      _error = null;
      _currentBotId = botId;
      notifyListeners();

      _packages = await _botPackagesService.fetchBotPackages(botId);

      // Set the current bot info from the first package (all packages have the same bot info)
      if (_packages.isNotEmpty) {
        _currentBot = _packages.first.bot;
      }
    } catch (e) {
      if (e is ApiError) {
        _error = e.message;
      } else {
        _error = 'Failed to fetch bot packages: ${e.toString()}';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Refresh packages for the current bot
  Future<void> refresh() async {
    if (_currentBotId != null) {
      await fetchBotPackages(_currentBotId!);
    }
  }
}
