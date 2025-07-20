import 'package:finfx/utils/api_error.dart';

class BotPackageModel {
  final String id;
  final BotInfo bot;
  final PackageInfo package;
  final int price;

  BotPackageModel({
    required this.id,
    required this.bot,
    required this.package,
    required this.price,
  });

  factory BotPackageModel.fromJson(Map<String, dynamic> json) {
    try {
      return BotPackageModel(
        id: json['id'] as String,
        bot: BotInfo.fromJson(json['bot'] as Map<String, dynamic>),
        package: PackageInfo.fromJson(json['package'] as Map<String, dynamic>),
        price: json['price'] as int,
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse bot package data: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bot': bot.toJson(),
      'package': package.toJson(),
      'price': price,
    };
  }
}

class BotInfo {
  final DateTime createdAt;
  final String description;
  final String name;
  final String performanceDuration;
  final int recommendedCapital;
  final String script;
  final DateTime updatedAt;
  final String id;

  BotInfo({
    required this.createdAt,
    required this.description,
    required this.name,
    required this.performanceDuration,
    required this.recommendedCapital,
    required this.script,
    required this.updatedAt,
    required this.id,
  });

  factory BotInfo.fromJson(Map<String, dynamic> json) {
    try {
      return BotInfo(
        createdAt: DateTime.parse(json['createdAt'] as String),
        description: json['description'] as String,
        name: json['name'] as String,
        performanceDuration: json['performanceDuration'] as String,
        recommendedCapital: json['recommendedCapital'] as int,
        script: json['script'] as String,
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        id: json['id'] as String,
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse bot info: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'name': name,
      'performanceDuration': performanceDuration,
      'recommendedCapital': recommendedCapital,
      'script': script,
      'updatedAt': updatedAt.toIso8601String(),
      'id': id,
    };
  }
}

class PackageInfo {
  final String name;
  final int duration;
  final String id;

  PackageInfo({
    required this.name,
    required this.duration,
    required this.id,
  });

  factory PackageInfo.fromJson(Map<String, dynamic> json) {
    try {
      return PackageInfo(
        name: json['name'] as String,
        duration: json['duration'] as int,
        id: json['id'] as String,
      );
    } catch (e) {
      throw ApiError.fromString('Failed to parse package info: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
      'id': id,
    };
  }
}
