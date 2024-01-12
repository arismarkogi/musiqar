import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  final bool initialValue;
  const CheckboxCustom({Key? key, required this.initialValue})
      : super(key: key);

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  Color getColor(Set<MaterialState> states) {
    return isChecked ? const Color(0xFF6750A4) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }
}
