import 'messages_event.dart';
import 'messages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/services/firestore_service.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final FirestoreService _firestoreService;
  MessagesBloc(FirestoreService firestoreService)
      : assert(firestoreService != null),
        _firestoreService = firestoreService,
        super(MessagesLoading());

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    if (event is LoadMessages) {
      yield* _mapMessagesToState(event);
    }
  }

  Stream<MessagesState> _mapMessagesToState(LoadMessages event) async* {
    yield MessagesLoading();
    try {
      var stream = _firestoreService.getMessages(event.myId, event.userId);
      if (stream != null) {
        yield MessagesLoaded(messagesStream: stream);
      } else {
        yield MessagesError(error: 'Stream is empty');
      }
    } catch (e) {
      yield MessagesError(error: e);
    }
  }
}
