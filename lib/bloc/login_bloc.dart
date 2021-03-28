import 'login_event.dart';
import 'login_state.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_bloc.dart';
import 'authentication_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthService _authService;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthService authService)
      : assert(authenticationBloc != null),
        assert(authService != null),
        _authenticationBloc = authenticationBloc,
        _authService = authService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      await _authService.login(event.email, event.password);
      final user = _authService.user;
      if (user != null) {
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await _authService.register(event.email, event.password);
        final user = _authService.user;
        if (user != null) {
          _authenticationBloc.add(UserLoggedIn(user: user));
          yield LoginSuccess();
          yield LoginInitial();
        } else {
          yield LoginFailure(error: 'Something very weird just happened');
        }
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
