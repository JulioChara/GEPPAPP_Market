


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market_app/src/models/PlanInventario/plan_inventarios_model.dart';
import 'package:market_app/src/services/PlanInventarios/plan_inventarios_services.dart';
import 'package:market_app/utils/sp_global.dart';

class PlanInventarioActualizarCantidadWidget extends StatefulWidget {

  String? idPd = "";
  String? idPiFk = "";
  PlanInventarioActualizarCantidadWidget({this.idPd, this.idPiFk});

  @override
  State<PlanInventarioActualizarCantidadWidget> createState() => _PlanInventarioActualizarCantidadWidgetState();
}

class _PlanInventarioActualizarCantidadWidgetState extends State<PlanInventarioActualizarCantidadWidget> {



  SPGlobal _prefs = SPGlobal();


  final formKey = GlobalKey<FormState>();
  var loading = true;
  var defTipo = "";
  // var objTipos = new PlanInventariosServices(); //

  PlanInventarioDetalleModel _model = new PlanInventarioDetalleModel();

  TextEditingController cantidadCierreEditingController = new TextEditingController();


  // AlertasMantenimientosModel _updateAlertaManModel =
  // AlertasMantenimientosModel();
  PlanInventariosServices _planInventariosServices = PlanInventariosServices();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String id = await prefs.getString("idUser");

    loading = false;
    setState(() {});
  }



  void registrar() {
    if (formKey.currentState!.validate()) {
      _model.id = widget.idPd;
      _model.planInventarioFk = widget.idPiFk;
      _model.pdCantidadCierre = cantidadCierreEditingController.text;
      _model.usuarioModificacion = _prefs.idUser;

      _planInventariosServices.actualizarCantidadCierre(_model)
          .then((value) {
        print("Salvadito ?");
        print(value);
        if (value != null) {
          if (value == "1") {
            print("Actualizado Save");
            // Navigator.pop(context);
            showMensajeriaAW(DialogType.SUCCES, "Confirmacion", "Actualizado correctamente", "1");
          }
        }
      });
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
          //  Navigator.pushNamed(context, 'notasEntradaCrear');
          Navigator.pop(context);
        }

      },
    ).show().then((value) {
      //  getData();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return !loading
        ?  AlertDialog(
      content: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("CANTIDAD CIERRE",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 15.0,),

                TextFormField(
                  controller: cantidadCierreEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    hintText: "Cantidad Cierre",
                    labelText: "Cantidad Cierre",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/icons/tick.svg",
                        color: Colors.green,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String text) {},

                  //initialValue: "0",
                  onChanged: (value) {
                    //  kmMantenimientoEditingController.text = (int.parse(kmInicialEditingController.text) + int.parse(kmRecorrerEditingController.text)).toString();
                  },
                )

              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            registrar();
          },
          child: Text(
            "Grabar",
          ),
        ),
      ],
    ): Center(child: CircularProgressIndicator());
  }

}
