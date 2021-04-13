import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UsersStreamEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRandomUsers extends UsersStreamEvent {}

class LoadSearchedUsers extends UsersStreamEvent {
  final String searchKey;

  LoadSearchedUsers({@required this.searchKey});

  @override
  List<Object> get props => [searchKey];
}
