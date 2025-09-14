import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';

// This is the contract for the Data layer
abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
}
