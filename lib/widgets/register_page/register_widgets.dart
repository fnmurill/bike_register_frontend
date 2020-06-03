import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/responsive.dart';

class RegisterWidgets extends StatelessWidget {
  const RegisterWidgets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return AspectRatio(
      aspectRatio: 16 / 8,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: constraints.maxHeight * 0.7,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1.5,
                        width: constraints.maxWidth,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "¡Bienvenido Registrate!",
                        style: TextStyle(
                            fontSize: responsive.inc(2.5),
                            fontWeight: FontWeight.bold),
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
                    height: constraints.maxHeight * 0.6,
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.20,
                  child: SvgPicture.asset(
                    'assets/pages/bike_register/man_ride.svg',
                    width: constraints.maxWidth * 0.40,
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.23,
                  right: 8,
                  child: SvgPicture.asset(
                    'assets/pages/bike_register/women_activity.svg',
                    width: constraints.maxWidth * 0.28,
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
