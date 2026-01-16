import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';


class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final Future<bool> Function()? validator;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;

  Future<void> _handlePressed() async {
    if (!widget.isEnabled || _isLoading) return;

    // If validator exists, run it first
    if (widget.validator != null) {
      setState(() => _isLoading = true);
      try {
        final isValid = await widget.validator!();
        if (!isValid) {
          setState(() => _isLoading = false);
          return;
        }
      } catch (e) {
        setState(() => _isLoading = false);
        return;
      }
    } else {
      setState(() => _isLoading = true);
    }

    // Execute the onPressed callback
    try {
      widget.onPressed?.call();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading || _isLoading;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      height: SizeConfig.blockHeight * 7,
      child: ElevatedButton(
        onPressed: (widget.isEnabled && !isLoading) ? _handlePressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isEnabled
              ? AppColors.primaryColor
              : AppColors.darkBorder,
          disabledBackgroundColor: AppColors.darkBorder,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              )
            : Text(
                widget.text,
                style: textTheme.titleMedium?.copyWith(
                  color: widget.isEnabled
                      ? Colors.white
                      : AppColors.darkTextTertiary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}