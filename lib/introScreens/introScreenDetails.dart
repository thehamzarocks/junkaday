import 'dart:core';

import 'package:flutter/material.dart';

class IntroScreenDetails {
  IntroScreenDetails(int number, String text, IconData icon) {
    this.number = number;
    this.text = text;
    this.icon = icon;
  }
  int number;
  String text;
  IconData icon;
}
