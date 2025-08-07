// Dart imports:
import 'dart:convert';

// Project imports:
import '../../../../services/api_service.dart';
import '../../../../utils/api_error.dart';
import '../models/bot_subscription_status.dart';

class BotSubscriptionService {
  final ApiService _apiService;

  BotSubscriptionService({
    required ApiService apiService,
  }) : _apiService = apiService;

  /// Check subscription status for a specific bot
  Future<BotSubscriptionStatus> checkSubscriptionStatus(String botId) async {
    try {
      final response = await _apiService.get('/api/subscriptions/check/$botId');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return BotSubscriptionStatus.fromJson(data['data']);
        } else {
          throw ApiError.fromMap(data);
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString(
          'Failed to check subscription status: ${e.toString()}');
    }
  }

  /// Subscribe to a bot
  Future<BotSubscriptionStatus> subscribeToBot(
      String botId, String botPackageId, double lotSize) async {
    try {
      final response = await _apiService.post(
        '/api/subscriptions',
        body: jsonEncode({
          'botId': botId,
          'botPackageId': botPackageId,
          'lotSize': lotSize,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return checkSubscriptionStatus(botId);
        } else {
          throw ApiError.fromMap(data);
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString('Failed to subscribe to bot: ${e.toString()}');
    }
  }

  /// Update subscription status (pause/reactivate)
  Future<BotSubscriptionStatus> updateSubscriptionStatus(
      String subscriptionId, String status, String botId,
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
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          // Get the updated subscription status
          return await checkSubscriptionStatus(botId);
        } else {
          throw ApiError.fromMap(data);
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString(
          'Failed to update subscription status: ${e.toString()}');
    }
  }
}
