import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_app/src/constants/constants.dart';
import 'package:market_app/src/models/Productos/productos_detallados_model.dart';
import 'package:market_app/src/models/Productos/productos_detalles_model.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductosDetallesServices{

  SPGlobal _prefs = SPGlobal();

  Future<List<ProductosDetallesModel>> getComprasxProducto(String id, String fecha) async {
    List<ProductosDetallesModel> modelList = [];
    String url = kUrl + "/ListarComprasxProducto";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'IdProducto': id, 'Fecha':fecha }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      modelList = list.map((e) => ProductosDetallesModel.fromJson(e)).toList();
      return modelList;
    }
    return modelList;
  }



  Future<List<ProductosDetalladoModel>> getProductoDetallado() async {
    List<ProductosDetalladoModel> modelList = [];
    String url = kUrl + "/Productos_ObtenerProducto";
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      print(list);
      modelList = list.map((e) => ProductosDetalladoModel.fromJson(e)).toList();
      return modelList;
    }
    return modelList;
  }




  Future<List<TiposModel>> getTipos_Familias() async {
    try {
      String url = kUrl + "/Productos_TiposFamilia";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var decodeData = json.decode(resp.body);

      final List<TiposModel> tipos = [];
      decodeData.forEach((item) {
        final tipoTemp = TiposModel.fromJson(item);
        tipos.add(tipoTemp);
      });
      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TiposModel>> getTipos_Tipos(String id) async {
    try {
      // var resp = await http.get(kUrl + "/UtilidadesGuias");
      String url = kUrl + "/Productos_TiposTipo";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id}));

      var decodeData = json.decode(response.body);

      final List<TiposModel> tipos = [];
      decodeData.forEach((item) {
        final tipoTemp = TiposModel.fromJson(item);
        tipos.add(tipoTemp);
      });

      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TiposModel>> getTipos_Unidad() async {
    try {
      String url = kUrl + "/Productos_TiposUnidad";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var decodeData = json.decode(resp.body);

      final List<TiposModel> tipos = [];
      decodeData.forEach((item) {
        final tipoTemp = TiposModel.fromJson(item);
        tipos.add(tipoTemp);
      });
      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TiposModel>> getTipos_Estantes() async {
    try {
      String url = kUrl + "/Productos_TiposEstantes";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var decodeData = json.decode(resp.body);

      final List<TiposModel> tipos = [];
      decodeData.forEach((item) {
        final tipoTemp = TiposModel.fromJson(item);
        tipos.add(tipoTemp);
      });
      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<TiposModel>> getTipos_SubEstantes(String id) async {
    try {
      String url = kUrl + "/Productos_TiposSubEstantes";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id}));

      var decodeData = json.decode(response.body);

      final List<TiposModel> tipos = [];
      decodeData.forEach((item) {
        final tipoTemp = TiposModel.fromJson(item);
        tipos.add(tipoTemp);
      });

      return tipos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> actualizarProducto(ProductosDetalladoModel model) async{
    try {
      //model.usuarioCreacion = _prefs.idUser;
      print(model.toJson());

      String url = kUrl + "/Productos_ActualizarProducto";
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





}

