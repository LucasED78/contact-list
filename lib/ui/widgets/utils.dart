import 'package:flutter/material.dart';

class UtilsWidget {
  static buildAppBar(String title){
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.teal,
      centerTitle: true,
    );
  }

  static buildTextField(String labelText, TextEditingController ctrl, Function onChanged, {TextStyle labelStyle, TextInputType inputType}){
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle != null ? labelStyle : TextStyle(
          color: Colors.black
        ),
      ),
      controller: ctrl,
      keyboardType: inputType ?? inputType,
      onChanged: onChanged,
    );
  }
}