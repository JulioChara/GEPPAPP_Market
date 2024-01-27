


import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market_app/src/models/Productos/productos_detallados_model.dart';
import 'package:market_app/src/services/Productos/productos_detalles_services.dart';
import 'package:market_app/src/widgets/menu_widget.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ProductosEditarPage extends StatefulWidget {
  const ProductosEditarPage({super.key});

  @override
  State<ProductosEditarPage> createState() => _ProductosEditarPageState();
}

class _ProductosEditarPageState extends State<ProductosEditarPage> {







  SPGlobal _prefs = SPGlobal();


  final formKey = GlobalKey<FormState>();
  ProductosDetalladoModel _savemodel = new ProductosDetalladoModel();


  GlobalKey<AutoCompleteTextFieldState<ProductosDetalladoModel>> keyProductos = new GlobalKey();

  TextEditingController _productController = TextEditingController();

  TextEditingController _idProductoController = TextEditingController();
  TextEditingController _nombreProductoController = TextEditingController();
  //TextEditingController _stockProductoController = TextEditingController();
  TextEditingController _precioVentaProductoController = TextEditingController();


  AutoCompleteTextField ? searchProducto;
  String esProcesado = "";
  String idGeneral = "0";



  String selDate = DateTime.now().toString().substring(0, 10);
  List<ProductosDetalladoModel> productoLista = [];

  static List<ProductosDetalladoModel> productos = []; // empleado

  //ProductosDetalladoModel _inventariosServices = PlanInventariosServices();
  ProductosDetallesServices _productosServices = ProductosDetallesServices();

  bool loading = true;
  String qrValue = "Codigo Qr";


  TiposModel? _selectedFamilia;
  TiposModel? _selectedTipo;
  TiposModel? _selectedTipoUnidad;
  TiposModel? _selectedTipoEstante;
  TiposModel? _selectedTipoSubEstante;
  List<DropdownMenuItem<TiposModel>>? _familiaDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoUnidadDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoEstanteDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoSubEstanteDropdownMenuItems;


  static List<TiposModel> listFamilia = [];
  static List<TiposModel> listTipo = [];
  static List<TiposModel> listTipoUnidad = [];
  static List<TiposModel> listTipoEstante = [];
  static List<TiposModel> listTipoSubEstante = [];
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyFamilia = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipo = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoUnidad = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoEstante = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoSubEstante = new GlobalKey();

  bool checkEstado = false;

  @override
  void initState() {
    super.initState();
    getData();
    // getBluetooth();
  }


  void ActualizadoresTipo(int cate, String id) async {
    loading = true;
    if(cate==1){
      // listTipo = await _productosServices.getTipos_Tipos(_selectedFamilia!.tipoDescripcion!);  ///ya esta bien  XD
      listTipo = await _productosServices.getTipos_Tipos(id);  ///ya esta bien  XD
      _tipoDropdownMenuItems = buildDropDownMenuTiposTipo(listTipo);
      _selectedTipo = listTipo.first;
      _savemodel.tiposProductoFk = listTipo.first.tipoId;
    }else if(cate ==2){
      // listTipoSubEstante = await _productosServices.getTipos_SubEstantes(_selectedTipoEstante!.tipoDescripcion!);  ///para sub estantes
      listTipoSubEstante = await _productosServices.getTipos_SubEstantes(id);  ///para sub estantes
      _tipoSubEstanteDropdownMenuItems = buildDropDownMenuTiposSubEstante(listTipoSubEstante);
      _selectedTipoSubEstante = listTipoSubEstante.first;
      _savemodel.tipoSubEstanteFk = listTipo.first.tipoId;
    }

    setState(() {
      loading =false;
    });


  }

  onChangeDropdownTiposFamilia(TiposModel? selectModel) {
    setState(() {
      _selectedFamilia = selectModel;
      _savemodel.tiposFamiliaFk = selectModel!.tipoId;
      ActualizadoresTipo(1, selectModel.tipoDescripcion!);
    });
  }
  onChangeDropdownTiposTipo(TiposModel? selectModel) {
    setState(() {
      _selectedTipo = selectModel;
      _savemodel.tiposProductoFk = selectModel!.tipoId;
    });
  }
  onChangeDropdownTiposUnidad(TiposModel? selectModel) {
    setState(() {
      _selectedTipoUnidad = selectModel;
      _savemodel.tiposUnidadMedidaFk = selectModel!.tipoId;
    });
  }
  onChangeDropdownTiposEstante(TiposModel? selectModel) {
    setState(() {
      _selectedTipoEstante = selectModel;
      _savemodel.tipoEstanteFk = selectModel!.tipoId;
      ActualizadoresTipo(2, selectModel.tipoDescripcion!);
    });
  }
  onChangeDropdownTiposSubEstante(TiposModel? selectModel) {
    setState(() {
      _selectedTipoSubEstante = selectModel;
      _savemodel.tipoSubEstanteFk = selectModel!.tipoId;
    });
  }

  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposFamilia(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposTipo(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!),));
    }
    return items;
  }
  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposUnidad(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!),));
    }
    return items;
  }
  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposEstante(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!),));
    }
    return items;
  }
  List<DropdownMenuItem<TiposModel>> buildDropDownMenuTiposSubEstante(List tipos) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.tipoDescripcion!),));
    }
    return items;
  }

  void getData() async {
    try {
      print("Inicio XD");
      productos = await _productosServices.getProductoDetallado();
      print("Hola");
      print(productos.length);
      idGeneral = productos.first.prodId!;  //para globalizar xd

      print("CHAU");

      //LLEGAR COMBOS
      listFamilia = await _productosServices.getTipos_Familias();
      _familiaDropdownMenuItems = buildDropDownMenuTiposFamilia(listFamilia);

      listTipoUnidad = await _productosServices.getTipos_Unidad();
      _tipoUnidadDropdownMenuItems = buildDropDownMenuTiposUnidad(listTipoUnidad);

      listTipoEstante = await _productosServices.getTipos_Estantes();
      _tipoEstanteDropdownMenuItems = buildDropDownMenuTiposEstante(listTipoEstante);

      setState(() {
        
        
        loading = false;
     //   _selectedFamilia = listFamilia.where((element) => element.tipoId == listFamilia.first.tipoId).first;
        print(productos.length);
      });
    } catch (e) {
      print(e);
    }
  }



  String validado() {
    String errores = "";
    try {
      if (_savemodel.prodId == "0" || _savemodel.prodId == "") {
        errores = errores + "No se selecciono ningun producto";
      }
      if (_savemodel.prodCodigoBarrasPrincipal!.length < 1) {
        errores = errores + "\nCodigo de Barras muy Corto";
      }
      if (_savemodel.prodNombre!.length < 3) {
        errores = errores + "\nNombre de producto muy Corto";
      }
      if (double.parse(_savemodel.prodPrecio!) * 1 != double.parse(_savemodel.prodPrecio!)) {
        errores = errores + "\nNo es un Numero";
      }

    }
    catch(error){
      errores = errores + "Erroes Catch Conversion Numerica";
    }


    return errores;
  }



  _sendData() async{
    _savemodel.prodCodigoBarrasPrincipal = _productController.text;
    _savemodel.prodId = _idProductoController.text;
    _savemodel.prodNombre = _nombreProductoController.text;
    _savemodel.prodPrecio = _precioVentaProductoController.text;
    // _savemodel.tiposFamiliaFk =
    // _savemodel.tiposProductoFk =
    // _savemodel.tiposUnidadMedidaFk =
    // _savemodel.tipoEstanteFk =
    // _savemodel.tipoSubEstanteFk =
    _savemodel.prodEstado = checkEstado.toString();
    _savemodel.prodUsrModificacion = _prefs.idUser;


    String validar = validado();
    if (validar.length >0){
      showMessajeAW(DialogType.ERROR, "Errores",
          validar, 0);
      return;
    }

    setState(() {
      loading = true;
    });
    String res =
    // await _planInventariosServices.grabarPlanInventario(_model);
    await _productosServices.actualizarProducto(_savemodel);

    print(res);
    if (res == "1") {
      // ShowMessage("Pedido generado correctamente.", 1);
      showMessajeAW(DialogType.SUCCES, "Confirmacion",
          "Producto Actualizado correctamente.", 2);
      // Navigator.pushReplacementNamed(context, 'home',);
    } else {
      // ShowMessage("Ocurrio un error al generar el pedido, revise la informacion.", 0);
      showMessajeAW(DialogType.ERROR, "Error",
          "Ocurrio un error al actualizar el producto.", 0);
    }
    loading = false;
    setState(() {});


  }




  void getValores(String ProId) async {
    try {
      loading = true;
      ProductosDetalladoModel myProd = productos.where((element) => element.prodId == ProId).first;
      _savemodel.tiposFamiliaFk = myProd.tiposFamiliaFk;
      _savemodel.tiposProductoFk = myProd.tiposProductoFk;
      _savemodel.tiposUnidadMedidaFk = myProd.tiposUnidadMedidaFk;
      _savemodel.tipoEstanteFk = myProd.tipoEstanteFk;
      _savemodel.tipoSubEstanteFk = myProd.tipoSubEstanteFk;


      checkEstado = (myProd.prodEstado == "False"? false : true);
      print("Valor de Producto"+ ProId);
      _selectedFamilia = listFamilia.where((element) => element.tipoId == myProd.tiposFamiliaFk).first;
      _selectedTipoUnidad = listTipoUnidad.where((element) => element.tipoId == myProd.tiposUnidadMedidaFk).first;
      _selectedTipoEstante = listTipoEstante.where((element) => element.tipoId == myProd.tipoEstanteFk).first;

      print("FAMILIA: "+ _selectedFamilia!.tipoDescripcion!);
      print("UNIDAD: "+ _selectedTipoUnidad!.tipoDescripcion!);
      print("ESTANTE: "+ _selectedTipoEstante!.tipoDescripcion!);

      print(_selectedFamilia!.toJson());
      listTipo = await _productosServices.getTipos_Tipos(_selectedFamilia!.tipoDescripcion!);  ///esta mal :(((  //ya esta bien  XD
      _tipoDropdownMenuItems = buildDropDownMenuTiposTipo(listTipo);
      _selectedTipo = listTipo.where((element) => element.tipoId == myProd.tiposProductoFk).first;

      listTipoSubEstante = await _productosServices.getTipos_SubEstantes(_selectedTipoEstante!.tipoDescripcion!);  ///para sub estantes
      _tipoSubEstanteDropdownMenuItems = buildDropDownMenuTiposSubEstante(listTipoSubEstante);
      _selectedTipoSubEstante = listTipoSubEstante.where((element) => element.tipoId == myProd.tipoSubEstanteFk).first;





      setState(() {
        print("Valor de Producto"+ ProId);
        print(myProd.toJson());
        loading = false;

      //  print(productos.length);
      });
    } catch (e) {
      print(e);
    }
  }

  //
  // void obtenerCompras() async {
  //   try {
  //     print(_idProductoController.text);
  //     print(selDate);
  //     compras = await _productosServices.getComprasxProducto(_idProductoController.text, selDate);
  //
  //     compras2 = compras;
  //     print("Helou");
  //     setState(() {
  //       comprasLista = compras;
  //       loading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }


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

        List<ProductosDetalladoModel> lista = productos.where((element) => element.prodCodigoBarrasPrincipal == qrValue).toList();
        _idProductoController.text = lista.first.prodId!;
        _nombreProductoController.text = lista.first.prodNombre!;
      //  _stockProductoController.text = lista.first.pdCantidadApertura!;
        _precioVentaProductoController.text = lista.first.prodPrecio!;

        _productController.text = qrValue;
        getValores(lista.first.prodId!);
      //  comprasLista=[];
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
        title: Text("EDITAR PRODUCTOS"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

          showMessajeAW(DialogType.WARNING,"Pregunta", "Desea Actualizar los Datos?", 1);
        },
        icon: Icon(Icons.save),
        label: Text('Actualizar'),
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
                height: 10.0,
              ),
              Column(
                children: [
                  searchProducto = fieldEntidad(),
                ] ,
              ),

              // const SizedBox(
              //   height: 12.0,
              // ),

              SizedBox(height: 10.0,),
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
              SizedBox(height: 10.0,),
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
              SizedBox(height: 10.0,),
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
                readOnly: false,
              ),


              ///AQUA NEWS CAMPOS
             SizedBox(height: 10.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "FAMILIA",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/icons/service.svg", color: Colors.black54,),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                isExpanded: true,
                value: _selectedFamilia,
                items: _familiaDropdownMenuItems,
                onChanged: onChangeDropdownTiposFamilia,
                elevation: 2,
                style: TextStyle(color: Colors.black54, fontSize: 16),
                isDense: true,
                iconSize: 40.0,
              ),
              SizedBox(height: 10.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "TIPO",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/icons/service.svg", color: Colors.black54,),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                isExpanded: true,
                value: _selectedTipo,
                items: _tipoDropdownMenuItems,
                onChanged: onChangeDropdownTiposTipo,
                elevation: 2,
                style: TextStyle(color: Colors.black54, fontSize: 16),
                isDense: true,
                iconSize: 40.0,
              ),

              SizedBox(height: 10.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "TIPO UNIDAD",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/icons/service.svg", color: Colors.black54,),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                isExpanded: true,
                value: _selectedTipoUnidad,
                items: _tipoUnidadDropdownMenuItems,
                onChanged: onChangeDropdownTiposUnidad,
                elevation: 2,
                style: TextStyle(color: Colors.black54, fontSize: 16),
                isDense: true,
                iconSize: 40.0,
              ),
              SizedBox(height: 10.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "ESTANTE",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/icons/service.svg", color: Colors.black54,),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                isExpanded: true,
                value: _selectedTipoEstante,
                items: _tipoEstanteDropdownMenuItems,
                onChanged: onChangeDropdownTiposEstante,
                elevation: 2,
                style: TextStyle(color: Colors.black54, fontSize: 16),
                isDense: true,
                iconSize: 40.0,
              ),
              SizedBox(height: 10.0,),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "SUB ESTANTE",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      "assets/icons/service.svg", color: Colors.black54,),
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                isExpanded: true,
                value: _selectedTipoSubEstante,
                items: _tipoSubEstanteDropdownMenuItems,
                onChanged: onChangeDropdownTiposSubEstante,
                elevation: 2,
                style: TextStyle(color: Colors.black54, fontSize: 16),
                isDense: true,
                iconSize: 40.0,
              ),
              SizedBox(height: 10.0,),
              ColoredBox(
                color: Colors.green,
                child: Material(
                  child: CheckboxListTile(
                    //tileColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Optionally
                      side: const BorderSide(color: Colors.lightBlueAccent),
                    ),
                    title: const Text('ESTADO'),
                    value: checkEstado,
                    onChanged:(bool? value) {
                      setState(() {
                        checkEstado = (checkEstado ==true ? false:true);
                      });

                    },
                  ),
                ),
              ),
              // CheckboxListTile(
              //   title: Text("ESTADO"), //    <-- label
              //   value: checkEstado,
              //   onChanged: (newValue) {
              //     checkEstado = true;
              //   },
              //
              // ),
          //     Checkbox(
          //
          //     checkColor: Colors.white,
          //     // fillColor: MaterialStateProperty.resolveWith(Colors.lightBlueAccent),
          //     //fillColor: Colors.lightBlueAccent,
          //     value: checkEstado,
          //     onChanged: (bool? value) {
          //       setState(() {
          //         checkEstado = value!;
          //       });
          //     },
          // ),



              SizedBox(
                height: 10.0,
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
              // CupertinoButton(
              //   child: Container(
              //     width: double.infinity,
              //     child: Text(
              //       "Obtener Compras",
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
              //   color: Colors.blue,
              //   // onPressed: precioController.text.length > 0 &&
              //   //         cantidadController.text.length > 0
              //   onPressed:() {
              //   //  obtenerCompras();
              //     mensajeToast("Cargando productos, espere....", Colors.black, Colors.white);
              //   },
              //
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // const Text(
              //   "LISTA DE COMPRAS",
              //   style: TextStyle(
              //       fontSize: 18.0,
              //       letterSpacing: 1.0,
              //       color: Colors.black54,
              //       fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 20.0,
              ),


              // SizedBox(
              //   height: 20.0,
              // ),
              // Column(
              //   children: <Widget>[
              //     SizedBox(
              //       height: 200, // fixed height
              //       child: comprasLista.length > 0
              //           ? ListView.builder(
              //           scrollDirection: Axis.vertical,
              //           padding: const EdgeInsets.all(8),
              //           itemCount: comprasLista.length,
              //           itemBuilder: (BuildContext context,
              //               int index) {
              //             return ListTile(
              //               // leading: Icon(
              //               //   Icons.arrow_forward_ios,
              //               //   size: 15.0,
              //               // ),
              //               title: Text(
              //                 // comprasLista[index]
              //                 //     .productoFkDesc!
              //                 //     .toUpperCase(),
              //                 comprasLista[index]
              //                     .proveedor!
              //                     .toUpperCase(),
              //                 style: TextStyle(
              //                     fontSize: 17.0,
              //                     color: Colors.black54),
              //               ),
              //               subtitle: Row(
              //                 mainAxisAlignment:
              //                 MainAxisAlignment
              //                     .spaceBetween,
              //                 children: [
              //
              //                   Text(
              //                     // "S/. : ${comprasLista[index].precioFinal!} ",
              //                     "${comprasLista[index].fecha!} ",
              //                     style: TextStyle(
              //                         fontSize: 16.0,
              //                         fontWeight:
              //                         FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                   Text(
              //                     // "S/. : ${comprasLista[index].precioFinal!} ",
              //                     "S/. ${comprasLista[index].precioUnitario!} ",
              //                     style: TextStyle(
              //                         fontSize: 16.0,
              //                         fontWeight:
              //                         FontWeight.bold,
              //                         color: Colors.black),
              //                   ),
              //                 ],
              //               ),
              //
              //               onTap: () {
              //                 // abrirScan(scans[i], context);
              //               },
              //             );
              //           })
              //           : Center(
              //         child: Text(
              //           "No hay productos en la lista.",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 18.0,
              //               color: Colors.black26),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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

  //
  // showMensajeriaAW(DialogType tipo, String titulo, String desc, String Accion) {
  //   AwesomeDialog(
  //     dismissOnTouchOutside: false,
  //     context: context,
  //     dialogType: tipo,
  //     headerAnimationLoop: false,
  //     animType: AnimType.TOPSLIDE,
  //     showCloseIcon: true,
  //     closeIcon: const Icon(Icons.close_fullscreen_outlined),
  //     title: titulo,
  //     descTextStyle: TextStyle(fontSize: 18),
  //     desc: desc,
  //     //  btnCancelOnPress: () {},
  //     onDissmissCallback: (type) {
  //       debugPrint('Dialog Dissmiss from callback $type');
  //     },
  //     btnOkOnPress: () {
  //       if (Accion == "1") {
  //         // Navigator.pop(context);
  //         Navigator.pushReplacementNamed(
  //             context, 'home');
  //       }
  //
  //     },
  //   ).show().then((value) {
  //     //    getData();
  //     setState(() {});
  //   });
  // }


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
      btnCancelOnPress: () {},
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
              _sendData();
              //Cuando se genera el pedido

            }
            break;
          case 2:
            {
              Navigator.pushReplacementNamed(
                context,
                'home',
              );
            }
            break;
        }
      },
    ).show();
  }






  AutoCompleteTextField<ProductosDetalladoModel> fieldEntidad() {
    return AutoCompleteTextField<ProductosDetalladoModel>(
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
        return item.prodNombre.toString().toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.prodNombre.toString().compareTo(b.prodNombre.toString());
      },
      itemSubmitted: (item) {
        setState(() {
         // print(item.prodCodigoBarrasPrincipal);
          searchProducto!.textField!.controller!.text = item.prodCodigoBarrasPrincipal!;
          _idProductoController.text = item.prodId!;
          _nombreProductoController.text = item.prodNombre!;
        //  _stockProductoController.text = item.pdCantidadApertura!;
          _precioVentaProductoController.text = item.prodPrecio!;

          getValores(item.prodId!);
        //  comprasLista=[];
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
  Widget rowEntidad(ProductosDetalladoModel empleado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              empleado.prodNombre! +" - " +  empleado.prodCodigoBarrasPrincipal!,
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














}
