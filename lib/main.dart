import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_times/local_storages/share_pref.dart';
import 'package:world_times/pages/homepage.dart';
import 'package:world_times/pages/login.dart';
import 'package:world_times/provider/userprovider.dart';
import 'package:world_times/src/features/presntations/providers/postprovider.dart';
import 'package:world_times/src/utils/theme/theme.dart';

// import 'package:world_times/pages/splashscreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    LocalStorage.saveThemePreference('mode', _isDark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider())
      ],
      child: MaterialApp(
          theme: HAppTheme.lightTheme,
          darkTheme: HAppTheme.darkTheme,
          themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: Wrapper()),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoggedIn) {
            return HomeScreen(username: "");
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
