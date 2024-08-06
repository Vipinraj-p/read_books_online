import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_books_online/presentation/login_screen.dart';
import 'package:read_books_online/service/home_book_provider.dart';
import 'package:read_books_online/service/search_books_provider.dart';
import 'package:read_books_online/service/search_button_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyA8WUx3cvJ8TgcsbRbZi9DmR2KHG4QMGwo',
    appId: 'com.example.read_books_online',
    messagingSenderId: '490209482416',
    projectId: 'read-books-online-ce221',
    storageBucket: 'read-books-online-ce221.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SearchButtonProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchBooksProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeBookProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                scaffoldBackgroundColor: const Color.fromARGB(255, 62, 62, 68),
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                    backgroundColor: Color.fromARGB(255, 35, 35, 37))),
            home: LoginScreen()));
  }
}
