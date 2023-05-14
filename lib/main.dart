import 'package:e_commerce/models/globals.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/provider/theme_provider.dart';
import 'package:e_commerce/view/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/screens/splash_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prep = await SharedPreferences.getInstance();
  global.data = prep.getBool('data') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.red),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: Colors.amber,

        ),
        themeMode: (Provider.of<ThemeProvider>(context).isdrk)
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => home_page(),
          'splash_screen': (context) => splash_screen(),
        },
      ),
    ),
  );
}

