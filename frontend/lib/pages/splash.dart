import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/session.dart';



class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _session = Session();

  @override
  void initState() {
    super.initState();
    this.check();
  }

  check() async {
    final data = await _session.get();
    if(data != null){
      Navigator.pushReplacementNamed(context, "home");
    }else{
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 20,),
      ),
    );
  }
}
