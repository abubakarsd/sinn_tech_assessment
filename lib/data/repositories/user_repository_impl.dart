import 'package:sinn_tech_assessment/data/datasources/remote/user_remote_data_source.dart';
import 'package:sinn_tech_assessment/data/models/user_model.dart';
import 'package:sinn_tech_assessment/domain/repositories/user_repository.dart';

// Concrete implementation of the UserRepository interface
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final userModels = await _remoteDataSource.getUsers();
      return userModels;
    } catch (e) {
      // Re-throw the exception to be handled by the use case
      throw Exception('Failed to fetch users from the repository: $e');
    }
  }
}
