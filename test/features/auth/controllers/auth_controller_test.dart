import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:your_app/features/auth/controllers/auth_controller.dart';
import 'package:your_app/core/services/auth_service.dart';

import 'auth_controller_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late AuthController controller;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    Get.put<AuthService>(mockAuthService);
    controller = AuthController();
  });

  tearDown(() {
    Get.reset();
  });

  group('AuthController', () {
    test('should toggle auth mode correctly', () {
      // Initial state should be sign in
      expect(controller.isSignUp, false);

      // Toggle to sign up
      controller.toggleAuthMode();
      expect(controller.isSignUp, true);

      // Toggle back to sign in
      controller.toggleAuthMode();
      expect(controller.isSignUp, false);
    });

    test('should toggle password visibility correctly', () {
      // Initial state should be obscured
      expect(controller.obscurePassword, true);

      // Toggle visibility
      controller.togglePasswordVisibility();
      expect(controller.obscurePassword, false);

      // Toggle back
      controller.togglePasswordVisibility();
      expect(controller.obscurePassword, true);
    });

    test('should validate email correctly', () {
      // Valid email
      expect(controller.validateEmail('test@example.com'), null);

      // Invalid email
      expect(controller.validateEmail('invalid-email'), isNotNull);

      // Empty email
      expect(controller.validateEmail(''), isNotNull);

      // Null email
      expect(controller.validateEmail(null), isNotNull);
    });

    test('should validate password correctly', () {
      // Valid password
      expect(controller.validatePassword('password123'), null);

      // Short password
      expect(controller.validatePassword('123'), isNotNull);

      // Empty password
      expect(controller.validatePassword(''), isNotNull);

      // Null password
      expect(controller.validatePassword(null), isNotNull);
    });

    test('should validate confirm password correctly', () {
      // Set up password
      controller.passwordController.text = 'password123';

      // Matching password
      expect(controller.validateConfirmPassword('password123'), null);

      // Non-matching password
      expect(controller.validateConfirmPassword('different'), isNotNull);

      // Empty confirm password
      expect(controller.validateConfirmPassword(''), isNotNull);
    });

    test('should validate name correctly for sign up', () {
      // Set to sign up mode
      controller.toggleAuthMode();

      // Valid name
      expect(controller.validateName('John Doe'), null);

      // Empty name
      expect(controller.validateName(''), isNotNull);

      // Null name
      expect(controller.validateName(null), isNotNull);
    });

    test('should not require name for sign in', () {
      // Stay in sign in mode
      expect(controller.isSignUp, false);

      // Name should not be required
      expect(controller.validateName(''), null);
      expect(controller.validateName(null), null);
    });

    test('should sign in with email successfully', () async {
      // Arrange
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';
      
      when(mockAuthService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => MockUserCredential());

      // Act
      await controller.signInWithEmail();

      // Assert
      expect(controller.isLoading, false);
      expect(controller.errorMessage, '');
      expect(controller.successMessage, 'Successfully signed in!');
      verify(mockAuthService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
    });

    test('should handle sign in error', () async {
      // Arrange
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'wrongpassword';
      
      when(mockAuthService.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'wrongpassword',
      )).thenThrow('Invalid credentials');

      // Act
      await controller.signInWithEmail();

      // Assert
      expect(controller.isLoading, false);
      expect(controller.errorMessage, 'Invalid credentials');
      expect(controller.successMessage, '');
    });

    test('should sign up with email successfully', () async {
      // Arrange
      controller.toggleAuthMode(); // Switch to sign up
      controller.nameController.text = 'John Doe';
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';
      controller.confirmPasswordController.text = 'password123';
      
      when(mockAuthService.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenAnswer((_) async => MockUserCredential());

      when(mockAuthService.updateUserProfile(displayName: 'John Doe'))
          .thenAnswer((_) async {});

      // Act
      await controller.signUpWithEmail();

      // Assert
      expect(controller.isLoading, false);
      expect(controller.errorMessage, '');
      expect(controller.successMessage, 'Account created successfully!');
      verify(mockAuthService.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
      verify(mockAuthService.updateUserProfile(displayName: 'John Doe')).called(1);
    });

    test('should handle sign up error', () async {
      // Arrange
      controller.toggleAuthMode(); // Switch to sign up
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';
      controller.confirmPasswordController.text = 'password123';
      
      when(mockAuthService.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).thenThrow('Email already in use');

      // Act
      await controller.signUpWithEmail();

      // Assert
      expect(controller.isLoading, false);
      expect(controller.errorMessage, 'Email already in use');
      expect(controller.successMessage, '');
    });

    test('should clear messages when toggling auth mode', () {
      // Set some messages
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';
      
      // This will set error message
      controller.signInWithEmail();

      // Toggle auth mode
      controller.toggleAuthMode();

      // Messages should be cleared
      expect(controller.errorMessage, '');
      expect(controller.successMessage, '');
    });

    test('should clear form when toggling auth mode', () {
      // Fill form
      controller.nameController.text = 'John Doe';
      controller.emailController.text = 'test@example.com';
      controller.passwordController.text = 'password123';
      controller.confirmPasswordController.text = 'password123';

      // Toggle auth mode
      controller.toggleAuthMode();

      // Form should be cleared
      expect(controller.nameController.text, '');
      expect(controller.emailController.text, '');
      expect(controller.passwordController.text, '');
      expect(controller.confirmPasswordController.text, '');
    });
  });
}

// Mock classes for testing
class MockUserCredential extends Mock {
  // Add any needed properties or methods
}

class MockUser extends Mock {
  // Add any needed properties or methods
} 