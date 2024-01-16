import 'package:flutter/material.dart';
import 'radio_button.dart';

class CustomMultipleChoiceWidget extends StatefulWidget {
  final String answer;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomMultipleChoiceWidget({
    required this.answer,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<CustomMultipleChoiceWidget> createState() =>
      _CustomMultipleChoiceWidgetState();
}

class _CustomMultipleChoiceWidgetState
    extends State<CustomMultipleChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: widget.isSelected ? Colors.blue : const Color(0xFFD3D3D3),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.answer,
                  style: TextStyle(
                    color: widget.isSelected ? Colors.white : Color(0xFF1D1B20),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.50,
                  ),
                ),
              ),
              if (widget.isSelected)
                Icon(
                  Icons.check,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
