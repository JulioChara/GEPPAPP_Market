





import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:market_app/src/services/login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isFetching = false;
  String _email = "", _password = "";

  LoginServices loginServices = new LoginServices();

  _submit() async {

    setState(() {
      _isFetching = true;
    });

    String rpta = await loginServices.login(_email, _password);



    print("Resultado xd: "+rpta);
    if (rpta == "0") {
      setState(() {
        _isFetching = false;
      });

      AwesomeDialog(
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.ERROR,
        headerAnimationLoop: false,
        animType: AnimType.SCALE,
        showCloseIcon: true,
        closeIcon: const Icon(Icons.close_rounded,color: Colors.black),
        title: 'ERROR',
        descTextStyle: TextStyle(fontSize: 18),
        desc: 'Hubo un problema, verifique sus datos e inténtelo nuevamente.',
        //  btnCancelOnPress: () {},
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
        btnOkOnPress: () {},
      ).show();
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String rol = await prefs.getString("rolId")!;
      setState(() {
        _isFetching = false;
      });

      if (rol =="1" || rol== "5" || rol=="12"){
        Navigator.pushReplacementNamed(context, 'home', arguments: _email);
      }else
      {
        Navigator.pushReplacementNamed(context, 'home', arguments: _email);
        // Navigator.pushReplacementNamed(context, 'pedidosOffline', arguments: _email);
      }



    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
          if (_isFetching)
            Positioned(
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

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
      // height: size.height,
      // width: size.width,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(
      //         'assets/login_wallpaper.jpg'),
      //     fit: BoxFit.fill,
      //   ),
      //  // shape: BoxShape.circle,
      // ),
      //Positioned(
        // left: -200,
        // top: -200,
        // left: 0,
        // top: 0,
        height: size.height,
        width: size.width,
        child: Opacity(
          opacity: 0.9,
          child: LottieBuilder.asset(
            "assets/animation/animation_wallpaper_abstract.json",
            //   reverse: true,
            // options: LottieOptions(enableApplyingOpacityToLayers: true),
            fit: BoxFit.fill,
          ),
        ),
      );


  // );

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
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 120.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200.0,
                padding: EdgeInsets.only(top: 70.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset("assets/logo.png"),
                ))
          ],
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "INGRESO",
                  style: TextStyle(fontSize: 30.0, letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(),
                SizedBox(height: 20),
                _crearPassword(),
                SizedBox(height: 50),
                _crearBoton(),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Made with ",
                ),
                WidgetSpan(
                  child: Icon(Icons.favorite, size: 14, color: Colors.greenAccent,),
                ),
                TextSpan(
                  text: " by Aquarium",
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepOrange),
          hintText: "Usuario",
          labelText: "Usuario",
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepOrange,),
          labelText: "Contraseña",
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingresar"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        color: Colors.black,
        textColor: Colors.white,
        onPressed: () {
          _submit();
        });
  }

}
