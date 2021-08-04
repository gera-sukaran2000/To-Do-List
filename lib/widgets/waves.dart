import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Waves extends StatelessWidget {
  const Waves({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context);
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: ClipPath(
            child: FittedBox(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: deviceSize.size.width * 1,
                height: deviceSize.size.height * 0.15,
                color: Colors.pink[300],
              ),
            ),
            clipper: WaveClipperTwo(reverse: true),
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipPath(
            child: FittedBox(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: deviceSize.size.width * 1,
                height: deviceSize.size.height * 0.15,
                color: Colors.pink[100],
              ),
            ),
            clipper: WaveClipperTwo(reverse: true, flip: true),
          ),
        ),
      ],
    );
  }
}
