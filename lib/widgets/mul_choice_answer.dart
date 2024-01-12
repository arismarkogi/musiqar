<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'radio_button.dart';

class CustomMultipleChoiceWidget extends StatefulWidget {
  final String answer;
  final String imageURL;
  final VoidCallback onTap;

  const CustomMultipleChoiceWidget({
    required this.answer,
    required this.imageURL,
    required this.onTap,
  });

  @override
  State<CustomMultipleChoiceWidget> createState() =>
      _CustomMultipleChoiceWidgetState();
}

class _CustomMultipleChoiceWidgetState
    extends State<CustomMultipleChoiceWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onTap();
      },
      child: Container(
        width: 340,
        decoration: BoxDecoration(color: const Color(0xFFD3D3D3)),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageURL),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              widget.answer,
              style: TextStyle(
                color: Color(0xFF1D1B20),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.50,
              ),
            ),
            Spacer(),
            Expanded(
              child: RadioCustom(initialValue: false),
            )
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'radio_button.dart';

class CustomMultipleChoiceWidget extends StatefulWidget {
  final String answer;
  final String imageURL;
  final VoidCallback onTap;

  const CustomMultipleChoiceWidget({
    required this.answer,
    required this.imageURL,
    required this.onTap,
  });

  @override
  State<CustomMultipleChoiceWidget> createState() =>
      _CustomMultipleChoiceWidgetState();
}

class _CustomMultipleChoiceWidgetState
    extends State<CustomMultipleChoiceWidget> {
  bool isChecked = false; // Track the state of the checkbox

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked; // Toggle the isChecked state on tap
        });
        widget.onTap(); // Execute the provided onTap function
      },
      child: Container(
        width: 340,
        decoration: BoxDecoration(color: const Color(0xFFD3D3D3)),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageURL),
                  fit: BoxFit.fitHeight, // Adjusted fit
                ),
              ),
            ),
            SizedBox(width: 8), // Added SizedBox for spacing

                Text(
                  widget.answer,
                  style: TextStyle(
                    color: Color(0xFF1D1B20),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.50,
                  ),
                ),
            Spacer(),
            Expanded(
            child: RadioCustom(initialValue: false),
            )
          ],
        ),
      ),
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
