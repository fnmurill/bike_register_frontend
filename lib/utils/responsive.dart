import 'dart:math' as math;
import 'package:meta/meta.dart' show required;
import 'package:flutter/cupertino.dart';

class Responsive {
  final double width, height, inch;

  Responsive(
      {@required this.width, @required this.height, @required this.inch});

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    //c2=a2+b2 => c = sqrt(a2+b2)
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  double wd(double percent) {
    return width * percent / 100;
  }

  double hg(double percent) {
    return height * percent / 100;
  }

  double inc(double percent) {
    return inch * percent / 100;
  }
}
