import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/widgets/login_page/widgets_login.dart';
import '../widgets/input_text.dart';
import '../api/auth_api.dart';
import '../utils/responsive.dart';

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

    final isValid = _formKey.currentState.validate();

    if (isValid) {
      setState(() {
        _isFetching = true;
      });
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
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              LoginWidgets(),
              SingleChildScrollView(
                  child: Container(
                    height: responsive.inc(29),
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
                                          label: "Correo Electronico",
                                          inputType: TextInputType.emailAddress,
                                          fontSize: responsive.inc(1.8),
                                          validator: (String text) {
                                            if (text.contains("@")) {
                                              _email = text;
                                              return null;
                                            }
                                            return "Correo Invalido";
                                          }),
                                      SizedBox(height: responsive.hg(2)),
                                      InputText(
                                          label: "Contraseña",
                                          isSecure: true,
                                          fontSize: responsive.inc(1.8),
                                          validator: (String text) {
                                            if (text.isNotEmpty &&
                                                text.length > 5) {
                                              _password = text;
                                              return null;
                                            }
                                            return "Contraseña Invalida";
                                          }),
                                    ],
                                  )),
                            ),
                            SizedBox(height: responsive.hg(3.5)),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 300,
                                minWidth: 300,
                              ),
                              child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: responsive.inc(1.3)),
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(4),
                                  onPressed: () => _submit(),
                                  child: Text("Iniciar Sesión",
                                      style: TextStyle(
                                          fontSize: responsive.inc(2.5)))),
                            ),
                            SizedBox(height: responsive.hg(1)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Ya estas Registrado?",
                                    style: TextStyle(
                                        fontSize: responsive.inc(1.8),
                                        color: Colors.black54)),
                                CupertinoButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, "signup"),
                                  child: Text("Registrate aquí",
                                      style: TextStyle(
                                          fontSize: responsive.inc(1.8),
                                          color: Colors.blueAccent)),
                                )
                              ],
                            ),
                           ],
                        )
                      ],
                    ),
              )),
//              //Start Fetching Dialog
              _isFetching
                  ? Positioned.fill(
                      child: Container(
                      color: Colors.black45,
                      child: Center(
                        child: CupertinoActivityIndicator(radius: 15),
                      ),
                    ))
                  : Container()
//              //End Fetching Dialog
            ],
          ),
        ),
      ),
    );
  }
}
