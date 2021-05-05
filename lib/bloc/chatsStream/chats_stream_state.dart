import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ChatsStreamState extends Equatable {
  const ChatsStreamState();

  @override
  List<Object> get props => [];
}

class ChatUsersLoading extends ChatsStreamState {}

class ChatUsersError extends ChatsStreamState {
  final String error;
  ChatUsersError({@required this.error});

  @override
  List<Object> get props => [error];
}

class ChatUsersLoaded extends ChatsStreamState {
  final Stream stream;
  ChatUsersLoaded({@required this.stream});

  @override
  List<Object> get props => [stream];
}
