<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  final bool initialValue; // New parameter to hold the initial value
  const CheckboxCustom({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  late bool isChecked; // Variable to hold the checkbox state

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue; // Initialize isChecked with the provided initial value
  }

  Color getColor(Set<MaterialState> states) {
    return isChecked ? const Color(0xFF6750A4) : Colors.white; // Purple when checked, white when unchecked
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false; // Update the isChecked value
        });
      },
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
