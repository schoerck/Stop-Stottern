import 'package:atemanimation/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double opacity = 0;
  @override
  void initState() {
    delayedRedirect();
    super.initState();
  }

  void delayedRedirect() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => opacity = 1);
    await Future.delayed(Duration(seconds: 1));
    setState(() => opacity = 0);
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: AnimatedOpacity(
            opacity: opacity,
            duration: Duration(seconds: 1),
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}
