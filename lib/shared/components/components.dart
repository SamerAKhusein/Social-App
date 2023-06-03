import 'package:flutter/material.dart';
import 'package:social/shared/styles/colors.dart';

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(

      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: defaultColor,
        ),
      ),

    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],

  ),
);

void navigateTo(context, Widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
      (Route<dynamic> route) => false,
);