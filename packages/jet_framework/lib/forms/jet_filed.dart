import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:jet_framework/helpers/jet_logger.dart';
import 'package:pinput/pinput.dart';

typedef JetFormBuilderState = FormBuilderState;
typedef JetField = FormField;
typedef JetValidator = FormBuilderValidators;
typedef JetTextField = FormBuilderTextField;
typedef JetCheckBox = FormBuilderCheckbox;
typedef JetCheckBoxGroup = FormBuilderCheckboxGroup;
typedef JetChoiceChip = FormBuilderChoiceChip;
typedef JetChipOption = FormBuilderChipOption;
typedef JetDropdown = FormBuilderDropdown;
typedef JetRadioGroup = FormBuilderRadioGroup;
typedef JetRangeSlider = FormBuilderRangeSlider;
typedef JetSwitch = FormBuilderSwitch;
typedef JetFormBuilder = FormBuilder;
typedef JetPinFiled = Pinput;

class FormBuilderOtpField extends FormBuilderField<String> {
  FormBuilderOtpField({
    super.key,
    required String name,
    int length = 6,
    InputDecoration? decoration,
    TextStyle? textStyle,
    ValueChanged<String?>? onChanged,
    FormFieldValidator<String>? validator,
    bool autoFocus = true,
  }) : super(
          name: name,
          validator: validator,
          builder: (FormFieldState<String> field) {
            return _OtpFieldWidget(
              field: field,
              length: length,
              decoration: decoration ?? const InputDecoration(),
              textStyle: textStyle ?? const TextStyle(fontSize: 20),
              onChanged: onChanged,
              autoFocus: autoFocus,
            );
          },
        );
}

class _OtpFieldWidget extends StatefulWidget {
  final FormFieldState<String> field;
  final int length;
  final InputDecoration decoration;
  final TextStyle textStyle;
  final ValueChanged<String?>? onChanged;
  final bool autoFocus;

  const _OtpFieldWidget({
    required this.field,
    required this.length,
    required this.decoration,
    required this.textStyle,
    this.onChanged,
    this.autoFocus = true,
  });

  @override
  State<_OtpFieldWidget> createState() => _OtpFieldWidgetState();
}

class _OtpFieldWidgetState extends State<_OtpFieldWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    // Set initial value if exists
    if (widget.field.value != null &&
        widget.field.value!.length == widget.length) {
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].text = widget.field.value![i];
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }

    final otpValue = _controllers.map((controller) => controller.text).join();
    widget.field.didChange(otpValue);
    widget.onChanged?.call(otpValue);
  }

  void _onBackspace(int index) {
    if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      _controllers[index - 1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return Container(
          width: 45,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: KeyboardListener(
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                if (_controllers[index].text.isEmpty && index > 0) {
                  _controllers[index - 1].clear();
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
              }
            },
            focusNode: FocusNode(),
            // Prevents the whole keyboard from being intercepted
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              maxLength: 1,
              style: widget.textStyle,
              keyboardType: TextInputType.number,
              decoration: widget.decoration.copyWith(counterText: ""),
              autofocus: widget.autoFocus && index == 0,
              onChanged: (value) => _onTextChanged(index, value),
              onTap: () => _controllers[index].selection =
                  TextSelection.collapsed(
                      offset: _controllers[index].text.length),
              onSubmitted: (_) =>
                  _onTextChanged(index, _controllers[index].text),
            ),
          ),
        );
      }),
    );
  }
}
