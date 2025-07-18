import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/auth_controller.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../app/theme/app_theme.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.paddingXL),
                
                // Logo and Title
                _buildHeader(),
                
                const SizedBox(height: AppTheme.paddingXL),
                
                // Auth Mode Toggle
                _buildAuthModeToggle(),
                
                const SizedBox(height: AppTheme.paddingL),
                
                // Messages
                _buildMessages(),
                
                const SizedBox(height: AppTheme.paddingM),
                
                // Form Fields
                _buildFormFields(),
                
                const SizedBox(height: AppTheme.paddingL),
                
                // Action Buttons
                _buildActionButtons(),
                
                const SizedBox(height: AppTheme.paddingL),
                
                // Social Sign In
                _buildSocialSignIn(),
                
                const SizedBox(height: AppTheme.paddingL),
                
                // Anonymous Sign In
                _buildAnonymousSignIn(),
                
                const SizedBox(height: AppTheme.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Column(
      children: [
        // App Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          child: const Icon(
            Icons.eco,
            color: Colors.white,
            size: 40,
          ),
        ),
        
        const SizedBox(height: AppTheme.paddingM),
        
        // Title
        Text(
          'Our Garden',
          style: AppTheme.headlineMedium.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: AppTheme.paddingS),
        
        // Subtitle
        Text(
          'Connect with nature, grow together',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.secondaryTextColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildAuthModeToggle() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          controller.isSignUp ? 'Already have an account?' : 'Don\'t have an account?',
          style: AppTheme.bodyMedium,
        ),
        TextButton(
          onPressed: controller.toggleAuthMode,
          child: Text(
            controller.isSignUp ? 'Sign In' : 'Sign Up',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ));
  }
  
  Widget _buildMessages() {
    return Obx(() => Column(
      children: [
        if (controller.errorMessage.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingM),
            margin: const EdgeInsets.only(bottom: AppTheme.paddingS),
            decoration: BoxDecoration(
              color: AppTheme.errorColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(color: AppTheme.errorColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: AppTheme.errorColor, size: 20),
                const SizedBox(width: AppTheme.paddingS),
                Expanded(
                  child: Text(
                    controller.errorMessage,
                    style: AppTheme.bodySmall.copyWith(color: AppTheme.errorColor),
                  ),
                ),
              ],
            ),
          ),
        
        if (controller.successMessage.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(AppTheme.paddingM),
            margin: const EdgeInsets.only(bottom: AppTheme.paddingS),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(color: AppTheme.successColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: AppTheme.successColor, size: 20),
                const SizedBox(width: AppTheme.paddingS),
                Expanded(
                  child: Text(
                    controller.successMessage,
                    style: AppTheme.bodySmall.copyWith(color: AppTheme.successColor),
                  ),
                ),
              ],
            ),
          ),
      ],
    ));
  }
  
  Widget _buildFormFields() {
    return Obx(() => Column(
      children: [
        // Name field (only for sign up)
        if (controller.isSignUp) ...[
          CustomTextField(
            controller: controller.nameController,
            label: 'Full Name',
            hint: 'Enter your full name',
            prefixIcon: const Icon(Icons.person_outline),
            validator: controller.validateName,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppTheme.paddingM),
        ],
        
        // Email field
        CustomTextField(
          controller: controller.emailController,
          label: 'Email',
          hint: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
          validator: controller.validateEmail,
          textInputAction: TextInputAction.next,
        ),
        
        const SizedBox(height: AppTheme.paddingM),
        
        // Password field
        CustomTextField(
          controller: controller.passwordController,
          label: 'Password',
          hint: 'Enter your password',
          obscureText: controller.obscurePassword,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
          validator: controller.validatePassword,
          textInputAction: controller.isSignUp ? TextInputAction.next : TextInputAction.done,
        ),
        
        // Confirm password field (only for sign up)
        if (controller.isSignUp) ...[
          const SizedBox(height: AppTheme.paddingM),
          CustomTextField(
            controller: controller.confirmPasswordController,
            label: 'Confirm Password',
            hint: 'Confirm your password',
            obscureText: controller.obscureConfirmPassword,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              ),
              onPressed: controller.toggleConfirmPasswordVisibility,
            ),
            validator: controller.validateConfirmPassword,
            textInputAction: TextInputAction.done,
          ),
        ],
        
        // Forgot password (only for sign in)
        if (!controller.isSignUp) ...[
          const SizedBox(height: AppTheme.paddingS),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: controller.resetPassword,
              child: Text(
                'Forgot Password?',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ],
    ));
  }
  
  Widget _buildActionButtons() {
    return Obx(() => CustomButton(
      text: controller.isSignUp ? 'Create Account' : 'Sign In',
      onPressed: controller.isLoading ? null : (controller.isSignUp ? controller.signUpWithEmail : controller.signInWithEmail),
      isLoading: controller.isLoading,
      icon: controller.isSignUp ? Icons.person_add : Icons.login,
    ));
  }
  
  Widget _buildSocialSignIn() {
    return Column(
      children: [
        // Divider
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingM),
              child: Text(
                'or continue with',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.secondaryTextColor,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        
        const SizedBox(height: AppTheme.paddingL),
        
        // Social buttons
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Google',
                onPressed: controller.isLoading ? null : controller.signInWithGoogle,
                isOutlined: true,
                icon: FontAwesomeIcons.google,
                backgroundColor: Colors.white,
                textColor: AppTheme.primaryTextColor,
              ),
            ),
            
            const SizedBox(width: AppTheme.paddingM),
            
            Expanded(
              child: CustomButton(
                text: 'Apple',
                onPressed: controller.isLoading ? null : controller.signInWithApple,
                isOutlined: true,
                icon: FontAwesomeIcons.apple,
                backgroundColor: Colors.white,
                textColor: AppTheme.primaryTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildAnonymousSignIn() {
    return Obx(() => CustomButton(
      text: 'Continue as Guest',
      onPressed: controller.isLoading ? null : controller.signInAnonymously,
      isOutlined: true,
      icon: Icons.person_outline,
      backgroundColor: Colors.transparent,
      textColor: AppTheme.primaryColor,
    ));
  }
} 