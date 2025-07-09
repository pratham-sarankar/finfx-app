import 'package:finfx/features/groups/domain/group.dart';

abstract class GroupRepository {
  Future<List<Group>> getGroups();
}
