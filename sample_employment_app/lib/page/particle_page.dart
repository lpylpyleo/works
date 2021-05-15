import 'dart:math';

import 'package:flutter/material.dart';

class ParticlePage extends StatefulWidget {
  const ParticlePage({Key key}) : super(key: key);

  @override
  _ParticlePageState createState() => _ParticlePageState();
}

class _ParticlePageState extends State<ParticlePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ParticleManager pm = ParticleManager(size: Size(300, 300));
  Random random;

  @override
  void initState() {
    super.initState();
    random = Random();
    initParticleManager();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(pm.tick)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  void initParticleManager() {
    for (var i = 0; i < 20; i++) {
      pm.addParticle(Particle(
        x: 288 * random.nextDouble() + 6,
        // 6 ... 294
        y: 288 * random.nextDouble() + 6,
        vx: 5 * random.nextDouble(),
        vy: 5 * random.nextDouble(),
        ax: random.nextDouble(),
        ay: random.nextDouble(),
        color: randomColor(),
        size: 10 * random.nextDouble(),
      ));
    }
  }

  Color randomColor() {
    return Color(random.nextInt(0xffffffff));
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: theWorld,
          child: CustomPaint(
            size: pm.size,
            painter: WorldRenderer(pm),
          ),
        ),
      ),
    );
  }
}

class WorldRenderer extends CustomPainter {
  final ParticleManager manager;

  WorldRenderer(this.manager) : super(repaint: manager);

  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, stokePaint);
    manager.particles.asMap().forEach((i, particle) {
      drawParticle(canvas, particle);
      manager.update(particle);
    });
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ParticleManager with ChangeNotifier {
  List<Particle> particles = [];
  Size size;

  ParticleManager({this.size});

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    // update();
    notifyListeners();
  }

  void update(Particle particle) {
    const loss = 0.5;
    var r = particle.size;
    particle.x += particle.vx;
    particle.y += particle.vy;
    particle.vy += particle.ay;

    if (particle.x + r >= size.width || particle.x - r <= 0) {
      particle.vx = -particle.vx * loss;
      if (particle.vx.abs() < 0.01) {
        particle.vx = 0;
      }
    }
    if (particle.y + r >= size.height || particle.y - r <= 0) {
      particle.vy = -particle.vy * loss;
      if (particle.vy.abs() < 0.01) {
        particle.vy = 0;
      }
    }
  }
}

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double ax;
  double ay;
  double size;
  Color color;

  Particle({
    this.x,
    this.y,
    this.vx,
    this.vy,
    this.ax,
    this.ay,
    this.size,
    this.color,
  });
}
