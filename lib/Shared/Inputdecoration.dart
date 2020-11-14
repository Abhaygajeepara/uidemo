import 'package:flutter/material.dart';



const inputdecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.green),
),
  focusedErrorBorder:OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  ),

labelStyle: TextStyle(
  color: Colors.black
)
);
