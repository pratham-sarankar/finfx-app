// Project imports:
import 'package:finfx/features/home/data/models/bot_model.dart';
import 'package:finfx/utils/api_error.dart';

abstract class BotRepository {
  /// Fetches all available bots
  /// Returns a list of [BotModel] containing the bots data
  /// Throws [ApiError] if the request fails
  Future<List<BotModel>> getBots();
}
