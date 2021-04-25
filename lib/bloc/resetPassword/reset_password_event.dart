import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ResetPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgetPassword extends ResetPasswordEvent {
  final String email;
  ForgetPassword({@required this.email});

  @override
  List<Object> get props => [email];
}
