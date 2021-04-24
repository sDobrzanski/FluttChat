import 'package:flutt_chat/bloc/authentication/authentication_bloc.dart';
import 'package:flutt_chat/bloc/chatsStream/chats_stream_bloc.dart';
import 'package:flutt_chat/bloc/chatsStream/chats_Stream_event.dart';
import 'package:flutt_chat/bloc/messages/messages_bloc.dart';
import 'package:flutt_chat/bloc/usersStream/users_stream_bloc.dart';
import 'package:flutt_chat/bloc/usersStream/users_stream_event.dart';
import 'package:flutt_chat/bloc/authentication/authentication_state.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'bloc/authentication/authentication_event.dart';
import 'package:flutt_chat/screens/login_screen.dart';
import 'package:flutt_chat/screens/main_screen.dart';
import 'package:flutt_chat/screens/profile_screen.dart';
import 'package:flutt_chat/screens/register_screen.dart';
import 'package:flutt_chat/screens/reset_password_screen.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/screens/users_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FacebookAuth.instance.webInitialize(
    appId: "462933764757668",
    cookie: true,
    xfbml: true,
    version: "v10.0",
  );
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => AuthService()),
      RepositoryProvider(create: (context) => FirestoreService()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) {
          final authService = RepositoryProvider.of<AuthService>(context);
          final firestoreService =
              RepositoryProvider.of<FirestoreService>(context);
          return AuthenticationBloc(authService, firestoreService)
            ..add(AppLoaded());
        }),
        BlocProvider<UsersStreamBloc>(create: (context) {
          final firestoreService =
              RepositoryProvider.of<FirestoreService>(context);
          return UsersStreamBloc(firestoreService)..add(LoadRandomUsers());
        }),
        BlocProvider<MessagesBloc>(create: (context) {
          final firestoreService =
              RepositoryProvider.of<FirestoreService>(context);
          return MessagesBloc(firestoreService);
        }),
        BlocProvider<ChatsStreamBloc>(create: (context) {
          final firestoreService =
              RepositoryProvider.of<FirestoreService>(context);
          return ChatsStreamBloc(firestoreService);
        }),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _chatsStreamBloc = BlocProvider.of<ChatsStreamBloc>(context);
    return MaterialApp(
        theme: ThemeData.light().copyWith(accentColor: Color(0xFF7C4DFF)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              _chatsStreamBloc.add(LoadUsers(id: state.user.uid));
              return UsersScreen(user: state.user);
            }
            return MainScreen();
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/resetPassword': (context) => ResetPasswordScreen(),
          '/users': (context) => UsersScreen(),
          '/profile': (context) => ProfileScreen(),
        });
  }
}
