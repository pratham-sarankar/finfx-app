import 'package:finfx/utils/api_error.dart';

class SubscriptionBotModel {
  final String id;
  final String name;
  final String description;

  SubscriptionBotModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory SubscriptionBotModel.fromJson(Map<String, dynamic> json) {
    try {
      return SubscriptionBotModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse subscription bot data: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
