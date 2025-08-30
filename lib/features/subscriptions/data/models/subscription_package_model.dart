import 'package:finfx/utils/api_error.dart';

class SubscriptionPackageModel {
  final String id;
  final String name;
  final int duration;
  final int price;

  SubscriptionPackageModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
  });

  factory SubscriptionPackageModel.fromJson(Map<String, dynamic> json) {
    try {
      return SubscriptionPackageModel(
        id: json['id'] as String,
        name: json['name'] as String,
        duration: json['duration'] as int,
        price: json['price'] as int,
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse subscription package data: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'price': price,
    };
  }
}
