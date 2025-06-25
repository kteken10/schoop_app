import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // Nécessaire pour debugPrint

import 'providers/auth_service.dart';
import 'wrapper/auth_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuration du filtrage des logs
  _configureDebugPrint();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MediaBlurApp(),
    ),
  );
}

void _configureDebugPrint() {
  if (kDebugMode) {
    // Sauvegarde de la fonction debugPrint originale
    final originalDebugPrint = debugPrint;
    
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null && !message.contains('I/MESA')) {
        originalDebugPrint(message, wrapWidth: wrapWidth);
      }
    };
  }
}

class MediaBlurApp extends StatelessWidget {
  const MediaBlurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Blur',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}