import 'package:flutter/material.dart';

Future<void> _selectDate(
    BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != DateTime.now()) {
    controller.text = picked.toLocal().toString().split(' ')[0];
  }
}

<<<<<<< HEAD
Widget customInput(String labelText, TextEditingController controller,
    {bool isPassword = false,
    bool isDate = false,
    required BuildContext context}) {
  return Container(
    width: 230,
=======
Widget customInput(String labelText, TextEditingController controller, {bool isPassword = false, bool isDate = false, required BuildContext context}) {
  return Container(
    width: 210,
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
    height: 56,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
<<<<<<< HEAD
          width: 230,
=======
          width: 210,
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
          height: 56,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
<<<<<<< HEAD
=======
                      // Use a TextFormField for input
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                      Expanded(
                        child: TextFormField(
                          obscureText: isPassword,
                          controller: controller,
                          onTap: () {
                            if (isDate) {
<<<<<<< HEAD
=======
                              // Pass context to the _selectDate function
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                              _selectDate(context, controller);
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
<<<<<<< HEAD
                            labelText: labelText,
                            suffixIcon: isPassword
                                ? IconButton(
                                    icon: Icon(
                                      isPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
=======
                            labelText: labelText, // Use the provided labelText
                            suffixIcon: isPassword
                                ? IconButton(
                                    icon: Icon(
                                      isPassword ? Icons.visibility : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      // Toggle password visibility
>>>>>>> 42a049a6090a6cc9f2307628a0a621d9ffc245f6
                                      isPassword = !isPassword;
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF49454F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
