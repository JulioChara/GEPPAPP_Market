



import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:market_app/src/services/PlanInventarios/plan_inventarios_services.dart';
import 'package:market_app/utils/sp_global.dart';

class PlanInventariosCrearPage extends StatefulWidget {

  @override
  State<PlanInventariosCrearPage> createState() => _PlanInventariosCrearPageState();
}

class _PlanInventariosCrearPageState extends State<PlanInventariosCrearPage> {
  bool loading = true;
  bool loadingSend = false;

  String idAsignadoFk = "0";
  String cantidadTotal = "0.00";

  SPGlobal _prefs = SPGlobal();
  TextEditingController subClienteController = new TextEditingController();

  PlanInventarioModel _model = new PlanInventarioModel();
  String selDate = DateTime.now().toString().substring(0, 10);
  List<PlanInventarioDetalleModel> productoLista = [];

  static List<PlanInventarioDetalleModel> productos = [];
  List<PlanInventarioDetalleModel> productos2 = [];

  // static List<UsuariosModel> conductores =
  // <UsuariosModel>[]; // usuarios conductores
  // static List<TiposModel> destinos = <TiposModel>[]; // Destinos

  PlanInventariosServices _planInventariosServices = PlanInventariosServices();


  void getData() async {
    try {
      //cabecera
      //   conductores = await _generalServices.getUsuariosConductores();
      //
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // idNotaGlobal = prefs.getString("idNota").toString();

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void obtenerProductos() async {
    try {
      productos = await _planInventariosServices.getKardexInicial();
      productos2 = productos; //
      //  print(productos2);
      //_productosDropdownMenuItems = buildDropDownMenuProductos(productos2);
      // print("Items en Lista 2: ");
      // print(productos2);

      setState(() {
        productoLista = productos; //test
        cantidadTotal = productoLista.length.toString();
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  // addItemProducto(PlanInventarioDetalleModel producto) {
  //   double cantNew = double.parse(producto.pedcCantidad!);
  //
  //   bool aes = false;
  //   if (productoLista.length > 0) {
  //     for (PedidosDeliverySalidaModel items in productoLista) {
  //       if (items.productoFk == producto.productoFk) {
  //         items.pedcCantidad =
  //             (double.parse(items.pedcCantidad!) + cantNew).toStringAsFixed(2);
  //         aes = true;
  //       }
  //     }
  //   } else {
  //     productoLista.add(producto);
  //     print("adddd1");
  //     aes = true;
  //   }
  //
  //   if (aes == false) {
  //     print("adddd2");
  //     productoLista.add(producto);
  //   }
  //
  //   print("Lista Genertal");
  //   productoLista.forEach((element) {
  //     print(element.pedcCantidad);
  //   });
  //   print("END Lista Genertal");
  //
  //   print(producto.toJson());
  //   print("Lista...");
  //   setState(() {});
  // }




  // void ShowMessage(String mess, int pop) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       //ALIMENTOS
  //       return MensajeWidget(
  //         mensaje: mess,
  //         pop: pop,
  //       );
  //     },
  //   ).then((val) {
  //     loading = false;
  //     //    getData();
  //     //   print("Recarga de Datos xd");
  //     setState(() {});
  //   });
  // }


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


  _sendData() async{
    _model.piFechaApertura = selDate;
    _model.detalle = productoLista;

    setState(() {
      loadingSend = true;
    });
    String res =
    // await _planInventariosServices.grabarPlanInventario(_model);
    await _planInventariosServices.grabarPlanInventario(_model.piFechaApertura.toString());

    print(res);
    if (res == "1") {
      // ShowMessage("Pedido generado correctamente.", 1);
      showMessajeAW(DialogType.SUCCES, "Confirmacion",
          "Pedido generado correctamente.", 1);
      // Navigator.pushReplacementNamed(context, 'home',);
    } else {
      // ShowMessage("Ocurrio un error al generar el pedido, revise la informacion.", 0);
      showMessajeAW(DialogType.ERROR, "Error",
          "Ocurrio un error al generar el registri, revise su conexion y que no haya un plan de inventario activo.", 0);
    }
    loadingSend = false;
    setState(() {});


  }
  // _sendData() async {
  //   print(usuarioGlobal);
  //   _facturacionModel.asignadoFk = idAsignadoFk;
  //   _facturacionModel.destinoFk = idDestinoFk;
  //   _facturacionModel.descripcion = descripcionController.text;
  //
  //   _facturacionModel.usuarioCreacion = usuarioGlobal;
  //   _facturacionModel.totalGalones = cantidadTotal;


  //
  //   setState(() {
  //     loadingSend = true;
  //   });
  //   String res =
  //   await _pedidosDeliveryServices.grabarPedidosDelivery(_facturacionModel);
  //
  //   print(res);
  //   if (res == "1") {
  //     // ShowMessage("Pedido generado correctamente.", 1);
  //     showMessajeAW(DialogType.SUCCES, "Confirmacion",
  //         "Pedido generado correctamente.", 1);
  //     // Navigator.pushReplacementNamed(context, 'home',);
  //   } else {
  //     // ShowMessage("Ocurrio un error al generar el pedido, revise la informacion.", 0);
  //     showMessajeAW(DialogType.ERROR, "Error",
  //         "Ocurrio un error al generar el pedido, revise la informacion.", 0);
  //   }
  //   loadingSend = false;
  //   setState(() {});
  // }

  // void obtenerProductos() async {
  //   try {
  //     productos = await _pedidosDeliveryServices.getAllProductosDelivery();
  //     productos2 = productos; //
  //     //  print(productos2);
  //     _productosDropdownMenuItems = buildDropDownMenuProductos(productos2);
  //     // print("Items en Lista 2: ");
  //     // print(productos2);
  //     setState(() {
  //       loading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Creacion de Pedido"),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[_prefs.colorA, _prefs.colorB])),
            ),
          // backgroundColor: Colors.indigo,
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "DATOS GENERALES",
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
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
                            //   _selectSelDate(context);
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),

                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      //
                      // const Text (
                      //   "OBTENER PRODUCTOS KARDEX",
                      //   style: TextStyle(
                      //       fontSize: 18.0,
                      //       letterSpacing: 1.0,
                      //       color: Colors.black54,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Row(
                        children: [

                          // ],
                          //   ),
                        ],
                      ),

                      // const SizedBox(
                      //    height: 20.0,
                      //  ),

                      // TextFormField(
                      //   controller: descripcionController,
                      //   style: TextStyle(
                      //       color: Colors.black, fontSize: 16.0),
                      //   textAlign: TextAlign.center,
                      //   decoration: InputDecoration(
                      //     hintText: "estimacion de Clientes",
                      //     labelText: "Estimacion",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/adjust.svg"),
                      //     ),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   maxLines: 7,
                      //   keyboardType: TextInputType.text,
                      //   keyboardAppearance: Brightness.light,
                      //   textInputAction: TextInputAction.next,
                      //   onFieldSubmitted: (String text) {},
                      //   onChanged: (value) {
                      //     // cantidadTotal = value;
                      //     setState(() {});
                      //   },
                      // ),


                      // const SizedBox(
                      //   height: 20.0,
                      // ),

                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     labelText: "Producto",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //         "assets/icons/service.svg",
                      //         color: Colors.black54,
                      //       ),
                      //     ),
                      //     contentPadding: EdgeInsets.all(10.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   isExpanded: true,
                      //   value: _modelProductos,
                      //   items: _productosDropdownMenuItems,
                      //   onChanged: onChangeDropdownProductos,
                      //   elevation: 2,
                      //   style: TextStyle(
                      //       color: Colors.black54, fontSize: 16),
                      //   isDense: true,
                      //   iconSize: 40.0,
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      // TextFormField(
                      //   controller: cantidadController,
                      //   style: TextStyle(
                      //       color: Colors.black, fontSize: 16.0),
                      //   textAlign: TextAlign.center,
                      //   decoration: InputDecoration(
                      //     hintText: "ingrese una cantidad",
                      //     labelText: "Cantidad",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/adjust.svg"),
                      //     ),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   maxLines: 1,
                      //   keyboardType: TextInputType.number,
                      //   keyboardAppearance: Brightness.light,
                      //   textInputAction: TextInputAction.next,
                      //   onFieldSubmitted: (String text) {},
                      //   onChanged: (value) {
                      //     // cantidadTotal = value;
                      //     setState(() {});
                      //   },
                      // ),
                      Divider(
                        height: 20.0,
                      ),

                      // TextFormField(
                      //   controller: precioController,
                      //   style: TextStyle(
                      //       color: Colors.black, fontSize: 16.0),
                      //   textAlign: TextAlign.center,
                      //   decoration: InputDecoration(
                      //     hintText: "Precio",
                      //     labelText: "Precio",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/dolar.svg"),
                      //     ),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   maxLines: 1,
                      //   keyboardType: TextInputType.number,
                      //   keyboardAppearance: Brightness.light,
                      //   textInputAction: TextInputAction.next,
                      //   onFieldSubmitted: (String text) {},
                      //   readOnly: true,
                      //   onChanged: (value) {
                      //     setState(() {});
                      //   },
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Obtener Productos",
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
                          obtenerProductos();
                          mensajeToast("Cargando productos, espere....", Colors.black, Colors.white);
                        },

                        // onPressed: cantidadController.text.length > 0
                        //     ? () {
                        //   try {
                        //     if (double.parse(
                        //         cantidadController.text) >
                        //         0) {
                        //       print("Es un Numero +");
                        //
                        //       var prod =
                        //       new PedidosDeliverySalidaModel(
                        //         //   idDet: _modelProductos!.idDet,
                        //         // clienteFk: idClienteFk,
                        //         //   clienteFkDesc: idClienteFkDesck
                        //         pedcCantidad:
                        //         cantidadController.text,
                        //         productoFk:
                        //         _modelProductos!.productoFk,
                        //         productoFkDesc:
                        //         _modelProductos!.productoFkDesc,
                        //         // precioFinal:
                        //         //     _modelProductos!.pedcCantidad,
                        //       );
                        //       addItemProducto(prod);
                        //       //ConceptoEditingController.clear();
                        //     } else {
                        //       print("Es un Numero -");
                        //     }
                        //   } catch (e) {
                        //     print("No es un numero");
                        //   }
                        // }
                        //    : null,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "DETALLE",
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200, // fixed height
                            child: productoLista.length > 0
                                ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(8),
                                itemCount: productoLista.length,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.0,
                                    ),
                                    title: Text(
                                      // productoLista[index]
                                      //     .productoFkDesc!
                                      //     .toUpperCase(),
                                      productoLista[index]
                                          .pdProductoNombre!
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
                                        // Text(
                                        //   // "Cant.: ${productoLista[index].cantidad!} ",
                                        //   "${productoLista[index].productoFkDesc!}",
                                        //   style: TextStyle(
                                        //       fontSize: 15.0,
                                        //       fontWeight:
                                        //           FontWeight.bold,
                                        //       color: Colors.black),
                                        // ),
                                        Text(
                                          // "S/. : ${productoLista[index].precioFinal!} ",
                                          "${productoLista[index].pdCantidadApertura!} ",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    // trailing: Container(
                                    //   padding: EdgeInsets.zero,
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.delete),
                                    //     color:
                                    //     Colors.redAccent.shade200,
                                    //     onPressed: () {
                                    //       print(index);
                                    //
                                    //       // for (PedidosDeliveryDetalleModel items in productos2) {
                                    //       //   if(items.idDet == productoLista[index].idDet!){
                                    //       //
                                    //       //     items.cantidad = (double.parse(items.cantidad!) + double.parse(productoLista[index].cantidad!)).toStringAsFixed(2);
                                    //       //     _productosDropdownMenuItems = buildDropDownMenuProductos(productos2);
                                    //       //   }
                                    //       // }
                                    //       productoLista
                                    //           .removeAt(index);
                                    //  //     actualizarTotal();
                                    //       setState(() {});
                                    //     },
                                    //   ),
                                    // ),
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
                      Text("Productos a Importar"),
                      Text("${cantidadTotal}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40)),
                      Divider(
                        height: 20.0,
                      ),
                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "GENERAR PLAN DE INVENTARIO",
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

                          if(productoLista.length ==0){
                            showMessajeAW(DialogType.ERROR, "Validacion","Debe agregar productos a la Lista", 0);
                            return;
                          }
                          print("IniList");
                          // productoLista.forEach((element) {
                          //   print(element.pdCantidadApertura);
                          // });
                          print("ENDList");

                          String validar = validado();
                          if (validar.length > 0) {
                            print("Pre");
                            showMessajeAW(DialogType.ERROR, "Validacion",
                                validar, 0);
                            print("Pos");
                            // print(validar);
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
                              desc: "¿Desea guardar el pedido?",
                              btnCancelOnPress: () {},
                              onDissmissCallback: (type) {
                                debugPrint(
                                    'Dialog Dissmiss from callback $type');
                              },
                              btnOkOnPress: () {
                                _sendData();
                              },
                            ).show();
                          }

                          //   showMessajeAW(DialogType.QUESTION, "Consulta", "Desea grabar la informacion?");

//                                 showDialog(
//                                     context: context,
//                                     barrierDismissible: true,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0)),
//                                         title: Text("Atención"),
//                                         content: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: <Widget>[
//                                             Text(
//                                                 "Esta seguro de grabar la venta?"),
//                                             SizedBox(
//                                               height: 10.0,
//                                             ),
// //
//                                           ],
//                                         ),
//                                         actions: <Widget>[
//                                           FlatButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text("Cancelar"),
//                                           ),
//                                           FlatButton(
//                                             onPressed: () {
//                                               _sendData();
//                                               setState(() {});
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text("Enviar"),
//                                           )
//                                         ],
//                                       );
//                                     });
                        },
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (loadingSend)
              Positioned(
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
  }


  //CONDUCTORES

  String validado() {
    String errores = "";

    // if (idAsignadoFk == "0") {
    //   errores = errores + "\n >Asigne un conductor";
    // }
    // if (idDestinoFk == "0") {
    //   errores = errores + "\n>Seleccione un destino";
    // }


    return errores;
  }

  //
  // onChangeDropdownProductos(PedidosDeliverySalidaModel? selectedProductos) {
  //   setState(() {
  //     _modelProductos = selectedProductos;
  //     print(_modelProductos!.toJson());
  //     // precioController.text = _modelProductos!.precioFinal!;
  //   });
  // }


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
