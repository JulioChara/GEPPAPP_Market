import 'package:flutter/material.dart';
import 'package:market_app/src/pages/PlanInventarios/plan_inventarios_crear_page.dart';
import 'package:market_app/src/pages/PlanInventarios/plan_inventarios_page.dart';
import 'package:market_app/src/pages/PlanInventarios/scan_productos_page.dart';
import 'package:market_app/src/pages/Productos/productos_detalles_page.dart';
import 'package:market_app/src/pages/Productos/productos_editar_page.dart';
import 'package:market_app/src/pages/home_page.dart';
import 'package:market_app/src/pages/login_page.dart';
import 'package:market_app/utils/sp_global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal prefs = SPGlobal();
  await prefs.initShared();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Market Marios',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PreInit(),
        //home: HomePage(),
        // home: DispositivoGeneralPage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          // English
          const Locale('es'),
          // Hebrew
          const Locale.fromSubtags(languageCode: 'zh'),
          // Chinese *See Advanced Locales below*
          // ... other locales the app supports
        ],
        routes: {
          'home': (BuildContext context) => HomePage(),
          'login': (BuildContext context) => LoginPage(),
          'scanQR': (BuildContext context) => ScanProductosPage(),
          'planInventarios': (BuildContext context) => PlanInventariosPage(),
          'planInventariosCrear': (BuildContext context) => PlanInventariosCrearPage(),
          'productosDetalle': (BuildContext context) => ProductosDetallesPage(),
          'productosEditar': (BuildContext context) => ProductosEditarPage(),





          // 'factura': (BuildContext context) => FacturaNotasPage(),
          // 'nota_entrada': (BuildContext context) => NotaEntradaPage(),
        },
      ),
      onTap: () {
        final FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
    );
  }
}

class PreInit extends StatelessWidget {
  SPGlobal _prefs = SPGlobal();
  @override
  Widget build(BuildContext context) {
    // return _prefs.isLogin ? ((_prefs.rolId == "1"|| _prefs.rolId == "13" )? HomePage(): OfflinePedidosEntregasPage()) : LoginPage();
    return _prefs.isLogin ? HomePage() : LoginPage();
    // return HomePage();
  }
}