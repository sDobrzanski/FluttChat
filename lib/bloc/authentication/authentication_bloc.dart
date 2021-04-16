import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/services/firestore_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  AuthenticationBloc(AuthService authService, FirestoreService firestoreService)
      : assert(authService != null),
        assert(firestoreService != null),
        _authService = authService,
        _firestoreService = firestoreService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      final currentUser = _authService.user;

      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await _authService.signOut();
    yield AuthenticationNotAuthenticated();
  }
}
