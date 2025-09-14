import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';
import 'package:sinn_tech_assessment/domain/usecases/get_users_usecase.dart';
import 'package:sinn_tech_assessment/domain/usecases/search_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase _getUsersUseCase;
  final SearchUsersUseCase _searchUsersUseCase;

  List<UserEntity> _allUsers = [];

  UserBloc({
    required GetUsersUseCase getUsersUseCase,
    required SearchUsersUseCase searchUsersUseCase,
  }) : _getUsersUseCase = getUsersUseCase,
       _searchUsersUseCase = searchUsersUseCase,
       super(UserInitial()) {
    // Register event handlers
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  // To Handle the FetchUsers event
  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    // To initiate the loading state before fetching data
    emit(UserLoading());
    try {
      _allUsers = await _getUsersUseCase.execute();

      if (_allUsers.isEmpty) {
        emit(UserNoData());
      } else {
        // Since API doesn't support pagination, so i simulate it by loading a subset of the data initially
        final initialUsers = _allUsers.take(10).toList();
        emit(UserLoaded(users: initialUsers, hasMore: _allUsers.length > 10));
      }
    } catch (e) {
      // to show error state if fetching fails anytime
      emit(UserError(message: e.toString()));
    }
  }

  // RefreshUsers event
  Future<void> _onRefreshUsers(
    RefreshUsers event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      _allUsers = await _getUsersUseCase.execute();

      if (_allUsers.isEmpty) {
        emit(UserNoData());
      } else {
        final initialUsers = _allUsers.take(10).toList();
        emit(UserLoaded(users: initialUsers, hasMore: _allUsers.length > 10));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  // To handles the SearchUsers event
  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<UserState> emit,
  ) async {
    if (event.query.isEmpty) {
      final initialUsers = _allUsers.take(10).toList();
      emit(UserLoaded(users: initialUsers, hasMore: _allUsers.length > 10));
    } else {
      final filteredUsers = _allUsers.where((user) {
        final lowerCaseQuery = event.query.toLowerCase();
        return user.name.toLowerCase().contains(lowerCaseQuery) ||
            user.email.toLowerCase().contains(lowerCaseQuery);
      }).toList();

      if (filteredUsers.isEmpty) {
        emit(UserNoData());
      } else {
        emit(
          UserLoaded(users: filteredUsers, hasMore: false),
        ); // No pagination for search results
      }
    }
  }

  // Method for lazy loading
  void loadMoreUsers() {
    final currentState = state;
    if (currentState is UserLoaded && currentState.hasMore) {
      // This will calculate the number of items to load next
      final currentLength = currentState.users.length;
      final remainingUsers = _allUsers.skip(currentLength).toList();
      final newUsers = remainingUsers.take(10).toList();

      final updatedUsers = List<UserEntity>.from(currentState.users)
        ..addAll(newUsers);
      final hasMore = updatedUsers.length < _allUsers.length;

      emit(UserLoaded(users: updatedUsers, hasMore: hasMore));
    }
  }
}
