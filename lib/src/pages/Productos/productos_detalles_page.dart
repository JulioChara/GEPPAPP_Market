
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:market_app/src/models/Productos/productos_detalles_model.dart';
import 'package:market_app/src/models/general_model.dart';
import 'package:market_app/src/services/PlanInventarios/plan_inventarios_services.dart';
import 'package:market_app/src/services/Productos/productos_detalles_services.dart';
import 'package:market_app/src/widgets/menu_widget.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:awesome_dialog/awesome_dialog.dart';



class ProductosDetallesPage extends StatefulWidget {
  const ProductosDetallesPage({super.key});

  @override
  State<ProductosDetallesPage> createState() => _ProductosDetallesPageState();
}

class _ProductosDetallesPageState extends State<ProductosDetallesPage> {




  SPGlobal _prefs = SPGlobal();


  final formKey = GlobalKey<FormState>();
  PlanInventarioDetalleModel _model = new PlanInventarioDetalleModel();


  GlobalKey<AutoCompleteTextFieldState<PlanInventarioDetalleModel>> keyProductos = new GlobalKey();

  TextEditingController _productController = TextEditingController();

  TextEditingController _idProductoController = TextEditingController();
  TextEditingController _nombreProductoController = TextEditingController();
  TextEditingController _stockProductoController = TextEditingController();
  TextEditingController _precioVentaProductoController = TextEditingController();


  AutoCompleteTextField ? searchProducto;
  String esProcesado = "";
  String idGeneral = "0";



  String selDate = DateTime.now().toString().substring(0, 10);
  List<PlanInventarioDetalleModel> productoLista = [];

  static List<PlanInventarioDetalleModel> productos = []; // empleado
  static List<ProductosDetallesModel> compras = [];
  List<ProductosDetallesModel> compras2 = [];
  List<ProductosDetallesModel> comprasLista = [];

  PlanInventariosServices _inventariosServices = PlanInventariosServices();
  ProductosDetallesServices _productosServices = ProductosDetallesServices();

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
      print("Inicio XD");
      productos = await _inventariosServices.getKardexInicial();
      print("Hola");
      print(productos.length);
      idGeneral = productos.first.productoFk!;  //para globalizar xd

      print("CHAU");
      setState(() {
        loading = false;
        print(productos.length);
      });
    } catch (e) {
      print(e);
    }
  }


  void obtenerCompras() async {
    try {
      print(_idProductoController.text);
      print(selDate);
      compras = await _productosServices.getComprasxProducto(_idProductoController.text, selDate);

      compras2 = compras;
      print("Helou");
      setState(() {
        comprasLista = compras;
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }


  void  scanQr() async { //gg


    var status = await Permission.camera.status;
    if (status.isDenied){
      print("Acceso Denegado");
      _showMyDialog();
    }else{
      print(":0");
      String? cameraScanResult = await scanner.scan();
      setState(() {
        qrValue = cameraScanResult!;

        List<PlanInventarioDetalleModel> lista = productos.where((element) => element.pdProductoCodigoBarras == qrValue).toList();
        _idProductoController.text = lista.first.productoFk!;
        _nombreProductoController.text = lista.first.pdProductoNombre!;
        _stockProductoController.text = lista.first.pdCantidadApertura!;
        _precioVentaProductoController.text = lista.first.pdProductoPrecio!;

        _productController.text = qrValue;

        comprasLista=[];
      });
    }




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

  //
  // showAlertDialog(context) => showCupertinoDialog<void>(
  //   builder: (buildContext context) => CupertinoAlertDialog(
  //
  //   )
  // )


  mensajeToast(String mensaje, Color colorFondo, Color colorText) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorFondo,
        textColor: colorText,
        fontSize: 16.0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRODUCTOS DETALLADOS"),
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
                controller: _stockProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Stock",
                  labelText: "Stock",
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
                controller: _precioVentaProductoController,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Precio Venta",
                  labelText: "Precio Venta",
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











              SizedBox(
                height: 10.0,
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 3)
                    ]),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Text(
                        selDate,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                  onPressed: () {
                       _selectSelDate(context);
                  },
                ),
              ),

              Row(
                children: [

                  // ],
                  //   ),
                ],
              ),

              Divider(
                height: 20.0,
              ),

              SizedBox(
                height: 20.0,
              ),
              CupertinoButton(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Obtener Compras",
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
                color: Colors.blue,
                // onPressed: precioController.text.length > 0 &&
                //         cantidadController.text.length > 0
                onPressed:() {
                  obtenerCompras();
                  mensajeToast("Cargando productos, espere....", Colors.black, Colors.white);
                },

              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                "LISTA DE COMPRAS",
                style: TextStyle(
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),


              SizedBox(
                height: 20.0,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 200, // fixed height
                    child: comprasLista.length > 0
                        ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8),
                        itemCount: comprasLista.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          return ListTile(
                            // leading: Icon(
                            //   Icons.arrow_forward_ios,
                            //   size: 15.0,
                            // ),
                            title: Text(
                              // comprasLista[index]
                              //     .productoFkDesc!
                              //     .toUpperCase(),
                              comprasLista[index]
                                  .proveedor!
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black54),
                            ),
                            subtitle: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [

                                Text(
                                  // "S/. : ${comprasLista[index].precioFinal!} ",
                                  "${comprasLista[index].fecha!} ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  // "S/. : ${comprasLista[index].precioFinal!} ",
                                  "S/. ${comprasLista[index].precioUnitario!} ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),

                            onTap: () {
                              // abrirScan(scans[i], context);
                            },
                          );
                        })
                        : Center(
                      child: Text(
                        "No hay productos en la lista.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black26),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),



              Divider(
                height: 20.0,
              ),
              // CupertinoButton(
              //   child: Container(
              //     width: double.infinity,
              //     child: Text(
              //       "Procesar Producto",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w400,
              //           letterSpacing: 1),
              //     ),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   color: Colors.lightGreen,
              //   onPressed: () {
              //     print("IniList");
              //     print("ENDList");
              //   },
              // ),
              SizedBox(
                height: 70.0,
              ),





            ],
          ),
        ),
      ),
    );
  }

  // String validado() {
  //   String errores = "";
  //
  //   try
  //   {
  //     if(_cantidadCierreProductoController.text == ""){
  //       errores = errores + "No puede ir la cantidad en blanco";
  //     }
  //     return errores;
  //   }catch(e)
  //   {
  //     return errores;
  //   }
  //
  //
  // }


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
              print("camara?");
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
          _nombreProductoController.text = item.pdProductoNombre!;
          _stockProductoController.text = item.pdCantidadApertura!;
          _precioVentaProductoController.text = item.pdProductoPrecio!;
          comprasLista=[];
       //   esProcesado = item.pdProcesadoCierre!;
    //      print(esProcesado);
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




  Future<Null> _selectSelDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        selDate = picked.toString().substring(0, 10);
        print(selDate);
        //  _listViaje(context, viaje);
      });
  }



}
