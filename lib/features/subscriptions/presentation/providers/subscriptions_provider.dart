import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:finfx/features/subscriptions/data/models/subscription_model.dart';
import 'package:finfx/services/api_service.dart';

class SubscriptionsProvider extends ChangeNotifier {
  final ApiService _apiService;

  SubscriptionsProvider(this._apiService);

  List<SubscriptionModel> _subscriptions = [];
  bool _isLoading = false;
  String? _error;
  String? _currentStatus;
  bool _isSubscribing = false;
  String? _subscribeError;

  List<SubscriptionModel> get subscriptions => _subscriptions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentStatus => _currentStatus;
  bool get isSubscribing => _isSubscribing;
  String? get subscribeError => _subscribeError;

  Future<bool> subscribeToBot({
    required String botId,
    required int lotSize,
    required String botPackageId,
  }) async {
    _isSubscribing = true;
    _subscribeError = null;
    notifyListeners();
    try {
      final body = jsonEncode({
        'botId': botId,
        'lotSize': lotSize,
        'botPackageId': botPackageId,
      });
      final response = await _apiService.post('/api/subscriptions', body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final errorData = json.decode(response.body);
        _subscribeError = errorData['message'] ?? 'Failed to subscribe';
        return false;
      }
    } catch (e) {
      _subscribeError = e.toString();
      return false;
    } finally {
      _isSubscribing = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubscriptions({String? status}) async {
    try {
      _isLoading = true;
      _error = null;
      _currentStatus = status;
      notifyListeners();

      String endpoint = '/api/subscriptions';
      if (status != null && status != 'all') {
        endpoint += '?status=$status';
      }

      final response = await _apiService.get(endpoint);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success') {
          final subscriptionsList = data['data'] as List;
          _subscriptions = subscriptionsList
              .map((subJson) => SubscriptionModel.fromJson(subJson))
              .toList();
        } else {
          _error = data['message'] ?? 'Failed to fetch subscriptions';
        }
      } else {
        _error = 'Failed to fetch subscriptions: ${response.statusCode}';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateSubscriptionStatus(String subscriptionId, String status,
      {double? lotSize}) async {
    try {
      final body = jsonEncode({
        'status': status,
        if (lotSize != null) 'lotSize': lotSize,
      });

      final response = await _apiService.put(
        '/api/subscriptions/$subscriptionId',
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success') {
          // Update the subscription status in the list
          final index =
              _subscriptions.indexWhere((sub) => sub.id == subscriptionId);
          if (index != -1) {
            final existingSubscription = _subscriptions[index];
            final updatedSubscription = SubscriptionModel(
              id: existingSubscription.id,
              userId: existingSubscription.userId,
              status: status,
              lotSize: lotSize ?? existingSubscription.lotSize,
              subscribedAt: existingSubscription.subscribedAt,
              createdAt: existingSubscription.createdAt,
              updatedAt: DateTime.now(),
              cancelledAt: existingSubscription.cancelledAt,
              expiresAt: existingSubscription.expiresAt,
              bot: existingSubscription.bot,
            );
            _subscriptions[index] = updatedSubscription;
            notifyListeners();
          }
          return true;
        } else {
          _error = data['message'] ?? 'Failed to update subscription status';
          notifyListeners();
          return false;
        }
      } else if (response.statusCode == 404) {
        _error = 'Subscription not found';
        notifyListeners();
        return false;
      } else if (response.statusCode == 400) {
        _error = 'Bad request: ${response.body}';
        notifyListeners();
        return false;
      } else if (response.statusCode == 401) {
        _error = 'Unauthorized: Please log in again';
        notifyListeners();
        return false;
      } else if (response.statusCode == 403) {
        _error =
            'Forbidden: You do not have permission to update this subscription';
        notifyListeners();
        return false;
      } else {
        _error =
            'Failed to update subscription status: ${response.statusCode} - ${response.body}';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  List<SubscriptionModel> getSubscriptionsByStatus(String status) {
    if (status == 'all') {
      return _subscriptions;
    }
    return _subscriptions.where((sub) => sub.status == status).toList();
  }
}
