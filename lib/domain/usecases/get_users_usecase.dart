import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';
import 'package:sinn_tech_assessment/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;
  GetUsersUseCase(this._userRepository);
  Future<List<UserEntity>> execute() async {
    try {
      // Calling the repository to get the list of users
      final users = await _userRepository.getUsers();
      return users;
    } catch (e) {
      // Re-throw the exception for the BLoC to handle
      throw Exception('Failed to get users from use case: $e');
    }
  }
}
