// I made this abstract class in other to defining the contract for the API interaction
abstract class ApiService {
  Future<dynamic> getUsers();
}
