import 'dart:convert';
import 'package:finfx/services/api_service.dart';
import 'package:finfx/utils/api_error.dart';
import '../models/bot_package_model.dart';

class BotPackagesService {
  final ApiService _apiService;

  BotPackagesService({
    required ApiService apiService,
  }) : _apiService = apiService;

  /// Fetch packages for a specific bot
  Future<List<BotPackageModel>> fetchBotPackages(String botId) async {
    try {
      final response = await _apiService.get('/api/botPackages/bot/$botId');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final packagesList = data['data'] as List;
          return packagesList
              .map((packageJson) => BotPackageModel.fromJson(packageJson))
              .toList();
        } else {
          throw ApiError.fromString(
              data['message'] ?? 'Failed to fetch bot packages');
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString(
          'Failed to fetch bot packages: ${e.toString()}');
    }
  }
}
