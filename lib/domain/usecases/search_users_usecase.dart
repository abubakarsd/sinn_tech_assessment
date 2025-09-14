import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';
import 'package:sinn_tech_assessment/domain/repositories/user_repository.dart';

// for searching users
class SearchUsersUseCase {
  final UserRepository _userRepository;

  SearchUsersUseCase(this._userRepository);

  Future<List<UserEntity>> execute(String query) async {
    try {
      // To get all users from the repository
      final allUsers = await _userRepository.getUsers();
      // To filter the list based on the search query
      final filteredUsers = allUsers.where((user) {
        final lowerCaseQuery = query.toLowerCase();
        return user.name.toLowerCase().contains(lowerCaseQuery) ||
            user.email.toLowerCase().contains(lowerCaseQuery);
      }).toList();
      return filteredUsers;
    } catch (e) {
      throw Exception('Failed to search users from use case: $e');
    }
  }
}
