import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool?> showAlertDialog(BuildContext context,
    {required String text,
    required String title,
    bool optionNo = false,
    VoidCallback? onPressed}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.acme(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          if (optionNo)
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
