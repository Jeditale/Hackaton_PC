import 'package:flutter_test/flutter_test.dart';
import 'package:nirva/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('Login screen test', ($) async {
    // Launch the app
    await $.pumpWidgetAndSettle(MyApp());

    // Ensure we're on the login screen
    expect($(#emailField).exists, true);

    // Enter email and password
    await $(#emailField).enterText('test@example.com');
    await $(#passwordField).enterText('password123');

    // Tap the login button
    await $(#loginButton).tap();

    // Wait for navigation to the Home Screen
    await $.pumpAndSettle();

    // Verify navigation to the Main Menu
    expect($(#mainMenuTitle).text, 'Main Menu');
  });
}
