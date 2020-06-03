import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/api/auth_api.dart';
import 'package:frontend/widgets/circle.dart';
import 'package:frontend/widgets/input_text.dart';
import 'package:frontend/widgets/register_page/register_widgets.dart';
import '../utils/responsive.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();

  var _name = 'name', _email = 'email', _password = 'password';
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
      final isOk = await _authAPI.register(context,
          name: _name, email: _email, password: _password);
      setState(() {
        _isFetching = false;
      });
      if (isOk) {
        print("REGISTER");
        Navigator.pushNamed(context, "login");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: double.infinity,
          height:  double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RegisterWidgets(),
              SingleChildScrollView(
                  child: Container(
                    height: responsive.inc(48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                                          label: "Nombre de Usuario",
                                          fontSize: responsive.inc(1.8),
                                          validator: (String text) {
                                            if (RegExp(r'^[a-zA-Z0-9- -á]+$')
                                                .hasMatch(text)) {
                                              _name = text;
                                              return null;
                                            }
                                            return "Nombre de Usuario Invalido";
                                          }),
                                      SizedBox(height: responsive.inc(1)),
                                      InputText(
                                          label: "Correo Electronico",
                                          fontSize: responsive.inc(1.8),
                                          inputType: TextInputType.emailAddress,
                                          validator: (String text) {
                                            if (text.contains("@")) {
                                              _email = text;
                                              return null;
                                            }
                                            return "Correo Invalido";
                                          }),
                                      SizedBox(height: responsive.inc(1)),
                                      InputText(
                                          label: "Contraseña",
                                          fontSize: responsive.inc(1.8),
                                          isSecure: true,
                                          validator: (String text) {
                                            if (text.isNotEmpty &&
                                                text.length > 5) {
                                              _password = text;
                                              return null;
                                            }
                                            return "Contraseña Invalida";
                                          }),
                                      SizedBox(height: responsive.inc(1)),
                                    ],
                                  )),
                            ),
                            SizedBox(height: responsive.inc(1)),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 300,
                                minWidth: 300,
                              ),
                              child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(vertical: responsive.inc(1.3)),
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(4),
                                  onPressed: () => _submit(),
                                  child: Text("Enviar",
                                      style: TextStyle(fontSize: responsive.inc(2.5)))),
                            ),
                            SizedBox(height: responsive.inc(1)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Ya tienes una Cuenta?",
                                    style: TextStyle(
                                        fontSize: responsive.inc(1.8), color: Colors.black54)),
                                CupertinoButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Ingresa aquí",
                                      style: TextStyle(
                                          fontSize: responsive.inc(1.8), color: Colors.blueAccent)),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
