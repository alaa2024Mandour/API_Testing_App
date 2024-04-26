/*=================================================*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextButton ({
  required Function function,
  required String buttonlable,
}) => TextButton(
    onPressed: (){
      function();
    },
    child: Text(
        "$buttonlable"
    )
);

Widget defaultButton({
  Color backgroundColor = Colors.deepPurple,
  double width = double.infinity,
  double radius = 25.0,
  required String text,
  required Function function,
}) => Container(
  width: width,
  decoration: BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(radius),
  ),
  child: MaterialButton(
    onPressed: () {
      function();
    },
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
);

/*=================================================*/
//Reusable Text Form Field
/*=================================================*/
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  required String hintText,
  required String labelText,
  required IconData preFix,
//=======for Password=========
  IconData? suFix,
  Function? suffixOnPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      //=======for Password=========
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },

      validator: (value) {
        if (value == null || value.isEmpty) return 'لابد من ملئ هذا الحقل';
        return null;
      },

      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey, ),
        prefixIcon: Icon(
          preFix,
        ),
        suffix: suFix != null
            ? IconButton(
          onPressed: () {
            suffixOnPressed!();
          },
          icon: Icon(
            suFix,
          ),
        )
            : null,
        //=======for Password=========
        fillColor: Colors.transparent,
      ),
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'Tajawal',
      ),
    );