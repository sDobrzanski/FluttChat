import 'package:flutt_chat/bloc/authentication/authentication_bloc.dart';
import 'package:flutt_chat/bloc/login/login_bloc.dart';
import 'package:flutt_chat/bloc/authentication/authentication_state.dart';
import 'package:flutt_chat/bloc/login/login_event.dart';
import 'package:flutt_chat/bloc/login/login_state.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/buttons/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/text_fields/input_text_field.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/screens/users_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationNotAuthenticated) {
                return AuthForm();
              }

              if (state is AuthenticationFailure) {
                return Text('Please retry'); //TODO zrobic tu alert box
              }

              if (state is AuthenticationAuthenticated) {
                //return Center(child: CircularProgressIndicator());
                return UsersScreen(
                  //TODO moze trzeba bedzie zmienic
                  user: state.user,
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}

class AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final authService = RepositoryProvider.of<AuthService>(context);
    final firestoreService = RepositoryProvider.of<FirestoreService>(context);

    return Container(
      child: BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(authBloc, authService, firestoreService),
          child: SignInForm()),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        print(state.error);
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 250,
            height: 250,
            child: Hero(
              tag: 'logo',
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          AnimatingName(),
          InputTextField(
              hintText: 'Enter you email',
              isPassword: false,
              icon: Icons.email,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              }),
          SizedBox(
            height: 15,
          ),
          InputTextField(
              hintText: 'Enter you password',
              isPassword: true,
              icon: Icons.lock,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              }),
          SizedBox(
            height: 30,
          ),
          LoginButton(
              text: 'Login',
              color: Colors.purpleAccent,
              onPressed: () {
                _loginBloc.add(LoginInWithEmailButtonPressed(
                    email: email, password: password));
              }),
        ],
      );
    }));
  }
}
