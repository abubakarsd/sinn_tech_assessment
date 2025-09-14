import 'package:equatable/equatable.dart';

// base class for all user events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// event to fetch the initial list of users
class FetchUsers extends UserEvent {}

// event to refresh the list of users
class RefreshUsers extends UserEvent {}

// event to search for users
class SearchUsers extends UserEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object> get props => [query];
}
