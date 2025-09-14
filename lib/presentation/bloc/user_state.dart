import 'package:equatable/equatable.dart';
import 'package:sinn_tech_assessment/domain/entities/user_entity.dart';

// base class for all user states
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

// Initial state before any data is loaded
class UserInitial extends UserState {}

// State when data is being fetched
class UserLoading extends UserState {}

// State when data has been successfully loaded
class UserLoaded extends UserState {
  final List<UserEntity> users;
  final bool hasMore;

  const UserLoaded({required this.users, this.hasMore = false});

  @override
  List<Object> get props => [users, hasMore];
}

// State when data fetching fails
class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}

// State when the list is empty
class UserNoData extends UserState {}
