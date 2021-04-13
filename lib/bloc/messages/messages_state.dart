import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MessagesState extends Equatable {
  @override
  List<Object> get props => [];
}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final Stream messagesStream;
  MessagesLoaded({@required this.messagesStream});
  @override
  List<Object> get props => [messagesStream];
}

class MessagesError extends MessagesState {
  final String error;

  MessagesError({@required this.error});

  @override
  List<Object> get props => [error];
}
