import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_event.dart';
import 'photo_state.dart';
import 'package:flutt_chat/constants.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final FirestoreService _firestoreService;
  PhotoBloc(FirestoreService firestoreService)
      : assert(firestoreService != null),
        _firestoreService = firestoreService,
        super(PhotoLoading());

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    if (event is LoadPhoto) {
      yield* _mapLoadPhotoToState(event);
    }
    if (event is ChangePhoto) {
      yield* _mapChangePhotoToState(event);
    }
  }

  Stream<PhotoState> _mapLoadPhotoToState(LoadPhoto event) async* {
    String url;
    yield PhotoLoading();
    try {
      await _firestoreService
          .getPhotoUrl(event.uid)
          .then((value) => url = value);
      if (url == null) {
        url = kEmptyUserPhoto;
      }
      yield PhotoLoaded(url: url);
    } catch (e) {
      yield PhotoError(error: 'Error: $e');
    }
  }

  Stream<PhotoState> _mapChangePhotoToState(ChangePhoto event) async* {
    String url;
    yield PhotoLoading();
    try {
      await _firestoreService.uploadToStorage(event.uid);
      await _firestoreService
          .getPhotoUrl(event.uid)
          .then((value) => url = value);
      if (url == null) {
        url = kEmptyUserPhoto;
      }
      yield PhotoLoaded(url: url);
    } catch (e) {
      yield PhotoError(error: 'Error: $e');
    }
  }
}
