import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:media_blur_app/main.dart';
import 'package:media_blur_app/providers/auth_service.dart';
import 'package:media_blur_app/wrapper/auth_wrapper.dart';

void main() {
  testWidgets('AuthWrapper renders correctly for unauthenticated user', 
      (WidgetTester tester) async {
    // Créer un mock AuthService
    final authService = AuthService();
    
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>.value(value: authService),
        ],
        child: const MediaBlurApp(),
      ),
    );

    // Vérifier que l'AuthWrapper est bien présent
    expect(find.byType(AuthWrapper), findsOneWidget);
    
    // Vérifier que le titre de l'application est correct
    expect(find.text('Media Blur'), findsNothing); // Le titre est dans l'AppBar
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('App theme is properly configured', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
        ],
        child: const MediaBlurApp(),
      ),
    );

    // Vérifier la police par défaut
    final textWidget = tester.widget<Text>(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(Text),
      ),
    );
    
    expect(textWidget.style?.fontFamily, 'Montserrat');
    
    // Vérifier que le mode debug est désactivé
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.debugShowCheckedModeBanner, false);
  });
}