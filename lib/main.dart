import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/inicio_screen.dart';
import 'screens/crear_mazo_screen.dart';
import 'screens/ver_mazos_screen.dart';
import 'screens/crear_tarjeta_screen.dart';
import 'screens/ver_tarjetas_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards Estudio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange.shade700,
        colorScheme: ColorScheme.dark(
          primary: Colors.orange.shade700,
          secondary: Colors.orange.shade500,
          surface: Colors.grey.shade900,
          background: Colors.grey.shade900,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade700,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/inicio': (context) => InicioScreen(),
        '/crear_mazo': (context) => CrearMazoScreen(),
        '/ver_mazos': (context) => VerMazosScreen(),
        '/crear_tarjeta': (context) => CrearTarjetaScreen(),
        '/ver_tarjetas': (context) => VerTarjetasScreen(),
      },
    );
  }
}