import 'package:sinn_tech_assessment/core/api/api_client.dart';
import 'package:sinn_tech_assessment/core/constants/app_urls.dart';
import 'package:sinn_tech_assessment/core/services/api_service.dart';
import 'package:sinn_tech_assessment/data/models/user_model.dart';

class UserRemoteDataSource implements ApiService {
  final ApiClient _apiClient;

  UserRemoteDataSource(this._apiClient);

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _apiClient.get(AppUrls.users);
      // The API returns a list of maps for me to map them to the UserModel
      return (response as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
