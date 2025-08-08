import 'package:flutter/material.dart';

class TouchFriendlyButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final ButtonStyle? style;
  final bool isLoading;
  final Size? minimumSize;

  const TouchFriendlyButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.style,
    this.isLoading = false,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = ElevatedButton.styleFrom(
      minimumSize: minimumSize ?? const Size.fromHeight(48),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );

    final buttonStyle = style ?? defaultStyle;

    if (isLoading) {
      return ElevatedButton(
        onPressed: null,
        style: buttonStyle,
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: buttonStyle,
        icon: Icon(icon),
        label: Text(label),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(label),
    );
  }
}

class TouchFriendlyOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final ButtonStyle? style;
  final bool isLoading;
  final Size? minimumSize;

  const TouchFriendlyOutlinedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.style,
    this.isLoading = false,
    this.minimumSize,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = OutlinedButton.styleFrom(
      minimumSize: minimumSize ?? const Size.fromHeight(48),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );

    final buttonStyle = style ?? defaultStyle;

    if (isLoading) {
      return OutlinedButton(
        onPressed: null,
        style: buttonStyle,
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        style: buttonStyle,
        icon: Icon(icon),
        label: Text(label),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(label),
    );
  }
}

class TouchFriendlyIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? color;
  final double size;

  const TouchFriendlyIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.color,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
      iconSize: 24,
      padding: EdgeInsets.all((size - 24) / 2),
      constraints: BoxConstraints(
        minWidth: size,
        minHeight: size,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}