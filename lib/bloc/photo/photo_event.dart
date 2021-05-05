import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPhoto extends PhotoEvent {
  final String uid;
  LoadPhoto({this.uid});

  @override
  List<Object> get props => [uid];
}

class ChangePhoto extends PhotoEvent {
  final String uid;
  ChangePhoto({this.uid});

  @override
  List<Object> get props => [uid];
}
