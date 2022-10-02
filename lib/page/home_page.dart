import 'dart:math' as math;
import 'dart:math';
          


import 'package:flutter/material.dart';
import 'package:gdg_brainstorm/page/add.dart';
import 'package:gdg_brainstorm/page/edit.dart';
import 'package:gdg_brainstorm/page/state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var tasks = context.watch<Todo>().tasks;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(" Error ",style:GoogleFonts.notoSansLao())),
        centerTitle: false,
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: GridView.builder(
          itemCount: tasks.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,crossAxisSpacing: 8),
              
          itemBuilder: (BuildContext context, int index) {
            return StickyNote(
              body: Container(
                
                child: ListTile(
                  title: Text(tasks[index],style: GoogleFonts.indieFlower(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black87),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>EditPage(index)));
                  },
                ),
                
              ),
            );
               
          },
        ),
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddPage()));
      },child: Icon(Icons.note_add),),


    );
  }
}

class StickyNote extends StatelessWidget {
  final double? bodyHeight;
  final Color? color;

  final Widget body;
  final int angle, shape;

  const StickyNote({this.color, this.bodyHeight, required this.body, Key? key, this.angle = 0, this.shape = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: angle * math.pi / 180,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ]),
            child: CustomPaint(
              painter: BoxShadowPainter(shape),
              child: ClipPath(
                clipper: CustomStickyNotePainter(shape),
                child: Container(
                  
                  //color: Colors.pink,
                  decoration: BoxDecoration(
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 8)]
                  ),
                ),
              ),
            ),
          ),
        ),
        body
      ],
    );
  }
}

Path drawPath(Size size, int shape, {bool isDrawingShadow = false}) {
  final bottom = isDrawingShadow ? size.height - 8 : size.height;

  const borderRadius = 8.0;

  final paths = [
    Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, bottom)
      ..lineTo(size.width / 3, bottom)
      ..quadraticBezierTo(0, bottom, 0, bottom - borderRadius)
      ..lineTo(0, 0)
      ..close(),
    Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, bottom / 3)
      // ..lineTo(size.width, bottom - borderRadius)
      ..quadraticBezierTo(size.width, bottom - borderRadius, size.width - borderRadius, bottom)
      ..lineTo(0, bottom)
      ..lineTo(0, 0)
      ..close(),
    Path()
      ..moveTo(0, 0)
      ..lineTo(0, bottom)
      ..lineTo(size.width, bottom)
      ..lineTo(size.width / 3, bottom)
      ..quadraticBezierTo(size.width, bottom, size.width, bottom - borderRadius)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close(),
    Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, bottom / 3)
      ..quadraticBezierTo(0, bottom - borderRadius, 0 + borderRadius, bottom)
      ..lineTo(size.width, bottom)
    //   ..lineTo(0, 0)
      ..close(),
  ];

  return paths[shape];
}

class BoxShadowPainter extends CustomPainter {
  final int shape;
  BoxShadowPainter(this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = drawPath(size, shape, isDrawingShadow: true);

    canvas.drawShadow(path, Colors.black45, 8.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomStickyNotePainter extends CustomClipper<Path> {
  final int shape;
  const CustomStickyNotePainter(this.shape);

  @override
  Path getClip(Size size) {
    Path path = drawPath(size, shape);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
