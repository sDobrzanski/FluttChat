import 'package:flutter_bloc/flutter_bloc.dart';
import 'users_stream_event.dart';
import 'users_stream_state.dart';
import 'package:flutt_chat/services/firestore_service.dart';

class UsersStreamBloc extends Bloc<UsersStreamEvent, UsersStreamState> {
  final FirestoreService _firestoreService;

  UsersStreamBloc(FirestoreService firestoreService)
      : assert(firestoreService != null),
        _firestoreService = firestoreService,
        super(RandomUsersLoading());

  @override
  Stream<UsersStreamState> mapEventToState(UsersStreamEvent event) async* {
    if (event is LoadRandomUsers) {
      yield* _mapRandomUsersToState(event);
    }

    if (event is LoadSearchedUsers) {
      yield* _mapSearchedUsersToState(event);
    }
  }

  Stream<UsersStreamState> _mapRandomUsersToState(
      LoadRandomUsers event) async* {
    yield SearchedUsersLoading();
    try {
      var stream = _firestoreService.getUsers();
      if (stream != null) {
        yield RandomUsersLoaded(usersStream: stream);
      } else {
        yield RandomUsersError(error: 'Stream is empty');
      }
    } catch (e) {
      yield RandomUsersError(error: e);
    }
  }

  Stream<UsersStreamState> _mapSearchedUsersToState(
      LoadSearchedUsers event) async* {
    yield SearchedUsersLoading();
    try {
      var stream = _firestoreService.getSearchedUsers(event.searchKey);
      if (stream != null) {
        yield SearchedUsersLoaded(usersStream: stream);
      } else {
        yield SearchedUsersError(error: 'Stream is empty');
      }
    } catch (e) {
      yield SearchedUsersError(error: e);
    }
  }
}
