import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:finfx/features/home/data/models/bot_model.dart';
import 'package:finfx/utils/api_error.dart';
import 'package:finfx/features/home/domain/repositories/bot_repository.dart';

class BotProvider extends ChangeNotifier {
  final BotRepository _repository;
  List<BotModel> _bots = [
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'XAU/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Commodities',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'XAG/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Commodities',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'Crudeoil',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Commodities',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'EUR/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Currency',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'JPY/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Currency',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'AUD/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Currency',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'Apple',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Stocks',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'Amazon',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Stocks',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'Microsoft',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Stocks',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'BTC/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Crypto',
    ),
    BotModel(
      id: '68551d5cb15e0643f8657a3f',
      name: 'ETH/USD',
      html: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      group: 'Crypto',
    ),
  ];
  bool _isLoading = false;
  String? _error;

  BotProvider(this._repository);

  List<BotModel> get bots => _bots;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBots({bool force = false}) async {
    if (_bots.isNotEmpty && !force)
      return; // Return cached bots if available and not forcing refresh

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bots = await _repository.getBots();
    } on ApiError catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearBots() {
    _bots = [];
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
