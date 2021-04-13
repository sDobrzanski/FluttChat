import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMessages extends MessagesEvent {
  final String myId;
  final String userId;

  LoadMessages({@required this.myId, @required this.userId});

  @override
  List<Object> get props => [myId, userId];
}
