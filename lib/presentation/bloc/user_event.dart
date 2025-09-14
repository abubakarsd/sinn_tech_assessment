import 'package:equatable/equatable.dart';

// The base class for all user events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch the initial list of users
class FetchUsers extends UserEvent {}

// Event to refresh the list of users
class RefreshUsers extends UserEvent {}

// Event to search for users
class SearchUsers extends UserEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object> get props => [query];
}