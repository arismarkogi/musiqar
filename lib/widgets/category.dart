<<<<<<< HEAD
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  CategoryWidget({required this.label, required this.onPressed});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF79747E)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isPressed = !isPressed;
              });
              widget.onPressed();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isPressed ? Color(0xFF4169E1) : Color(0x146750A4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isPressed ? Colors.white : Color(0xFF6750A4),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0.10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
=======
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  CategoryWidget({required this.label, required this.onPressed});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF79747E)),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isPressed = !isPressed;
              });
              widget.onPressed();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isPressed ? Color(0xFF4169E1) : Color(0x146750A4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isPressed ? Colors.white : Color(0xFF6750A4),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0.10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
