import 'package:atemanimation/breath_animation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _in = 2;
  double _out = 3;
  double _hold = 2;

  bool isDark = false;
  Color darkColor = Colors.grey.shade800;
  Color lightColor = Colors.grey.shade50;
  @override
  Widget build(BuildContext context) {
    Color activeColor = isDark ? lightColor : darkColor;
    return Scaffold(
      backgroundColor: isDark ? darkColor : lightColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 50,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.brightness_3 : Icons.brightness_high_sharp,
              color: activeColor,
            ),
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BreathAnimation(
            breatheIn: _in,
            breatheOut: _out,
            breathHold: _hold,
            color: activeColor,
          ),

          //Texte für Slider Sekundenanezeige bold definen (mit RichText Widget ist das möglich)

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Einatmen ',
                style: TextStyle(color: activeColor),
              ),
              Text(
                '${_in.toStringAsFixed(1)}',
                style:
                    TextStyle(color: activeColor, fontWeight: FontWeight.bold),
              ),
              Text(
                's',
                style: TextStyle(color: activeColor),
              ),
            ],
          ),
          Slider(
            min: 1,
            max: 5,
            activeColor: activeColor,
            inactiveColor: activeColor,
            value: _in,
            onChanged: (value) => setState(() {
              _in = value;
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ausatmen ',
                style: TextStyle(color: activeColor),
              ),
              Text(
                '${_out.toStringAsFixed(1)}',
                style:
                    TextStyle(color: activeColor, fontWeight: FontWeight.bold),
              ),
              Text(
                's',
                style: TextStyle(color: activeColor),
              ),
            ],
          ),
          Slider(
            min: 1,
            max: 5,
            activeColor: activeColor,
            inactiveColor: activeColor,
            value: _out.toDouble(),
            onChanged: (value) => setState(() {
              _out = value.toDouble();
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pausen ',
                style: TextStyle(color: activeColor),
              ),
              Text(
                '${_hold.toStringAsFixed(1)}',
                style:
                    TextStyle(color: activeColor, fontWeight: FontWeight.bold),
              ),
              Text(
                's',
                style: TextStyle(color: activeColor),
              ),
            ],
          ),
          Slider(
            min: 1,
            max: 5,
            activeColor: activeColor,
            inactiveColor: activeColor,
            value: _hold.toDouble(),
            onChanged: (value) => setState(() {
              _hold = value.toDouble();
            }),
          ),
        ],
      ),
    );
  }
}
