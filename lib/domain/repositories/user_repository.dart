import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';

// The abstract repository interface. This is the contract for the Data layer.
// It lives in the Domain layer because business logic should not depend on
// a concrete implementation.
abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
}
