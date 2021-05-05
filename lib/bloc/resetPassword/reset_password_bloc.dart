import 'reset_password_event.dart';
import 'reset_password_state.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, PasswordResetState> {
  final AuthService _authService;

  ResetPasswordBloc(AuthService authService)
      : assert(authService != null),
        _authService = authService,
        super(ResetPasswordInitial());

  @override
  Stream<PasswordResetState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is ForgetPassword) {
      yield* _mapForgetPasswordToState(event);
    }
  }

  Stream<PasswordResetState> _mapForgetPasswordToState(
      ForgetPassword event) async* {
    yield ResetPasswordInitial();
    try {
      String message;
      await _authService
          .forgotPassword(event.email)
          .then((value) => message = value);
      print(message);
      if (message == 'Email sent.') {
        yield PasswordSent(message: message);
      } else {
        yield PasswordSentError(message: message);
      }
    } catch (e) {
      yield PasswordSentError(message: 'Error: $e');
    }
  }
}
