import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterWithEmailButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithEmailButtonPressed(
      {@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
