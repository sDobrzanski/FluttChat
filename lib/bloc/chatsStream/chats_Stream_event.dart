import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ChatsStreamEvent extends Equatable {
  const ChatsStreamEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends ChatsStreamEvent {
  final String id;

  LoadUsers({@required this.id});

  @override
  List<Object> get props => [];
}
