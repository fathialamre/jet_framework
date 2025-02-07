import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';

class JetPinField extends FormBuilderField<String> {
  final int length;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final bool autoFocus;
  final double spacing;
  final double fieldSize;

  JetPinField({
    super.key,
    required super.name,
    this.length = 6,
    this.decoration = const InputDecoration(),
    this.textStyle = const TextStyle(fontSize: 20),
    this.autoFocus = true,
    this.spacing = 8,
    this.fieldSize = 45,
    ValueChanged<String?>? onChanged,
    FormFieldValidator<String>? validator,
  }) : super(
          validator: validator ?? _defaultValidator,
          builder: (FormFieldState<String> field) {
            return _PinFieldWidget(
              field: field,
              length: length,
              decoration: decoration,
              textStyle: textStyle,
              autoFocus: autoFocus,
              spacing: spacing,
              fieldSize: fieldSize,
              onChanged: onChanged,
            );
          },
        );

  static String? _defaultValidator(String? value) {
    if (value?.isEmpty ?? true) return 'Please enter the OTP';
    if (value!.length != 6) return 'OTP must be 6 digits';
    return null;
  }
}

class _PinFieldWidget extends StatefulWidget {
  final FormFieldState<String> field;
  final int length;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final bool autoFocus;
  final double spacing;
  final double fieldSize;
  final ValueChanged<String?>? onChanged;

  const _PinFieldWidget({
    required this.field,
    required this.length,
    required this.decoration,
    required this.textStyle,
    required this.autoFocus,
    required this.spacing,
    required this.fieldSize,
    this.onChanged,
  });

  @override
  State<_PinFieldWidget> createState() => _PinFieldWidgetState();
}

class _PinFieldWidgetState extends State<_PinFieldWidget> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _initializeControllersAndFocusNodes();
    _setInitialValue();
  }

  void _initializeControllersAndFocusNodes() {
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  void _setInitialValue() {
    final initialValue = widget.field.value;
    if (initialValue != null && initialValue.length == widget.length) {
      for (var i = 0; i < widget.length; i++) {
        _controllers[i].text = initialValue[i];
      }
    }
  }

  @override
  void dispose() {
    _disposeControllersAndFocusNodes();
    super.dispose();
  }

  void _disposeControllersAndFocusNodes() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
  }

  void _handleOtpChange() {
    final otpValue = _controllers.map((c) => c.text).join();
    widget.field.didChange(otpValue);
    widget.onChanged?.call(otpValue);
  }

  void _handleDigitChange(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    _handleOtpChange();
  }

  void _handleBackspace(int index) {
    if (index > 0 && _controllers[index].text.isEmpty) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      _handleOtpChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.length, (index) {
            return _OtpDigitField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textStyle: widget.textStyle,
              decoration: widget.decoration,
              autoFocus: widget.autoFocus && index == 0,
              spacing: widget.spacing,
              fieldSize: widget.fieldSize,
              onChanged: (value) => _handleDigitChange(index, value),
              onBackspace: () => _handleBackspace(index),
              hasError: widget.field.errorText != null,
            );
          }),
        ),
        if (widget.field.errorText != null) // Show error if exists
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.field.errorText!,
            ).labelSmall(context).color(
                  Theme.of(context).colorScheme.error,
                ),
          ),
      ],
    );
  }
}

class _OtpDigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextStyle textStyle;
  final InputDecoration decoration;
  final bool autoFocus;
  final double spacing;
  final double fieldSize;
  final bool hasError; // New field to check for validation error
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  const _OtpDigitField({
    required this.controller,
    required this.focusNode,
    required this.textStyle,
    required this.decoration,
    required this.autoFocus,
    required this.spacing,
    required this.fieldSize,
    required this.hasError, // Receive error state
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: fieldSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                onBackspace();
              }
            },
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              maxLength: 1,
              keyboardType: TextInputType.number,
              autofocus: autoFocus,
              style: textStyle,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorStyle: TextStyle(height: -1),
                errorText: hasError ? '' : null,
              ),
              onChanged: onChanged,
              onTap: () => controller.selection = TextSelection.collapsed(
                offset: controller.text.length,
              ),
              onFieldSubmitted: (_) => onChanged(controller.text),
              buildCounter: (
                _, {
                required currentLength,
                required isFocused,
                maxLength,
              }) =>
                  null,
            ),
          ),
        ),
      ],
    );
  }
}
