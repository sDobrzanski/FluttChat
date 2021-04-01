import 'package:flutt_chat/screens/login_screen.dart';
import 'package:flutt_chat/screens/main_screen.dart';
import 'package:flutt_chat/screens/profile_screen.dart';
import 'package:flutt_chat/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/screens/chat_screen.dart';
import 'package:flutt_chat/screens/users_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FacebookAuth.instance.webInitialize(
    appId: "462933764757668",
    cookie: true,
    xfbml: true,
    version: "v10.0",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.light().copyWith(accentColor: Color(0xFF7C4DFF)),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/users': (context) => UsersScreen(),
        '/chat': (context) => ChatScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
