import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {

  static final SPGlobal _instance = SPGlobal._();

  SPGlobal._();

  factory SPGlobal(){
    return _instance;
  }

  late SharedPreferences _prefs;

  Future<void> initShared() async{
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLogin => _prefs.getBool("isLogin") ?? false;

  set isLogin(bool value){
    _prefs.setBool("isLogin", value);
  }

  String get idUser => _prefs.getString("idUser") ?? "";
  set idUser(String value){
    _prefs.setString("idUser", value);
  }

  String get rolId => _prefs.getString("rolId") ?? "";
  set rolId(String value){
    _prefs.setString("rolId", value);
  }

  String get rolName => _prefs.getString("rolName") ?? "";
  set rolName(String value){
    _prefs.setString("rolName", value);
  }

  String get usNombre => _prefs.getString("usNombre") ?? "";
  set usNombre(String value){
    _prefs.setString("usNombre", value);
  }


//PERSONALIZACION MRDS
//   Color get colorA => _prefs.getString("colorA") ?? "";
//   set colorA(Color value) {
//     _prefs.setString("colorA", value);
//   }
//
  Color get colorA => Color(_prefs.getInt('color') ?? Colors.green.value);
  set colorA(Color value) {
    //_prefs.getInt("colorA", value);
  }

  Color get colorB => Color(_prefs.getInt('color') ?? Colors.redAccent.value);
  set colorB(Color value) {
    //_prefs.getInt("colorA", value);
  }




}