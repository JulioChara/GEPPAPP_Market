

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:market_app/src/constants/constants.dart';

class LoginServices {

  SPGlobal _prefs = SPGlobal();

  Future<String>login(String user, String pwd) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //var resp = await http.post(kUrl +"/LoginApp", headers: {
      var resp = await http.post(Uri.parse(kUrl +"/LoginApp"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'usr': user, 'pwd': pwd}));

      print(resp.statusCode);

      var decodeData = json.decode(resp.body);

      var result = decodeData["resultado"];

      print(result);

      if(result == "1"){

        _prefs.isLogin = true;
        _prefs.rolId = decodeData["rolid"];
        _prefs.idUser = decodeData["id"];
        _prefs.usNombre = decodeData["usNombre"];
        _prefs.rolName = decodeData["rolName"];
        //impresiones
        // _prefs.spImpEmpDireccion ="Carretera Panamericana Sur Nro 610";
        // _prefs.spImpEmpTelefono = "+51 989318816";


        await prefs.setBool("wasLogin", true);
        await prefs.setString("idUser", decodeData["id"]);
        await prefs.setString("nameUser", user);
        await prefs.setString("usEntidad", decodeData["usEntidad"]);
        await prefs.setString("rol", decodeData["rol"]);
        await prefs.setString("rolId", decodeData["rolid"]);
        return decodeData["id"];


      }
      else{
        print("Pre");
        return decodeData["resultado"];
      }
    } catch (e) {
      print("Error en catch");
      print(e);
      return "0";
    }
  }
}