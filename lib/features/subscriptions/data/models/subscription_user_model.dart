import 'package:finfx/utils/api_error.dart';

class SubscriptionUserModel {
  final String id;
  final String fullName;
  final String email;

  SubscriptionUserModel({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory SubscriptionUserModel.fromJson(Map<String, dynamic> json) {
    try {
      return SubscriptionUserModel(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        email: json['email'] as String,
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse subscription user data: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }
}
