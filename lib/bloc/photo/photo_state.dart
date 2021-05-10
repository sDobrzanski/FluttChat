import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final String url;
  PhotoLoaded({@required this.url});

  @override
  List<Object> get props => [url];
}

class PhotoChanged extends PhotoState {
  final String url;
  PhotoChanged({@required this.url});

  @override
  List<Object> get props => [url];
}

class PhotoError extends PhotoState {
  final String error;
  PhotoError({@required this.error});
  @override
  List<Object> get props => [error];
}
