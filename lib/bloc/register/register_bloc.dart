import 'register_event.dart';
import 'register_state.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication_bloc.dart';
import '../authentication/authentication_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutter/material.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthService _authService;
  final FirestoreService _firestoreService;

  RegisterBloc(AuthenticationBloc authenticationBloc, AuthService authService,
      FirestoreService firestoreService)
      : assert(authenticationBloc != null),
        assert(authService != null),
        assert(firestoreService != null),
        _authenticationBloc = authenticationBloc,
        _authService = authService,
        _firestoreService = firestoreService,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterWithEmailButtonPressed) {
      yield* _mapRegisterWithEmailToState(event);
    }

    if (event is SignInWithFacebook) {
      yield* _mapSignInFacebookToState(event);
    }

    if (event is SignInWithGoogle) {
      yield* _mapSignInGoogleToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterWithEmailToState(
      RegisterWithEmailButtonPressed event) async* {
    yield RegisterLoading();
    try {
      await _authService.register(event.email, event.password);
      final user = _authService.user;
      if (user != null) {
        await _firestoreService.saveUser(user.uid, user.email);
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something very weird just happened');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (err) {
      yield RegisterFailure(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<RegisterState> _mapSignInFacebookToState(
      SignInWithFacebook event) async* {
    yield RegisterLoading();
    try {
      await _authService.facebookLogin();
      final user = _authService.user;
      if (user != null) {
        await _firestoreService.saveUser(user.uid, user.email);
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something very weird just happened');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (err) {
      yield RegisterFailure(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<RegisterState> _mapSignInGoogleToState(SignInWithGoogle event) async* {
    yield RegisterLoading();
    try {
      await _authService.googleSignIn();
      final user = _authService.user;
      if (user != null) {
        await _firestoreService.saveUser(user.uid, user.email);
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something very weird just happened');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (err) {
      yield RegisterFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
