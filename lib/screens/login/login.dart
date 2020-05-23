import 'package:flutter/cupertino.dart';
import 'package:quarantini/screens/home/home.dart';
import 'package:flutter/material.dart';

import 'components/AnimatedLogo.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => LoginScreen(),
    );
  }
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

    AnimationController controller;
    Animation<double> animation;

    GlobalKey<FormState> _key = GlobalKey();
    RegExp emailRegExp =
    new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
    RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
    String _correo;
    String _password;
    String mensaje = '';

    bool _logueado = false;

    initState() {
      super.initState();
      controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
      );
      animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
      controller.forward();
    }

    dispose() {
      // Es importante SIEMPRE realizar el dispose del controller.
      controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        //body: _logueado ? MyHomePage(mensaje: mensaje) : loginForm(),
        body: _logueado ? MyHomePage() : loginForm(),
        //body: MyHomePage(),
      );
    }

    Widget loginForm(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedLogo(animation: animation)
            ],
          ),
          Container(
            width: 300.0, //size.width * .6,
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  TextFormField(
                     validator: (text){
                       if (text.length == 0){
                         return "Email required";
                       }else if (!emailRegExp.hasMatch(text)){
                          return "Bad email format";
                       }
                       return null;
                     },
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'corona@virus.com',
                      labelText: 'Email',
                      counterText: '',
                      icon: Icon(Icons.email, size: 32.0, color: Colors.teal[200]),
                    ),
                    onSaved: (text) => _correo = text,
                  ),
                  TextFormField(
                    validator: (text){
                      if (text.length == 0){
                        return "Password required";
                      } else if (text.length <= 5) {
                        return "Password must have more than 5 characters";
                      }
                      else if (!contRegExp.hasMatch(text)){
                        return "Bad Password format";
                      }
                      return null;
                    },
                    obscureText: tru,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'covid_19',
                      labelText: 'Password',
                      counterText: '',
                      icon: Icon(Icons.lock, size: 32.0, color: Colors.teal[200]),
                    ),
                    onSaved: (text) => _password = text,
                  ),
                  IconButton(
                    onPressed: (){
                      if (_key.currentState.validate()){
                        _key.currentState.save();
                        //Aqui se llamaria a la API para hacer el login
                        setState(() {
                          _logueado = true;
                        });
                        mensaje = 'Play Quarantini \n $_correo \n $_password';
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 42.0,
                      color: Colors.black,
                    ),
                    splashColor: Colors.teal[200],

                  )
                ],
              ),

            ),
          ),
        ],
      );
    }
    }