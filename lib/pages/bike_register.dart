import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend/api/auth_api.dart';
import 'package:frontend/widgets/bike_register/register_bike.dart';
import 'package:frontend/widgets/circle.dart';
import 'package:frontend/widgets/input_text.dart';
import 'package:frontend/utils/responsive.dart';

class BikeRegisterPage extends StatefulWidget {
  @override
  _BikeRegisterPageState createState() => _BikeRegisterPageState();
}

class _BikeRegisterPageState extends State<BikeRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();

  var _manufacturer = 'manufacturer', _serialNumber = 'serialNumber', _color = 'color', _typeBicycle = 'typeBicycle';

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
      final isOk = await _authAPI.bike(context,
          manufacturer: _manufacturer,
          serialNumber: _serialNumber,
          color: _color,
          typeBicycle: _typeBicycle);
      setState(() {
        _isFetching = false;
      });
      if (isOk) {
        print("REGISTER");
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
//        child: Container(
//          width: size.width,
//          height: size.height,
//          child: Stack(
//            children: <Widget>[
//              Positioned(
//                  right: -size.width * 0.22,
//                  top: -size.width * 0.36,
//                  child: Circle(
//                    radius: size.width * 0.45,
//                    colors: [Colors.lightBlue, Colors.blueGrey],
//                  )),
//              Positioned(
//                  left: -size.width * 0.15,
//                  top: -size.width * 0.34,
//                  child: Circle(
//                    radius: size.width * 0.35,
//                    colors: [Colors.blue, Colors.blueGrey],
//                  )),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                RegisterBike(),
                SingleChildScrollView(
                  child: Container(
                    height: responsive.inc(50),
                    child: Column(
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
                                      label: "Fabricante",
                                      fontSize: responsive.inc(1.8),
                                      validator: (String text) {
                                        if (RegExp(r'^[a-zA-Z0-9]+$')
                                            .hasMatch(text)) {
                                          _manufacturer = text;
                                          return null;
                                        }
                                        return "Fabricante Inválido";
                                      }),

                                  SizedBox(height: responsive.inc(0.5)),
                                  InputText(
                                      label: "No. Serial",
                                      fontSize: responsive.inc(1.8),
                                      validator: (String text) {
                                        if (RegExp(r'^[a-zA-Z0-9]+$')
                                            .hasMatch(text)) {
                                          _serialNumber = text;
                                          return null;
                                        }
                                        return "Serial Invalido";
                                      }),
                                  SizedBox(height: responsive.inc(0.5)),
                                  InputText(
                                      label: "Color",
                                      fontSize: responsive.inc(1.8),
                                      validator: (String text) {
                                        if (RegExp(r'^[a-zA-Z0-9]+$')
                                            .hasMatch(text)) {
                                          _color = text;
                                          return null;
                                        }
                                        return "Color Inválido";
                                      }),
                                  SizedBox(height: responsive.inc(0.5)),
                                  InputText(
                                      label: "Tipo de Bicicleta",
                                      fontSize: responsive.inc(1.8),
                                      validator: (String text) {
                                        if (RegExp(r'^[a-zA-Z0-9]+$')
                                            .hasMatch(text)) {
                                          _typeBicycle = text;
                                          return null;
                                        }
                                        return "Tipo de Bicicleta Inválido";
                                      }),
                                  SizedBox(height: responsive.inc(2)),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: responsive.inc(1.5)),
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(4),
                              onPressed: () => _submit(),
                              child: Text("Enviar",
                                  style: TextStyle(
                                      fontSize: responsive.inc(2.5)))),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),

          ),
      ),
    );
  }
}
