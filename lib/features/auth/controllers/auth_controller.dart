import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  
  // Form validation
  final formKey = GlobalKey<FormState>();
  
  // Reactive state
  final _isLoading = false.obs;
  final _isSignUp = false.obs;
  final _obscurePassword = true.obs;
  final _obscureConfirmPassword = true.obs;
  final _errorMessage = ''.obs;
  final _successMessage = ''.obs;
  
  // Getters
  bool get isLoading => _isLoading.value;
  bool get isSignUp => _isSignUp.value;
  bool get obscurePassword => _obscurePassword.value;
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;
  String get errorMessage => _errorMessage.value;
  String get successMessage => _successMessage.value;
  
  @override
  void onInit() {
    super.onInit();
    // Check if user is already logged in
    if (_authService.isLoggedIn) {
      _navigateToHome();
    }
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.onClose();
  }
  
  // Toggle between sign in and sign up
  void toggleAuthMode() {
    _isSignUp.value = !_isSignUp.value;
    _clearMessages();
    _clearForm();
  }
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
  }
  
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
  }
  
  // Clear messages
  void _clearMessages() {
    _errorMessage.value = '';
    _successMessage.value = '';
  }
  
  // Clear form
  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
  }
  
  // Email & Password Authentication
  Future<void> signInWithEmail() async {
    if (!_validateForm()) return;
    
    _isLoading.value = true;
    _clearMessages();
    
    try {
      await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      _successMessage.value = 'Successfully signed in!';
      _navigateToHome();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
  
  Future<void> signUpWithEmail() async {
    if (!_validateForm()) return;
    
    _isLoading.value = true;
    _clearMessages();
    
    try {
      final credential = await _authService.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      // Update display name if provided
      if (nameController.text.isNotEmpty) {
        await _authService.updateUserProfile(
          displayName: nameController.text.trim(),
        );
      }
      
      _successMessage.value = 'Account created successfully!';
      _navigateToHome();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
  
  // Google Sign In
  Future<void> signInWithGoogle() async {
    _isLoading.value = true;
    _clearMessages();
    
    try {
      final credential = await _authService.signInWithGoogle();
      if (credential != null) {
        _successMessage.value = 'Successfully signed in with Google!';
        _navigateToHome();
      }
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
  
  // Apple Sign In
  Future<void> signInWithApple() async {
    _isLoading.value = true;
    _clearMessages();
    
    try {
      final credential = await _authService.signInWithApple();
      if (credential != null) {
        _successMessage.value = 'Successfully signed in with Apple!';
        _navigateToHome();
      }
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
  
  // Anonymous Sign In
  Future<void> signInAnonymously() async {
    _isLoading.value = true;
    _clearMessages();
    
    try {
      await _authService.signInAnonymously();
      _successMessage.value = 'Signed in anonymously!';
      _navigateToHome();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
  
  // Password Reset
  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      _errorMessage.value = 'Please enter your email address.';
      return;
    }
    
    _isLoading.value = true;
    _clearMessages();
    
    try {
      await _authService.sendPasswordResetEmail(emailController.text.trim());
      _successMessage.value = 'Password reset email sent!';
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
  
  // Form validation
  bool _validateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    
    if (isSignUp && passwordController.text != confirmPasswordController.text) {
      _errorMessage.value = 'Passwords do not match.';
      return false;
    }
    
    return true;
  }
  
  // Navigation
  void _navigateToHome() {
    Get.offAllNamed('/home');
  }
  
  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }
  
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }
  
  String? validateName(String? value) {
    if (isSignUp && (value == null || value.isEmpty)) {
      return 'Name is required.';
    }
    return null;
  }
} 