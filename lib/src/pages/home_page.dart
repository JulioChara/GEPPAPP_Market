



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:market_app/src/widgets/menu_widget.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SPGlobal _prefs = SPGlobal();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // static List<PlanInventarioDetalleModel> productos = [];
  // PlanInventariosServices _planInventariosServices = PlanInventariosServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

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

  showMensajeriaBasic(
      DialogType tipo,
      String titulo,
      String desc,
      )
  {
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
      //   btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {},
    ).show().then((val) {
      //getData();
      setState(() {});
    });
  }

  get dashBg => Column(
    children: <Widget>[
      _crearFondo(context)
      // Expanded(
      //   child: Container(color: Colors.deepPurple),
      //   flex: 2,
      // ),
      // Expanded(
      //   child: Container(color: Colors.transparent),
      //   flex: 5,
      // ),
    ],
  );

  get content => Container(
    child: Column(
      children: <Widget>[
        header,
        grid,
      // Lottie.network("https://lottie.host/9a3b90b1-f7a5-4813-837b-161fd0d93b59/65yqeUadp7.json")
      // Lottie.network("https://lottie.host/bfe64324-e7dd-4acb-a918-28dfbf18f7bd/G2R4pHuA3H.json", height: 250)
      //Lottie.asset("assets/animation/animation_halloween_cat.json", height: 250)
        // Lottie.asset(
        //   'assets/animation/animation_halloween.json',
        //   height: 100,
        //   reverse: true,
        //   repeat: true,
        //   fit: BoxFit.cover
        // ),
        //fechas,
      ],
    ),
  );

  get header => ListTile(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),



    title: Text(
      'MENUS',
      style: TextStyle(color: Colors.white, fontSize: 25),
    ),
    subtitle: Text(
      'Accesos Rapidos',
      style: TextStyle(color: Colors.orangeAccent, fontSize: 20, fontWeight: FontWeight.bold),
    ),
      // Column(
      //   children: [
      //     Lottie.network(
      //         "https://lottie.host/9a3b90b1-f7a5-4813-837b-161fd0d93b59/65yqeUadp7.json",
      //         height: 100,
      //         reverse: true,
      //         repeat: true,
      //         fit: BoxFit.cover),
      //   ],
      // ),

       // Lottie.asset(
       //   'assets/LottieLogo1.json',
       //   height: 100,
       //   reverse: true,
       //   repeat: true,
       //   fit: BoxFit.cover
       // ),

    trailing: CircleAvatar(
    //  Lottie.asset('assets/LottieLogo1.json'),
      backgroundImage: NetworkImage(
          "https://www.anmosugoi.com/wp-content/uploads/2022/04/date-a-live-iv-portada-1.jpg"),
     ),
  );

  get grid => Expanded(
    child: Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: GridView.count(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: .90,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'planInventarios');

              },
              child: Card(
                elevation: 2,
                color: Colors.transparent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: const <Widget>[
                      Icon(Icons.inventory_outlined,
                          color: Colors.green, size: 80),
                      Text('PLAN DE INVENTARIO',style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.pushReplacementNamed(
            //         context, 'scanQR');
            //
            //
            //   },
            //   child: Card(
            //     elevation: 2,
            //     color: Colors.transparent.withOpacity(0.5),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8)),
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         //children: <Widget>[FlutterLogo(), Text('SUBIR')],
            //         children: const <Widget>[
            //           Icon(Icons.qr_code_scanner,
            //               color: Colors.blueAccent, size: 80),
            //           Text('BUSCAR PRODUCTOS',style: TextStyle(color: Colors.white))
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'productosDetalle');


              },
              child: Card(
                elevation: 2,
                color: Colors.transparent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                //color: Colors.black12,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: const <Widget>[
                      Icon(Icons.production_quantity_limits ,
                          color: Colors.amber, size: 80),
                      Text('INF. PRODUCTO',style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),


            if (_prefs.rolId == "1") InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'productosEditar');
              },
              child: Card(
                elevation: 2,
                color: Colors.transparent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                //color: Colors.black12,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //children: <Widget>[FlutterLogo(), Text('SUBIR')],
                    children: const <Widget>[
                      Icon(Icons.edit ,
                          color: Colors.red, size: 80),
                      Text('EDITAR PRODUCTO',style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ) else (
            Text("")
            ),

          ]


      ),
    ),
  );







  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final primerFondo = Container(
    //   height: size.height * 0.4,
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(colors: <Color>[
    //         Color(0xFFF7F7F7),
    //         Color(0xFFF7F7F7),
    //       ])),
    // );

    final primerFondo = Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/menu_wallpaper.png'),
          fit: BoxFit.fill,
        ),
        // shape: BoxShape.circle,
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          // color: Color.fromRGBO(255, 255, 255, 0.1)),
          color: Color.fromRGBO(150, 255, 255, 0.2)),
    );

    return Stack(
      children: <Widget>[
        primerFondo,
        Positioned(
          // left: -200,
          // top: -200,
          left: 0,
          top: 0,
          height: size.height,
          width: size.width,
          child: Opacity(
            opacity: 0.9,
            child: LottieBuilder.asset(
              // "assets/animation/animation_wallpaper_cristmas.json",
              "assets/animation/animation_wallpaper_abstract.json",
              //   reverse: true,
              // options: LottieOptions(enableApplyingOpacityToLayers: true),
              fit: BoxFit.fill,
            ),
          ),
        ),
        //
        // Positioned(
        //   top: 90.0,
        //   left: 30.0,
        //   child: circulo,
        // ),
        // Positioned(
        //   top: -40.0,
        //   right: -30.0,
        //   child: circulo,
        // ),
        // Positioned(
        //   bottom: -50.0,
        //   right: -10.0,
        //   child: circulo,
        // ),
        // Positioned(
        //   bottom: 120.0,
        //   right: 20.0,
        //   child: circulo,
        // ),
        // Positioned(
        //   bottom: -50.0,
        //   left: -20.0,
        //   child: circulo,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Container(
        //         height: 200.0,
        //         padding: EdgeInsets.only(top: 70.0),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(8.0),
        //           child: Image.asset("assets/logo.png"),
        //         ))
        //   ],
        // )
      ],
    );
  }









}

