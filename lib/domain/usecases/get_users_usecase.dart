import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';
import 'package:sinn_tech_assessment/domain/repositories/user_repository.dart';

// A use case is a specific task the app can perform.
// It orchestrates data from the repository to be used by the presentation layer.
class GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  Future<List<UserEntity>> execute() async {
    try {
      // Call the repository to get the list of users
      final users = await _userRepository.getUsers();
      return users;
    } catch (e) {
      // Re-throw the exception for the BLoC to handle
      throw Exception('Failed to get users from use case: $e');
    }
  }
}
