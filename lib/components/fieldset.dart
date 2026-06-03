import 'package:flutter/material.dart';
import 'package:imposto/constants/theme_colors.dart';

enum FieldType {
  normal,
  password,
  date,
  dateRange,
}

enum FieldVariant {
  primary,
  danger,
  mystery,
  voting,
}

class FieldSet extends StatefulWidget {
  final TextEditingController? controller;

  final FieldType type;
  final FieldVariant variant;

  final String? label;
  final String? placeholder;

  final IconData? icon;

  final ValueChanged<String>? onChanged;

  final bool readOnly;
  final bool enabled;
  final bool obscureText;

  const FieldSet({
    super.key,
    this.controller,
    this.onChanged,
    this.label,
    this.placeholder,
    this.icon,
    this.type = FieldType.normal,
    this.variant = FieldVariant.primary,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
  });

  @override
  State<FieldSet> createState() => _FieldSetState();
}

class _FieldSetState extends State<FieldSet> {
  late FocusNode _focusNode;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });

    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _resolveAccent() {
    switch (widget.variant) {
      case FieldVariant.primary:
        return ThemeColors.primary500;

      case FieldVariant.danger:
        return ThemeColors.danger500;

      case FieldVariant.mystery:
        return ThemeColors.mystery500;

      case FieldVariant.voting:
        return ThemeColors.voting;
    }
  }

  Widget? _buildPasswordIcon(Color accent) {
    if (widget.type != FieldType.password) {
      return null;
    }

    return IconButton(
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      icon: Icon(
        _obscureText
            ? Icons.visibility_off_rounded
            : Icons.visibility_rounded,
        color: _focusNode.hasFocus
            ? accent
            : ThemeColors.textMuted,
      ),
    );
  }

  InputDecoration _buildDecoration({
    required bool focused,
    required Color accent,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: ThemeColors.surface,

      labelText: widget.label,
      hintText: widget.placeholder,

      prefixIcon: widget.icon != null
          ? Icon(
              widget.icon,
              color: focused
                  ? accent
                  : ThemeColors.textMuted,
            )
          : null,

      suffixIcon: suffixIcon,

      labelStyle: TextStyle(
        color: focused
            ? accent
            : ThemeColors.textMuted,
        fontWeight: FontWeight.w600,
      ),

      hintStyle: const TextStyle(
        color: ThemeColors.textMuted,
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: ThemeColors.border,
          width: 1.2,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: accent,
          width: 1.6,
        ),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: ThemeColors.border.withOpacity(0.5),
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: ThemeColors.danger500,
        ),
      ),
    );
  }

  Future<void> _handleDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: ThemeColors.background,
            colorScheme: const ColorScheme.dark(
              primary: ThemeColors.primary500,
              surface: ThemeColors.surface,
              onSurface: ThemeColors.textPrimary,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: ThemeColors.surfaceAlt,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.controller?.text =
          picked.toString().split(' ')[0];
    }
  }

  Future<void> _handleDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: ThemeColors.background,
            colorScheme: const ColorScheme.dark(
              primary: ThemeColors.mystery500,
              surface: ThemeColors.surface,
              onSurface: ThemeColors.textPrimary,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: ThemeColors.surfaceAlt,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && widget.controller != null) {
      widget.controller!.text =
          "${picked.start.toString().split(' ')[0]} até ${picked.end.toString().split(' ')[0]}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focusNode.hasFocus;
    final accent = _resolveAccent();

    const textStyle = TextStyle(
      color: ThemeColors.textPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 15,
    );

    switch (widget.type) {
      case FieldType.normal:
      case FieldType.password:
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: focused
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.15),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),

          child: TextField(
            focusNode: _focusNode,

            controller: widget.controller,
            onChanged: widget.onChanged,

            readOnly: widget.readOnly,
            enabled: widget.enabled,

            obscureText: widget.type == FieldType.password
                ? _obscureText
                : widget.obscureText,

            style: textStyle,

            cursorColor: accent,

            decoration: _buildDecoration(
              focused: focused,
              accent: accent,
              suffixIcon: _buildPasswordIcon(accent),
            ),
          ),
        );

      case FieldType.date:
        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: _handleDatePicker,

          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: focused
                    ? [
                        BoxShadow(
                          color: accent.withOpacity(0.15),
                          blurRadius: 18,
                        ),
                      ]
                    : null,
              ),

              child: TextField(
                focusNode: _focusNode,

                controller: widget.controller,

                style: textStyle,

                decoration: _buildDecoration(
                  focused: focused,
                  accent: accent,
                  suffixIcon: Icon(
                    Icons.calendar_today_rounded,
                    color: accent,
                  ),
                ),
              ),
            ),
          ),
        );

      case FieldType.dateRange:
        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: _handleDateRangePicker,

          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: focused
                    ? [
                        BoxShadow(
                          color: accent.withOpacity(0.15),
                          blurRadius: 18,
                        ),
                      ]
                    : null,
              ),

              child: TextField(
                focusNode: _focusNode,

                controller: widget.controller,

                style: textStyle,

                decoration: _buildDecoration(
                  focused: focused,
                  accent: accent,
                  suffixIcon: Icon(
                    Icons.date_range_rounded,
                    color: accent,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}