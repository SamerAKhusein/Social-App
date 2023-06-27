import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validate,
  onTap : onTap,
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  onChanged: (s){
    onChange!(s);
  },
  obscureText: isPassword ,
  decoration: InputDecoration(
    labelText: label,
    enabled: isClickable,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: () {
        suffixPressed!();
      },
      icon: Icon(
        suffix,
      ),
    )
        : null,

    /*suffix != null ?
  IconButton(
    onPressed:suffixPressed,
      icon: Icon(suffix),
  ) : null,*/
    border: const OutlineInputBorder(),

  ),

);

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
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

void showToast({
  required String text,
  required ToastStates state,

}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
