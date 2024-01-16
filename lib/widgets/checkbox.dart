import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  final Future<bool> isCompleted;
  final void Function(bool?)? onChanged;

  const CheckboxCustom(
      {Key? key, required this.isCompleted, required this.onChanged})
      : super(key: key);

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    widget.isCompleted.then((value) {
      setState(() {
        isChecked = value;
      });
    });
  }

  Color getColor() {
    return isChecked ? const Color(0xFF6750A4) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.all(getColor()),
      value: isChecked,
      onChanged: (newValue) {
        setState(() {
          isChecked = newValue ?? false;
        });

        widget.onChanged?.call(isChecked);
      },
    );
  }
}
