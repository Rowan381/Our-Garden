import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool isOutlined;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final ButtonSize size;
  
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.icon,
    this.isOutlined = false,
    this.padding,
    this.borderRadius,
    this.size = ButtonSize.medium,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonHeight = _getButtonHeight();
    final buttonPadding = _getButtonPadding();
    
    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height ?? buttonHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? AppTheme.primaryColor,
            side: BorderSide(color: textColor ?? AppTheme.primaryColor),
            padding: padding ?? buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusM),
            ),
          ),
          child: _buildButtonContent(theme),
        ),
      );
    }
    
    return SizedBox(
      width: width,
      height: height ?? buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ?? buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusM),
          ),
        ),
        child: _buildButtonContent(theme),
      ),
    );
  }
  
  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }
  
  EdgeInsetsGeometry _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingM,
          vertical: AppTheme.paddingS,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingL,
          vertical: AppTheme.paddingM,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingXL,
          vertical: AppTheme.paddingL,
        );
    }
  }
  
  Widget _buildButtonContent(ThemeData theme) {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: AppTheme.paddingS),
        ],
        Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: textColor ?? (isOutlined ? AppTheme.primaryColor : Colors.white),
          ),
        ),
      ],
    );
  }
} 