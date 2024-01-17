

//import 'dart:html';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:market_app/src/models/general_model.dart';
import 'package:market_app/src/services/PlanInventarios/plan_inventarios_services.dart';
import 'package:market_app/src/widgets/menu_widget.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:awesome_dialog/awesome_dialog.dart';

class ScanProductosPage extends StatefulWidget {


  @override
  State<ScanProductosPage> createState() => _ScanProductosPageState();
}

class _ScanProductosPageState extends State<ScanProductosPage> {
  SPGlobal _prefs = SPGlobal();


  final formKey = GlobalKey<FormState>();
  PlanInventarioDetalleModel _model = new PlanInventarioDetalleModel();


  GlobalKey<AutoCompleteTextFieldState<PlanInventarioDetalleModel>> keyProductos = new GlobalKey();

  TextEditingController _productController = TextEditingController();

  TextEditingController _idProductoController = TextEditingController();
  TextEditingController _idDetalleController = TextEditingController();
  TextEditingController _nombreProductoController = TextEditingController();
  TextEditingController _precioProductoController = TextEditingController();
  TextEditingController _medidaProductoController = TextEditingController();
  TextEditingController _cantidadAperturaProductoController = TextEditingController();
  TextEditingController _cantidadCierreProductoController = TextEditingController();


  AutoCompleteTextField ? searchProducto;
  String esProcesado = "";
  String idGeneral = "0";

  static List<PlanInventarioDetalleModel> productos = []; // empleado

  PlanInventariosServices _inventariosServices = PlanInventariosServices();

  bool loading = true;
  String qrValue = "Codigo Qr";

  @override
  void initState() {
    super.initState();
    getData();
    // getBluetooth();
  }
  void getData() async {
    try {

      productos = await _inventariosServices.getPlanInventariosDetalles();
      idGeneral = productos.first.planInventarioFk!;  //para globalizar xd

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void  scanQr() async {


    var status = await Permission.camera.status;
    if (status.isDenied){
      print("Acceso Denegado");
      _showMyDialog();
    }else {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        qrValue = cameraScanResult!;

        List<PlanInventarioDetalleModel> lista = productos.where((element) => element.pdProductoCodigoBarras == qrValue).toList();
        _idProductoController.text = lista.first.productoFk!;
        _idDetalleController.text = lista.first.id!;
        _nombreProductoController.text = lista.first.pdProductoNombre!;
        _precioProductoController.text = lista.first.pdProductoPrecio!;
        _medidaProductoController.text = lista.first.tipoUnidadMedidaFkDesc!;
        _cantidadAperturaProductoController.text = lista.first.pdCantidadApertura!;
        _cantidadCierreProductoController.text =lista.first.pdCantidadCierre!;
        esProcesado = lista.first.pdProcesadoCierre!;

        _productController.text = qrValue;
      });
    }





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scannear Productos QR"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
      ),
      drawer: MenuWidget(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //AQUA CAMBIOS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget>[
                  SizedBox (
                    width: 10.0,
                  ),

                ],
              ),

              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  searchProducto = fieldEntidad(),
                ] ,
              ),

              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: _idDetalleController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Id Detalle",
                  labelText: "Id Detalle",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                // validator: (String value) {
                //   if (value.isEmpty) {
                //     return "Ingrese una Serie";
                //   }
                //   return null;
                // },
                maxLines: 1,
                readOnly: true,
              ),
              SizedBox(height: 15.0,),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _idProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Id Producto",
                  labelText: "Id Producto",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                // validator: (String value) {
                //   if (value.isEmpty) {
                //     return "Ingrese una Serie";
                //   }
                //   return null;
                // },
                maxLines: 1,
                readOnly: true,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _nombreProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Nombre Producto",
                  labelText: "Nombre Producto",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                // validator: (String value) {
                //   if (value.isEmpty) {
                //     return "Ingrese una Serie";
                //   }
                //   return null;
                // },
                maxLines: 2,
                readOnly: true,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _precioProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Precio Apertura Producto",
                  labelText: "Precio Apertura Producto",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 1,
                readOnly: true,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _medidaProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Unidad de Medida",
                  labelText: "Unidad de Medida",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 1,
                readOnly: true,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _cantidadAperturaProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: "Cantidad Apertura",
                  labelText: "Cantidad Apertura",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 1,
                readOnly: true,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                controller: _cantidadCierreProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: "Cantidad Cierre",
                  labelText: "Cantidad Cierre",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("assets/icons/document.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 1,
                readOnly: esProcesado=="True"?true:false,
              ),

              // Text(
              //   qrValue,
              //   style: const TextStyle(
              //     color: Colors.redAccent,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              //
              //    SizedBox(
              //     height: 12.0,
              //   ),
              //   ElevatedButton(
              //     onPressed: () {
              //     //  scanQr();
              //      // getDataDocumentGenerate();
              //      // print('CosasQR');
              //
              //     },
              //     child: Text(
              //       "Abrir Scanner",
              //     ),
              //   ),

              Divider(
                height: 20.0,
              ),
              CupertinoButton(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Procesar Producto",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                color: Colors.lightGreen,
                onPressed: () {

                  // if(productoLista.length ==0){
                  //   showMessajeAW(DialogType.ERROR, "Validacion","Debe agregar productos a la Lista", 0);
                  //   return;
                  // }
                  print("IniList");
                  print("ENDList");

                  String validar = validado();
                  if (validar.length > 0) {
                    print("Pre");
                    showMessajeAW(DialogType.ERROR, "Validacion",
                        validar, 0);
                    print("Pos");
                    return;
                  } else {
                    AwesomeDialog(
                      dismissOnTouchOutside: false,
                      context: context,
                      dialogType: DialogType.QUESTION,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      showCloseIcon: true,
                      closeIcon: const Icon(
                          Icons.close_fullscreen_outlined),
                      title: "Confirmacion",
                      descTextStyle: TextStyle(fontSize: 18),
                      desc: "¿Desea Procesar el Producto?",
                      btnCancelOnPress: () {},
                      onDissmissCallback: (type) {
                        debugPrint(
                            'Dialog Dissmiss from callback $type');
                      },
                      btnOkOnPress: () {
                        registrar();
                      },
                    ).show();
                  }

                },
              ),
              SizedBox(
                height: 70.0,
              ),





            ],
          ),
        ),
      ),
    );
  }



  void registrar() {
    //  if (formKey.currentState!.validate()) {



    _model.id = _idDetalleController.text;
    _model.planInventarioFk = productos.first.planInventarioFk;
    _model.pdCantidadCierre = _cantidadCierreProductoController.text;
    _model.usuarioModificacion = _prefs.idUser;

    _inventariosServices.actualizarCantidadCierre(_model)
        .then((value) {
      print("Salvadito ?");
      print(value);
      if (value != null) {
        if (value == "1") {
          print("Actualizado Save");
          // Navigator.pop(context);
          showMensajeriaAW(DialogType.SUCCES, "Confirmacion", "Actualizado correctamente", "1");
        }else if(value == "2")
        {
          showMensajeriaAW(DialogType.ERROR, "ERROR", "El plan de inventario ya se encuentra finalizado!!", "0");
        }else if(value == "3")
        {
          showMensajeriaAW(DialogType.ERROR, "ERROR", "El producto ya se encuentra procesado", "0");

        }else
        {
          showMensajeriaAW(DialogType.ERROR, "ERROR", "Ocurrio un error no controlado", "0");
        }
      }
    });
    //  }
  }

  String validado() {
    String errores = "";

    try
    {
      if(_cantidadCierreProductoController.text == ""){
        errores = errores + "No puede ir la cantidad en blanco";
      }
      return errores;
    }catch(e)
    {
      return errores;
    }


  }


  showMensajeriaAW(DialogType tipo, String titulo, String desc, String Accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        if (Accion == "1") {
          // Navigator.pop(context);
          Navigator.pushReplacementNamed(
              context, 'home');
        }

      },
    ).show().then((value) {
      //    getData();
      setState(() {});
    });
  }


  showMessajeAW(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              //Cuando se genera el pedido
              Navigator.pushReplacementNamed(
                context,
                'planInventarios',
              );
            }
            break;
        }
      },
    ).show();
  }





  AutoCompleteTextField<PlanInventarioDetalleModel> fieldEntidad() {
    return AutoCompleteTextField<PlanInventarioDetalleModel>(
      controller: _productController,
      key: keyProductos,
      clearOnSubmit: false,
      suggestions: productos,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Producto",
        labelText: "Producto",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/product.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon:
        CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFF000000),
          child: IconButton(
            icon: const Icon(
              Icons.qr_code_2_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              scanQr();
              // consultaSunat(_rucController.text);
            },
          ),
        ),
      ),
      itemFilter: (item, query) {
        //return item.entiRazonSocial.toLowerCase().contains(query.toLowerCase());
        return item.pdProductoNombre!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.pdProductoNombre!.compareTo(b.pdProductoNombre!);
      },
      itemSubmitted: (item) {
        setState(() {
          print(item.pdProductoCodigoBarras);
          searchProducto!.textField!.controller!.text = item.pdProductoCodigoBarras!;
          _idProductoController.text = item.productoFk!;
          _idDetalleController.text = item.id!;
          _nombreProductoController.text = item.pdProductoNombre!;
          _precioProductoController.text = item.pdProductoPrecio!;
          _medidaProductoController.text = item.tipoUnidadMedidaFkDesc!;
          _cantidadAperturaProductoController.text = item.pdCantidadApertura!;
          _cantidadCierreProductoController.text = item.pdCantidadCierre!;
          esProcesado = item.pdProcesadoCierre!;
          print(esProcesado);
          //searchEntidad.textField.controller.text = item.entiNroDocumento;
          // _razonController.text = item.entiRazonSocial;
          // idEntidad = item.entiId;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowEntidad(item);
      },
    );

  }
  //
  Widget rowEntidad(PlanInventarioDetalleModel empleado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              empleado.pdProductoNombre! +" - " +  empleado.pdProductoCodigoBarras!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // fontSize: 16.0,
                fontSize: 10.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permitir Acceso a Camara'),
          content: const SingleChildScrollView(
            // child: ListBody(
            //   children: <Widget>[
            //     Text('This is a demo alert dialog.'),
            //     Text('Would you like to approve of this message?'),
            //   ],
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abrir Ajustes'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}
