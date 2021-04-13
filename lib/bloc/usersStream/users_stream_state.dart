import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UsersStreamState extends Equatable {
  @override
  List<Object> get props => [];
}

class RandomUsersLoading extends UsersStreamState {}

class SearchedUsersLoading extends UsersStreamState {}

class RandomUsersLoaded extends UsersStreamState {
  final Stream usersStream;
  RandomUsersLoaded({@required this.usersStream}); // czy tu cos potrzeba?
  @override
  List<Object> get props => [usersStream];
}

class SearchedUsersLoaded extends UsersStreamState {
  final Stream usersStream;
  SearchedUsersLoaded({@required this.usersStream});
  @override
  List<Object> get props => [usersStream];
}

class RandomUsersError extends UsersStreamState {
  final String error;

  RandomUsersError({@required this.error});

  @override
  List<Object> get props => [error];
}

class SearchedUsersError extends UsersStreamState {
  final String error;

  SearchedUsersError({@required this.error});

  @override
  List<Object> get props => [error];
}
