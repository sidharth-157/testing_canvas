import 'package:flutter/material.dart';

class Painter extends StatefulWidget {
  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  Painting _draw = Painting(color: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CANVAS TEST'),
      ),
      body: Container(
        alignment: FractionalOffset(0.5, 0.5),
        child: GestureDetector(
          onTapDown: (TapDownDetails data) {
            var x = data.localPosition.dx;
            var y = data.localPosition.dy;
            var gx = data.globalPosition.dx;
            var gy = data.globalPosition.dy;
            print('$x $y $gx $gy');
            setState(() {
              var sqColor = _draw.getColor();
              setState(() {
                if (_draw.touchRec()) {
                  if (sqColor == Colors.yellow) {
                    _draw = Painting(color: Colors.purple);
                  } else {
                    _draw = Painting(color: Colors.yellow);
                  }
                }
              });
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: CustomPaint(painter: _draw),
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class Painting extends CustomPainter {
  Map<String, Path> _data = Map();
  Color _smallSquare;
  bool _touch = false;

  Painting({@required Color color}) {
    _smallSquare = color;
  }

  Color getColor() {
    return _smallSquare;
  }

  bool touchRec() => _touch;

  @override
  void paint(Canvas canvas, Size size) {
    Paint rectPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0
      ..color = _smallSquare;

    // Testing canvas with rectangle
    //----------------------------------
    //Rect rect = Offset(0.0, 0.0) & Size(1.0,1.0);
    //Rect rect = Offset(0.0, 0.0) & Size(50.0,50.0);
    //canvas.scale(350.7,150.7);
    //canvas.drawRect(rect, rectPaint);

    Path rect = Path();
    // List<Offset> position = [
    //   Offset(0, 0),
    //   Offset(0, 100),
    //   Offset(100, 100),
    //   Offset(100, 0)
    // ];
    List<Offset> position = [
      Offset(0, 0),
      Offset(0, 1),
      Offset(1, 1),
      Offset(1, 0)
    ];
    rect.addPolygon(position, true);
    _data['rect'] = rect;
    canvas.scale(100, 100);
    canvas.drawPath(rect, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset location) {
    print('touched ${location.dx} ${location.dy}');
    Path rect = _data['rect'];
    double x = location.dx / 100;
    double y = location.dy / 100;
    if (rect.contains(Offset(x, y))) {
      print('touch area');
      _touch = true;
    } else {
      print('green rectangle');
    }
    return false;
  }
}
