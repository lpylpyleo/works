import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const _bgR = 100.0;

class PaintPage extends StatefulWidget {
  final double size;

  const PaintPage({Key key, @required this.size}) : super(key: key);

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> with TickerProviderStateMixin {
  AnimationController ctrl;
  AnimationController ctrl1;
  Animation<Offset> animation;

  ValueNotifier<Offset> notifier = ValueNotifier(Offset.zero);

  Offset offset = Offset.zero;

  Offset pc = Offset(-100, -80);
  Offset p0 = Offset(-0, 0);
  Offset p1 = Offset(0, -120);

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    ctrl1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(period: const Duration(seconds: 12));

    notifier.value = Offset(widget.size / 2, widget.size / 2);
  }

  @override
  void dispose() {
    ctrl.dispose();
    ctrl1.dispose();
    super.dispose();
  }

  double f(double x) {
    return x * x / 100 - 50;
  }

  // double pole(double rad) {
  //   return (pow(e, cos(rad)) - 2 * cos(4 * (rad)) + pow(sin((rad) / 12), 5)) *
  //       40;
  // }
  double pole(double rad) {
    return 10 * rad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: control()),
          fx(),
          Expanded(
            child: Container(
              color: Colors.cyanAccent,
              child: GestureDetector(
                onPanStart: (e) => updatePoints(e),
                onPanUpdate: (e) => updatePoints(e),
                child: CustomPaint(
                  size: Size(300, 200),
                  painter: CoordinationPainter(),
                  foregroundPainter: BezierPainter(pc, p0, p1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updatePoints(e) {
    final localPosition = e.localPosition;
    final Offset real = localPosition - Offset(150, 160);
    final r = 15;

    if ((real - pc).distance < r) {
      pc = real;
    } else if ((real - p0).distance < r) {
      p0 = real;
    } else if ((real - p1).distance < r) {
      p1 = real;
    }
    setState(() {});
  }

  Widget fx() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.yellowAccent,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: FxPainter(f, pole, ctrl1),
        ),
      ),
    );
  }

  Widget control() {
    return RepaintBoundary(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (e) {
          notifier.value = e.localPosition;
        },
        onPanUpdate: (detail) {
          notifier.value = detail.localPosition;
        },
        onPanEnd: (e) {
          animation = Tween<Offset>(
            begin: notifier.value,
            end: Offset(widget.size / 2, widget.size / 2),
          ).animate(ctrl.drive(CurveTween(curve: Cubic(0.5, 0.21, 0.51, 1.63))))
            ..addListener(setValue)
            ..addStatusListener((status) {
              if (animation.isCompleted) {
                animation.removeListener(setValue);
              }
            });
          ctrl.forward(from: 0);
        },
        child: CustomPaint(
          size: Size(widget.size, widget.size),
          painter: ControllerPainter(notifier),
        ),
      ),
    );
  }

  setValue() {
    notifier.value = animation.value;
  }
}

class ControllerPainter extends CustomPainter {
  final ValueNotifier<Offset> offset;

  ControllerPainter(this.offset) : super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.tealAccent;

    canvas.translate(size.width / 2, size.height / 2);

    final c = Offset.zero;
    canvas.drawCircle(c, _bgR, paint);

    Offset handleOffset =
        offset.value - Offset(size.width / 2, size.height / 2);
    final d = (handleOffset - c).distance;

    if (d > _bgR) {
      handleOffset = Offset(
          (handleOffset - c).dx * _bgR / d, (handleOffset - c).dy * _bgR / d);
    }

    canvas.drawLine(
        c, handleOffset, paint..color = Colors.teal.withOpacity(0.5));

    canvas.drawCircle(handleOffset, 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FxPainter extends CustomPainter {
  final double Function(double) f;
  final double Function(double) pole;
  final Animation animation;

  FxPainter(this.f, this.pole, this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(100, 0),
        [Colors.green, Colors.orange, Colors.red, Colors.purple],
        [0.2, 0.4, 0.6, 0.8],
        TileMode.mirror,
      );
    canvas.translate(size.width / 2, size.height / 2);
    List<Offset> points = [];
    for (var i = -100; i < 100; i++) {
      points.add(Offset(i.toDouble(), -f(i.toDouble())));
      // points.add(Offset(-i.toDouble(), f(i.toDouble())));
    }

    List<Offset> points1 = [];
    for (double rad = 0; rad < 4 * pi; rad += 0.1) {
      final p = pole(rad);
      points1.add(Offset(p * cos(rad), p * sin(rad)));
    }
    final p = pole(4 * pi);
    points1.add(Offset(p, 0));
    points1.add(Offset(p, 0));

    canvas.drawPoints(ui.PointMode.polygon, points, paint);

    Offset p1 = points1[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);
    for (var i = 1; i < points1.length - 1; i++) {
      double xc = (points1[i].dx + points1[i + 1].dx) / 2;
      double yc = (points1[i].dy + points1[i + 1].dy) / 2;
      Offset p2 = points1[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }

    // canvas.drawPoints(ui.PointMode.polygon, points1, paint);

    final pm = path.computeMetrics().first;
    final t = pm.getTangentForOffset(pm.length * animation.value);

    canvas.drawPath(
        pm.extractPath(0, pm.length * animation.value),
        paint
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(t.position, 4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BezierPainter extends CustomPainter {
  final Offset pc;
  final Offset p0;
  final Offset p1;

  const BezierPainter(this.pc, this.p0, this.p1);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.clipRect(Offset.zero & size);

    canvas.translate(size.width / 2, size.height / 2);

    final path = Path();
    path.moveTo(p0.dx, p0.dy);
    path.quadraticBezierTo(pc.dx, pc.dy, p1.dx, p1.dy);
    canvas.drawPath(path, paint);

    canvas.drawCircle(pc, 8, paint);
    canvas.drawCircle(p0, 8, paint);
    canvas.drawCircle(p1, 8, paint);

    canvas.drawLine(p0, pc, paint);
    canvas.drawLine(pc, p1, paint);

    drawText(canvas, 'pc', pc);
    drawText(canvas, 'p0', p0);
    drawText(canvas, 'p1', p1);
  }

  void drawText(Canvas canvas, String name, Offset offset) {
    var ts = TextSpan(
        text: '$name $offset',
        style: TextStyle(color: Colors.deepPurple, fontSize: 12));
    var tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, offset + Offset(-tp.width / 2, 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CoordinationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]
      ..strokeWidth = 1;
    canvas.translate(size.width / 2, 0);

    for (var i = 0.0; i < size.width / 2; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
      canvas.drawLine(Offset(-i, 0), Offset(-i, size.height), paint);
    }
    canvas.translate(-size.width / 2, size.height / 2);
    for (var i = 0.0; i < size.height / 2; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
      canvas.drawLine(Offset(0, -i), Offset(size.width, -i), paint);
    }
    canvas.translate(size.width / 2, 0);

    paint.color = Colors.red;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
