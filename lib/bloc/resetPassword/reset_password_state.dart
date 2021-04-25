import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PasswordResetState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends PasswordResetState {}

class PasswordSent extends PasswordResetState {
  final String message;

  PasswordSent({@required this.message});

  @override
  List<Object> get props => [message];
}

class PasswordSentError extends PasswordResetState {
  final String message;

  PasswordSentError({@required this.message});

  @override
  List<Object> get props => [message];
}
