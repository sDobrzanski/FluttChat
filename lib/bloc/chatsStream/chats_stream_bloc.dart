import 'chats_Stream_event.dart';
import 'chats_stream_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/services/firestore_service.dart';

class ChatsStreamBloc extends Bloc<ChatsStreamEvent, ChatsStreamState> {
  final FirestoreService _firestoreService;
  ChatsStreamBloc(FirestoreService firestoreService)
      : assert(firestoreService != null),
        _firestoreService = firestoreService,
        super(ChatUsersLoading());

  @override
  Stream<ChatsStreamState> mapEventToState(ChatsStreamEvent event) async* {
    if (event is LoadUsers) {
      yield* _mapUsersToState(event);
    }
  }

  Stream<ChatsStreamState> _mapUsersToState(LoadUsers event) async* {
    yield ChatUsersLoading();
    try {
      var stream = _firestoreService.getChats(event.id);
      if (stream != null) {
        yield ChatUsersLoaded(stream: stream);
      } else {
        yield ChatUsersError(
            error: 'Stream is empty'); // moze trzeba bedzie zmienic
      }
    } catch (e) {
      yield ChatUsersError(error: 'Error: $e');
    }
  }
}
