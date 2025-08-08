import 'dart:convert';

import '../../../../services/api_service.dart';
import '../../../../utils/api_error.dart';
import '../../domain/models/platform_credentials.dart';

class PlatformCredentialsService {
  final ApiService _apiService;

  PlatformCredentialsService({
    required ApiService apiService,
  }) : _apiService = apiService;

  /// Fetch all platform credentials for a user
  Future<List<PlatformCredentials>> getPlatformCredentials(
      String userId) async {
    try {
      final response =
          await _apiService.get('/api/platformCredentials?userId=$userId');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final List<dynamic> credentialsData = data['data'] as List<dynamic>;
          return credentialsData
              .map((credentialJson) =>
                  PlatformCredentials.fromJson(credentialJson))
              .toList();
        } else {
          throw ApiError.fromMap(data);
        }
      } else if (response.statusCode == 404) {
        // No credentials found, return empty list
        return [];
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString(
          'Failed to fetch platform credentials: ${e.toString()}');
    }
  }

  /// Create new platform credentials
  Future<PlatformCredentials> createPlatformCredentials(
      PlatformCredentialsRequest request) async {
    try {
      final response = await _apiService.post(
        '/api/platformCredentials/',
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          return PlatformCredentials.fromJson(data['data']);
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
          'Failed to create platform credentials: ${e.toString()}');
    }
  }

  /// Update existing platform credentials
  Future<PlatformCredentials> updatePlatformCredentials(
      String id, PlatformCredentialsRequest request) async {
    try {
      final response = await _apiService.put(
        '/api/platformCredentials/$id',
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          return PlatformCredentials.fromJson(data['data']);
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
          'Failed to update platform credentials: ${e.toString()}');
    }
  }

  /// Delete platform credentials
  Future<void> deletePlatformCredentials(
      String userId, String platformName) async {
    try {
      final response = await _apiService
          .delete('/api/platformCredentials/$userId/$platformName');

      if (response.statusCode != 200 && response.statusCode != 204) {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString(
          'Failed to delete platform credentials: ${e.toString()}');
    }
  }
}
