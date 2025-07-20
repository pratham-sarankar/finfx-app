// Dart imports:
import 'dart:convert';

// Project imports:
import '../../../../services/api_service.dart';
import '../../../../utils/api_error.dart';
import '../../domain/models/broker_model.dart';

class BrokerService {
  final ApiService _apiService;

  BrokerService({
    required ApiService apiService,
  }) : _apiService = apiService;

  /// Fetch list of available brokers
  Future<List<BrokerModel>> getBrokers() async {
    try {
      final response = await _apiService.get('/api/brokers');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          final List<dynamic> brokersData = data['data'] as List<dynamic>;
          return brokersData
              .map((brokerJson) => BrokerModel.fromJson(brokerJson))
              .toList();
        } else {
          throw ApiError.fromMap(data);
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiError.fromMap(errorData);
      }
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.fromString('Failed to fetch brokers: ${e.toString()}');
    }
  }
}
