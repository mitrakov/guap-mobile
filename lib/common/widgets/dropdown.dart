import 'package:flutter/material.dart';

class TrixDropdown<T> extends StatefulWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;

  TrixDropdown({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
  });

  @override
  _TrixDropdownState<T> createState() => _TrixDropdownState<T>();
}

class _TrixDropdownState<T> extends State<TrixDropdown<T>> {
  T value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            labelText: widget.hintText,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: widget.value == null || widget.value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: (t) {
                widget.onChanged(t);
                setState(() {
                  value = t;
                });
              },
              items: widget.options.map((T value) {
                return DropdownMenuItem<T>(value: value, child: Text(widget.getLabel(value)),);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
