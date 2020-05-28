import 'package:flutter/material.dart';

class Painter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CANVAS TEST'),
      ),
      body: Container(
        alignment: FractionalOffset(0.5, 0.5),
        child: GestureDetector(
          onTapDown: (TapDownDetails data){
            var x = data.localPosition.dx;
            var y = data.localPosition.dy; 
            var gx= data.globalPosition.dx;
            var gy = data.globalPosition.dy;
            print('$x $y $gx $gy');
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: CustomPaint(
              painter: Painting(),
            ),
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class Painting extends CustomPainter {
  Map<String,Path> _data = Map();

  @override
  void paint(Canvas canvas, Size size) {
    Paint rectPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0
      ..color = Colors.yellow;

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
    List<Offset> position = [Offset(0,0),Offset(0,1),Offset(1,1),Offset(1,0)];
    rect.addPolygon(position, true);
    _data['rect'] = rect;
    canvas.scale(100,100);
    canvas.drawPath(rect, rectPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool hitTest(Offset location){
    print('touched ${location.dx}');
    Path rect = _data['rect'];
    double x = location.dx/100;
    double y = location.dy/100;
    if(rect.contains(Offset(x,y))){
      print('yellow square');
    }
    else{
      print('green rectangle');
    }
    return true;
  }
}
