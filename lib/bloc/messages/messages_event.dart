import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class SendMessage extends MessagesEvent {
  final User user;
  final String userToId;
  final String message;
  SendMessage(
      {@required this.user, @required this.message, @required this.userToId});
  @override
  List<Object> get props => [user, userToId, message];
}
