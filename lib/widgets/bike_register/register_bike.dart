import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/responsive.dart';

class RegisterBike extends StatelessWidget {
  const RegisterBike({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Container(

            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 15,
                    top: 15,
                    child: SafeArea(
                      child: CupertinoButton(
                        padding: EdgeInsets.all(10),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black12,
                        onPressed: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Positioned(
                  top: constraints.maxHeight * 0.8,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 2,
                        width: constraints.maxWidth,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 9),
                      Text(
                        "¡Registra tú Bici!",
                        style: TextStyle(
                            fontSize: responsive.inc(2.5),
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/pages/bike_register/clouds.svg',
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.8,
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.23,
                  child: SvgPicture.asset(
                    'assets/pages/bike_register/man_ride.svg',
                    width: constraints.maxWidth * 0.50,
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.30,
                  right: 8,
                  child: SvgPicture.asset(
                    'assets/pages/bike_register/women_activity.svg',
                    width: constraints.maxWidth * 0.35,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
