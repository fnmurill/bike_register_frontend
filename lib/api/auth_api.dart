import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
import "package:flutter/services.dart";
import 'package:frontend/app_config.dart';
import 'package:frontend/utils/dialogs.dart';
import 'package:frontend/utils/session.dart';

class AuthAPI {
   //final _session = Session();

  Future<bool> register(BuildContext context,
      {@required String name,
      @required String email,
      @required String password}) async {
    try {
      final url = "${AppConfig.apiHost}/register";

      final response = await http.post(url,
          body: {"name": name, "email": email, "password": password});

      final parsed = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("response 200: ${response.body}");

        return true;
      } else if (response.statusCode == 400) {
        throw PlatformException(code: "400", message: parsed['message']);
      }
      throw PlatformException(code: "201", message: "Error /register");
    } on PlatformException catch (err) {
      print("Error ${err.code}:${" Email duplicado"}");
      Dialogs.alert(context,
          title: "ERROR",
          message: "Ya existe un usuario registrado con este email");
      return false;
    }
  }

  Future<bool> login(BuildContext context,
      {@required String email, @required String password}) async {
    try {
      final url = "${AppConfig.apiHost}/login";

      final response =
          await http.post(url, body: {"email": email, "password": password});

      final parsed = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = parsed['token'] as String;
        final expiresIn = parsed['expiresIn'] as int;
        print("response 200: ${response.body}");
//        save toke
        //  await _session.set(token, expiresIn);

        return true;
      } else if (response.statusCode == 500) {
        throw PlatformException(code: "500", message: " Internal Server Error");
      } else if (response.statusCode == 400) {
        throw PlatformException(
            code: "400", message: " Correo o contraseña incorrectos");
      }
      throw PlatformException(code: "201", message: "Error /login");
    } on PlatformException catch (e) {
      print("Error ${e.code}:${e.message}");
      Dialogs.alert(context, title: "ERROR", message: e.message);
      return false;
    }
  }

  Future<bool> bike(BuildContext context,
      {@required String manufacturer,
      @required String serialNumber,
      @required String color,
      @required String typeBicycle}) async {
    try {
      final url = "${AppConfig.apiHost}/newbicycle";

      final response = await http.post(url,
          body: {
            "manufacturer": manufacturer,
            "serialNumber": serialNumber,
            "color": color,
            "typeBicycle": typeBicycle
          });

      final parsed = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("response 200: ${response.body}");

        return true;
      } else if (response.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      } else if (response.statusCode == 400) {
        throw PlatformException(code: "400", message: parsed['message']);
      }
      throw PlatformException(code: "201", message: "Error /register");
    } on PlatformException catch (err) {
      print("Error ${err.code}:${" Serial duplicado"}");
      Dialogs.alert(context,
          title: "ERROR",
          message: "Ya existe una bicicleta registrada con este Serial");
      return false;
    }
  }
}
