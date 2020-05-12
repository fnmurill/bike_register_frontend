import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../widgets/circle.dart';
import '../widgets/input_text.dart';
import '../api/auth_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();
  var _email = '', _password = '';
  var _isFetching = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    if (_isFetching) return;
    setState(() {
      _isFetching = true;
    });

    final isValid = _formKey.currentState.validate();
    if (isValid) {
      final isOk =
          await _authAPI.login(context, email: _email, password: _password);

      setState(() {
        _isFetching = false;
      });
      if (isOk) {
        print("LOGIN OK");
        Navigator.pushNamed(context, "home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  right: -size.width * 0.22,
                  top: -size.width * 0.36,
                  child: Circle(
                    radius: size.width * 0.45,
                    colors: [Colors.blue, Colors.blueGrey],
                  )),
              Positioned(
                  left: -size.width * 0.15,
                  top: -size.width * 0.34,
                  child: Circle(
                    radius: size.width * 0.35,
                    colors: [Colors.grey, Colors.blueGrey],
                  )),
              SingleChildScrollView(
                  child: Container(
                width: size.width,
                height: size.height,
                child: SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 90,
                          height: 90,
                          margin: EdgeInsets.only(top: size.width * 0.3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 25)
                              ]),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Bienvenido de vuelta",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 300,
                            minWidth: 300,
                          ),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  InputText(
                                      label: "Correo Electronico",
                                      inputType: TextInputType.emailAddress,
                                      validator: (String text) {
                                        if (text.contains("@")) {
                                          _email = text;
                                          return null;
                                        } else {
                                          return "Correo Invalido";
                                        }
                                      }),
                                  SizedBox(height: 30),
                                  InputText(
                                      label: "Contraseña",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isNotEmpty &&
                                            text.length > 5) {
                                          _password = text;
                                          return null;
                                        } else {
                                          return "Contraseña Invalida";
                                        }
                                      }),
                                ],
                              )),
                        ),
                        SizedBox(height: 60),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 300,
                            minWidth: 300,
                          ),
                          child: CupertinoButton(
                              padding: EdgeInsets.symmetric(vertical: 17),
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(4),
                              onPressed: () => _submit(),
                              child: Text("Iniciar Sesión",
                                  style: TextStyle(fontSize: 20))),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Ya estas Registrado?",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54)),
                            CupertinoButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, "signup"),
                              child: Text("Registrate aquí",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueAccent)),
                            )
                          ],
                        ),
                        SizedBox(height: size.height * 0.1)
                      ],
                    )
                  ],
                )),
              )),
              //Start Fetching Dialog
              _isFetching
                  ? Positioned.fill(
                      child: Container(
                      color: Colors.black45,
                      child: Center(
                        child: CupertinoActivityIndicator(radius: 15),
                      ),
                    ))
                  : Container()
              //End Fetching Dialog
            ],
          ),
        ),
      ),
    );
  }
}
