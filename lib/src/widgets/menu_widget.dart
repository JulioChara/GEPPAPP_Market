


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:shared_preferences/shared_preferences.dart';





class MenuWidget extends StatefulWidget {
  String rolcito = "";
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  SPGlobal _prefs = SPGlobal();



  String nameUser = "";
  _cerrarSesion(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdRol();
    _valorInicial();
  }

  _valorInicial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameUser = await prefs.getString("nameUser")!;
    print(nameUser);
  }

  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.rolcito = prefs.getString('rolId')!;
    print(prefs.getString('rolId'));
    return prefs.getString("rolId")!;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: NetworkImage(
                      //   "https://www.anmosugoi.com/wp-content/uploads/2022/04/date-a-live-iv-portada-1.jpg"),
                      //"https://c4.wallpaperflare.com/wallpaper/200/112/950/material-design-design-wallpaper-preview.jpg"),
                        "https://i0.wp.com/gepp.pe/wp-content/uploads/2020/03/DSC_5652-scaled.jpg?fit=2560%2C1880&ssl=1"),
                    fit: BoxFit.cover)),
          ),

          ListTile(
            leading: Icon(
              Icons.person_pin,
              size: 50,
              color: Colors.green,
            ),

            title: Text(_prefs.usNombre,overflow: TextOverflow.ellipsis),
            subtitle: Text(_prefs.rolName, style: TextStyle(color: Colors.black)),
          ),

          ExpansionTile(
            title: Text("LOGISTICA"),
            initiallyExpanded: true,
            children: [
              // (_prefs.rolId != "1" && _prefs.rolId != "5" && _prefs.rolId != "12") ? Text("") : ListTile(
              (_prefs.rolId != "1" ) ? Text("") : ListTile(
                leading: Icon(
                  Icons.devices_other,
                  color: Colors.blueAccent,
                ),
                title: Text("Plan de Inventario"),
                onTap: () => Navigator.pushReplacementNamed(context, 'planInventarios'),
                // onTap: () {
                //   Navigator.pushReplacementNamed(context, 'planInventarios')
                //
                // },
              ),
              // (_prefs.rolId != "1" ) ? Text("") : ListTile(
              //   leading: Icon(
              //     Icons.qr_code_scanner,
              //     color: Colors.blueAccent,
              //   ),
              //   title: Text("Actualizar Cantidades"),
              //   onTap: () => Navigator.pushReplacementNamed(context, 'scanQR'),
              //   // onTap: () {
              //   //   Navigator.pushReplacementNamed(context, 'planInventarios')
              //   //
              //   // },
              // ),
              ListTile(
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: Colors.blueAccent,
                ),
                title: Text("Consulta Compras x Producto"),
                onTap: () => Navigator.pushReplacementNamed(context, 'productosDetalle'),
                // onTap: () {
                //   Navigator.pushReplacementNamed(context, 'planInventarios')
                //
                // },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("GENERAL"),
            initiallyExpanded: true,
            children: [
            ],
          ),


          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.purple,
            ),
            title: Text("HOME"),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),



          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
            title: Text("Cerrar Sesión"),
            onTap: () {
              //Navigator.pushReplacementNamed(context, SettingsPage.routeName);

              AwesomeDialog(
                dismissOnTouchOutside: false,
                context: context,
                dialogType: DialogType.WARNING,
                headerAnimationLoop: false,
                animType: AnimType.TOPSLIDE,
                showCloseIcon: true,
                closeIcon: const Icon(Icons.close_fullscreen_outlined),
                title: "Cerrar Sesion?",
                descTextStyle: TextStyle(fontSize: 18),
                desc: "Esta seguro de cerrar sesion?, tendra que volver a ingresar sus credenciales",
                btnCancelOnPress: () {},
                onDissmissCallback: (type) {
                  debugPrint('Dialog Dissmiss from callback $type');
                },
                btnCancelText: "No",
                btnOkText: "Si",
                btnCancelIcon: Icons.cancel,
                btnOkIcon: Icons.check,
                btnOkOnPress: () {
                  _cerrarSesion(context);
                },
              ).show().then((val) {
                setState(() {});
              });


              // _cerrarSesion(context);
            },
          ),

        ],

      ),




    );
  }







}
