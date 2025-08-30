import 'package:finfx/utils/api_error.dart';
import 'package:finfx/features/subscriptions/data/models/subscription_bot_model.dart';
import 'package:finfx/features/subscriptions/data/models/subscription_user_model.dart';
import 'package:finfx/features/subscriptions/data/models/subscription_package_model.dart';

class SubscriptionModel {
  final String id;
  final String status;
  final double lotSize;
  final DateTime subscribedAt;
  final DateTime? expiresAt;
  final SubscriptionUserModel? user; // Made optional
  final SubscriptionBotModel bot;
  final SubscriptionPackageModel package;

  SubscriptionModel({
    required this.id,
    required this.status,
    required this.lotSize,
    required this.subscribedAt,
    this.expiresAt,
    this.user, // Made optional
    required this.bot,
    required this.package,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    try {
      // Validate required fields first
      if (json['id'] == null) throw Exception('Subscription ID is required');
      if (json['status'] == null) throw Exception('Subscription status is required');
      if (json['lotSize'] == null) throw Exception('Lot size is required');
      if (json['subscribedAt'] == null) throw Exception('Subscribed date is required');
      if (json['bot'] == null) throw Exception('Bot information is required');
      if (json['package'] == null) throw Exception('Package information is required');

      return SubscriptionModel(
        id: json['id'] as String,
        status: json['status'] as String,
        lotSize: (json['lotSize'] as num).toDouble(),
        subscribedAt: DateTime.parse(json['subscribedAt'] as String),
        expiresAt: json['expiresAt'] != null
            ? DateTime.parse(json['expiresAt'] as String)
            : null,
        user: json['user'] != null 
            ? SubscriptionUserModel.fromJson(json['user'] as Map<String, dynamic>)
            : null, // Handle null user field
        bot: SubscriptionBotModel.fromJson(json['bot'] as Map<String, dynamic>),
        package: SubscriptionPackageModel.fromJson(json['package'] as Map<String, dynamic>),
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse subscription data: $e\nJSON: $json');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'lotSize': lotSize,
      'subscribedAt': subscribedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'user': user?.toJson(), // Handle null user
      'bot': bot.toJson(),
      'package': package.toJson(),
    };
  }
}
