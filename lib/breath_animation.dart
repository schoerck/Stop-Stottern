import 'package:flutter/material.dart';

class BreathAnimation extends StatefulWidget {
  final double breatheIn;
  final double breatheOut;
  final double breathHold;
  final Color color;

  const BreathAnimation({
    Key key,
    @required this.breatheIn,
    @required this.breatheOut,
    @required this.breathHold,
    @required this.color,
  }) : super(key: key);
  @override
  _BreathAnimationState createState() => _BreathAnimationState();
}

class _BreathAnimationState extends State<BreathAnimation> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animationIn;
  Animation _animationOut;
  Duration _breatheOut;
  Duration _breatheIn;
  Duration _breathHold;
  Duration _breathTimeTotal;

  void setAnimation(double inB, double outB, double holdB) {
    _breatheOut = Duration(milliseconds: (inB * 1000).toInt());
    _breatheIn = Duration(milliseconds: (outB * 1000).toInt());
    _breathHold = Duration(milliseconds: (holdB * 1000).toInt());
    _breathTimeTotal = _breatheOut + _breatheIn + _breathHold;
    _controller = AnimationController(
      vsync: this,
      duration: _breathTimeTotal,
    )..repeat();
    _animationIn = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0,
        _breatheOut.inMilliseconds / _breathTimeTotal.inMilliseconds,
      ),
    );

    _animationOut = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (_breatheOut + _breathHold).inMilliseconds / _breathTimeTotal.inMilliseconds,
          1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setAnimation(
      widget.breatheOut,
      widget.breatheIn,
      widget.breathHold,
    );
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double animateValue;
        if (_animationIn.value == 1) {
          animateValue = _animationOut.value;
        } else {
          animateValue = _animationIn.value;
        }

        return CustomPaint(
          willChange: true,
          painter: BreathPainter(
            1.0 - animateValue,
            widget.color,
          ),
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.5,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BreathPainter extends CustomPainter {
  final double progress;
  final Paint breathPaint;
  final Color color;

  BreathPainter(this.progress, this.color)
      : this.breathPaint = Paint()
          ..strokeWidth = 5
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..color = color;
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;

    Path path = Path()
      ..moveTo(
        sw * 0.15,
        sh * 0.05,
      )
      ..lineTo(
        sw * 0.85,
        sh * 0.05,
      )
      ..lineTo(
        sw * (0.75 + progress / 5),
        sh * 0.95,
      )
      ..quadraticBezierTo(
        sw * 0.5,
        (sh * 0.95) * progress,
        sw * (0.25 - progress / 5),
        sh * 0.95,
      )
      ..lineTo(
        sw * 0.15,
        sh * 0.05,
      )
      ..close();

    canvas.drawPath(
      path,
      breathPaint,
    );
  }

  @override
  bool shouldRepaint(BreathPainter old) {
    return old.progress != progress;
  }
}
