<<<<<<< HEAD
import 'package:flutter/material.dart';

class RadioCustom extends StatefulWidget {
  final bool initialValue;
  const RadioCustom({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<RadioCustom> createState() => _RadioCustomState();
}

class _RadioCustomState extends State<RadioCustom> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initialValue;
  }

  Color getColor(Set<MaterialState> states) {
    return isSelected ? const Color(0xFF6750A4) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Radio<bool>(
      activeColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: true,
      groupValue: isSelected ? true : false,
      onChanged: (bool? value) {
        setState(() {
          isSelected = value ?? false;
        });
      },
    );
  }
}
=======
import 'package:flutter/material.dart';

class RadioCustom extends StatefulWidget {
  final bool initialValue; // New parameter to hold the initial value
  const RadioCustom({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<RadioCustom> createState() => _RadioCustomState();
}

class _RadioCustomState extends State<RadioCustom> {
  late bool isSelected; // Variable to hold the radio button state

  @override
  void initState() {
    super.initState();
    isSelected = widget.initialValue; // Initialize isSelected with the provided initial value
  }

  Color getColor(Set<MaterialState> states) {
    return isSelected ? const Color(0xFF6750A4) : Colors.white; // Purple when selected, white when unselected
  }

  @override
  Widget build(BuildContext context) {
    return Radio<bool>(
      activeColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: true,
      groupValue: isSelected ? true : false,
      onChanged: (bool? value) {
        setState(() {
          isSelected = value ?? false; // Update the isSelected value
        });
      },
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
