import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/responsive.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                            height: responsive.hg(35.0),
                            width: responsive.wd(100.0),
                            child: Carousel(
                              boxFit: BoxFit.cover,
                              autoplay: true,
                              autoplayDuration: Duration(milliseconds: 3000),
                              borderRadius: true,
                              animationCurve: Curves.fastOutSlowIn,
                              animationDuration: Duration(milliseconds: 1000),
                              showIndicator: true,
                              dotSize: 4.0,
                              images: [
                                AssetImage('assets/pages/home/image1.jpg'),
                                AssetImage('assets/pages/home/image2.jpg'),
                                AssetImage('assets/pages/home/image3.jpg'),
                                AssetImage('assets/pages/home/image4.jpg'),
                              ],
                            )),
                      ],
                    ),
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
                              Stack(
                                children: <Widget>[
                                  Transform.translate(
                                    offset: Offset(10, 265),
                                    child: SizedBox(
                                      width: responsive.wd(75),
                                      child: Text(
                                        '¿Qué es Bike Register COL?',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 18,
                                          color: Colors.black,
                                          letterSpacing: 1.44,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(8, 315),
                                    child: SizedBox(
                                      width: responsive.wd(80),
                                      height: responsive.hg(57),
                                      child: SingleChildScrollView(
                                          child: Text(
                                        '“Bike Register COL” es una iniciativa de proyecto que '
                                            'a partir del registro de un usuario y los datos de su bicicleta, '
                                            'busca conocer y categorizar el tipo de bicicletas usadas en la ciudad '
                                            'de Cali, además de las zonas donde su uso es más frecuente y no se cuenta'
                                            ' con ciclo rutas para tal fin. Brindando una manera de combatir el hurto de '
                                            'las mismas en la ciudad. Con esta aplicación se busca facilitar el proceso de '
                                            'denuncia de hurto y contar con un mecanismo para la devolución a sus legítimos dueños, '
                                            'también busca permitir conocer en qué zonas es necesaria la implementación de ciclo carriles.',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 16,
                                          color: Color(0xe62c2c2c),
                                        ),
                                        textAlign: TextAlign.justify,
                                      )),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, 305),
                                    child: Container(
                                      width: responsive.wd(85),
                                      height: responsive.hg(38),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0x18bbbbbb),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Color(0x4a707070)),
                                      ),
                                    ),
                                  ),
                                ],
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
                              ),
                              SizedBox(height: responsive.hg(5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 155,
                                      minWidth: 155,
                                    ),
                                    child: CupertinoButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: responsive.inc(2)),
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(4),
                                        onPressed: () =>
                                            Navigator.pushNamed(context, "#"),
                                        child: Text("Ver Perfil",
                                            style: TextStyle(
                                                fontSize: responsive.inc(2)))),
                                  ),
                                  SizedBox(width: responsive.wd(4.5)),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 155,
                                      minWidth: 155,
                                    ),
                                    child: CupertinoButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: responsive.inc(2)),
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(4),
                                        onPressed: () => Navigator.pushNamed(
                                            context, "bikeregister"),
                                        child: Text("Registrar Bicicleta",
                                            style: TextStyle(
                                                fontSize: responsive.inc(2)))),
                                  ),
                                ],
                              ),
                              SizedBox(height: responsive.hg(7))
                            ],
                          )
                        ],
                      )),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
