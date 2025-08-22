import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





class AppTheme{

  AppTheme._();
  
  
  static const Color RichBlack = Color(0xFF0D1B2A);
  static const Color YInMin_BLUE = const Color(0xFF415A77);
  static const Color Platinum    = const Color(0xFFE0E1DD);
  static const Color Rust        = const Color(0xFFBA3F1D);
  static const Color Chamoisee   = const Color(0xFFA77E58);
  static const Color good        = const Color(0xFF26DF88);
  static const Color warning     = const Color(0xFFF6FF74);
  
  static const Color Backg1 = const Color(0xFF000A14);
  static const Color Backg2 = const Color(0xFF1d2329);
  static const Color Backg3 = const Color(0xFF898e94);

  static const Color Foreg1 = const Color(0xFF4978AD);
  static const Color Foreg2 = const Color(0xFF88a3c8);
  static const Color Foreg3 = const Color(0xFFb0c1da);

  static const String fontName = 'WorkSans';

  static const TextStyle h1 = TextStyle( // h1 -> display1
      fontFamily: fontName,
      fontWeight: FontWeight.bold,
      fontSize: 36,
      letterSpacing: 0.4,
      height: 0.9,
      color: Foreg3,
  );
 
}
