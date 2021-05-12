import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';

class Badge extends StatelessWidget {
  final int count;
  final int max;
  final Widget child;
  final double size;

  const Badge({
    Key key,
    @required this.count,
    @required this.child,
    this.size,
    this.max = 99,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inner = size ?? 14;
    final outer = inner * 1.15;
    final _badge = Container(
      width: inner,
      height: inner,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Style.badgeRed,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${count.clamp(0, max)}',
        style: TextStyle(
          color: Colors.white,
          fontSize: (inner * 0.7),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );

    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.topRight,
      children: [
        child,
        if (count > 0)
          Positioned(
            right: -outer / 2.5,
            top: -outer / 2.5,
            child: Container(
              width: outer,
              height: outer,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        if (count > 0)
          Positioned(
            right: -inner / 2.5,
            top: -inner / 2.5,
            child: _badge,
          ),
      ],
    );
  }
}
