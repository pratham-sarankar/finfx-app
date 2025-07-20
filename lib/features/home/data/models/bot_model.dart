// Project imports:
import 'package:finfx/utils/api_error.dart';

class BotModel {
  final String id;
  final String name;
  final String description;
  final String performanceDuration;
  final int recommendedCapital;
  final String script;
  final DateTime createdAt;
  final DateTime updatedAt;

  BotModel({
    required this.id,
    required this.name,
    required this.description,
    required this.performanceDuration,
    required this.recommendedCapital,
    required this.script,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BotModel.fromJson(Map<String, dynamic> json) {
    try {
      return BotModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        performanceDuration: json['performanceDuration'] as String,
        recommendedCapital: json['recommendedCapital'] as int,
        script: json['script'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse bot data');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'performanceDuration': performanceDuration,
      'recommendedCapital': recommendedCapital,
      'script': script,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
