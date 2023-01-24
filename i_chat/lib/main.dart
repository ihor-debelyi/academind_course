import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_chat/screens/auth_screen.dart';
import 'package:i_chat/screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          backgroundColor: const Color.fromRGBO(51, 58, 67, 1),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: const Color.fromRGBO(229, 75, 43, 1),
                brightness: Brightness.dark,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(229, 75, 43, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromRGBO(229, 75, 43, 1),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            alignLabelWithHint: false,
            labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 185, 39, 9)),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 0.5, color: Color.fromARGB(255, 185, 39, 9)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          )
          // backgroundColor: const Color.fromRGBO(24, 28, 31, 1),
          ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
