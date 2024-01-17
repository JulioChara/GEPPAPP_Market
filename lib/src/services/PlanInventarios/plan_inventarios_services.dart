import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_app/src/constants/constants.dart';
import 'package:market_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PlanInventariosServices {

  SPGlobal _prefs = SPGlobal();

  Future<List<PlanInventarioDetalleModel>> getPlanInventariosDetalles() async {
    List<PlanInventarioDetalleModel> modelList = [];
    String url = kUrl + "/PlanInventarios_ListarProductos_get";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      print(list);
      modelList = list.map((e) => PlanInventarioDetalleModel.fromJson(e)).toList();
      return modelList;
    }

    return modelList;
  }

  Future<List<PlanInventarioModel>> getPlanInventarios() async {
    List<PlanInventarioModel> modelList = [];
    String url = kUrl + "/PlanInventarios_ListarPlanInventarios_get";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      print(list);
      modelList = list.map((e) => PlanInventarioModel.fromJson(e)).toList();
      return modelList;
    }

    return modelList;
  }

  Future<List<PlanInventarioDetalleModel>> getPlanInventariosDetallesxId(String id) async {
    List<PlanInventarioDetalleModel> modelList = [];
    // String url = kUrl + "/ListadoNotasSalidaDetalle";
    String url = kUrl + "/PlanInventarios_ListarPlanInventariosDetallexId";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'id': id}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      modelList = list.map((e) => PlanInventarioDetalleModel.fromJson(e)).toList();
      return modelList;
    }
    return modelList;
  }

  Future<List<PlanInventarioDetalleModel>> getKardexInicial() async {
    List<PlanInventarioDetalleModel> modelList = [];
    String url = kUrl + "/PlanInventarios_ImportarKardexInicial";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      print(list);
      modelList = list.map((e) => PlanInventarioDetalleModel.fromJson(e)).toList();
      return modelList;
    }
    return modelList;
  }

  // Future<String> grabarPlanInventario(PlanInventarioModel model) async{   //OLD
  //   try {
  //     model.usuarioCreacion = _prefs.idUser;
  //     print(model.toJson());
  //
  //     String url = kUrl + "/PlanInventarios_CrearPlanInventario";
  //     http.Response response = await http.post(Uri.parse(url),
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json'
  //         },
  //         body: jsonEncode(model.toJson()));
  //     print(jsonEncode(model.toJson()));
  //     var decodeData = json.decode(response.body);
  //
  //     print(decodeData["resultado"]);
  //
  //     return decodeData["resultado"];
  //   } catch (e) {
  //     print(e);
  //     return "0";
  //   }
  // }

  Future<String> grabarPlanInventario(String Fecha) async{   //NEW
    try {
      // model.usuarioCreacion = _prefs.idUser;
      // print(model.toJson());

      String url = kUrl + "/GenerarPlanInventario";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'fechaApertura': Fecha, 'usuario': _prefs.idUser}));
      var decodeData = json.decode(response.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }




  Future<String> actualizarCantidadCierre(PlanInventarioDetalleModel model) async{
    try {
      print(model.toJson());
      String url = kUrl + "/PlanInventarios_ActualizarCantidadCierre";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(response.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<String> finalizarPlanInventario(String id) async{
    try {
      // print(model.toJson());
      String url = kUrl + "/PlanInventarios_FinalizarPlanInventarios";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'id': id, 'usuario': _prefs.idUser}));
      // print(jsonEncode(model.toJson()));
      var decodeData = json.decode(response.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }







}