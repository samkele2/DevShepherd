import 'package:flutter_test/flutter_test.dart';
import 'package:dev_shepherd/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'fake_auth_service.dart';

void main() {
  testWidgets('AuthPage displays email and password fields', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: FakeAuthService(),
        ),
      ),
    );

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('AuthPage displays Sign Up and Login buttons', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: FakeAuthService(),
        ),
      ),
    );

    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
  testWidgets('Sign Up button calls auth service', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    expect(
      fakeAuthService.signUpCalled,
      true,
    );
  });
  testWidgets('Login button calls auth service', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(
      fakeAuthService.loginCalled,
      true,
    );
  });
  testWidgets('Sign Up passes email and password to auth service', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextField).at(0),
      'samkele@example.com',
    );

    await tester.enterText(
      find.byType(TextField).at(1),
      'password123',
    );

    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    expect(fakeAuthService.signUpEmail, 'samkele@example.com');
    expect(fakeAuthService.signUpPassword, 'password123');
  });
  testWidgets('Login passes email and password to auth service', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextField).at(0),
      'samkele@example.com',
    );

    await tester.enterText(
      find.byType(TextField).at(1),
      'password123',
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(fakeAuthService.loginEmail, 'samkele@example.com');
    expect(fakeAuthService.loginPassword, 'password123');
  });
  testWidgets('shows error message when login fails', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(
      find.text('Login failed. Please check your email and password.'),
      findsOneWidget,
    );
  });
  testWidgets('shows error message when sign up fails', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    expect(
      find.text('Sign up failed. Please try again.'),
      findsOneWidget,
    );
  });
  testWidgets('stays on AuthPage when login fails', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(
      find.text('DevShepherd Login'),
      findsOneWidget,
    );

    expect(
      find.text('Dev Shepherd Home Page'),
      findsNothing,
    );
  });
  testWidgets('stays on AuthPage when sign up fails', (tester) async {
    final fakeAuthService = FakeAuthService();

    await tester.pumpWidget(
      MaterialApp(
        home: AuthPage(
          authService: fakeAuthService,
        ),
      ),
    );

    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    expect(
      find.text('DevShepherd Login'),
      findsOneWidget,
    );

    expect(
      find.text('Dev Shepherd Home Page'),
      findsNothing,
    );
  });

}