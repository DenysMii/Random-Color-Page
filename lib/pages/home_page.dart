import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_color_page/widgets/color_slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Widget with Home Page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int alphaValue = 255;
  final int darkPointValue = 127;

  Color? bgColor;
  Color? textColor;

  double redBGValue = 0.0;
  double greenBGValue = 0.0;
  double blueBGValue = 0.0;

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  ///Loads background colours
  Future<void> getPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setBGColor(
      prefs.getDouble('redBGValue') ?? 0,
      prefs.getDouble('greenBGValue') ?? 0,
      prefs.getDouble('blueBGValue') ?? 0,
    );
  }

  ///Sets background colours and calls setTextColor()
  void setBGColor(double newRedValue, double newGreenValue, double newBlueValue) {
    redBGValue = newRedValue;
    greenBGValue = newGreenValue;
    blueBGValue = newBlueValue;

    setTextColor();
    setPreferences();

    setState(() {
      bgColor = Color.fromARGB(
        alphaValue,
        newRedValue.round(),
        newGreenValue.round(),
        newBlueValue.round(),
      );
    });
  }

  ///Sets the colour of the "Hello there" text
  void setTextColor() {
    setState(() {
      textColor =
          redBGValue >= darkPointValue ||
              greenBGValue >= darkPointValue ||
              blueBGValue >= darkPointValue
          ? Colors.black
          : Colors.white;
    });
  }

  ///Preserves background colours 
  Future<void> setPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('redBGValue', redBGValue);
    await prefs.setDouble('greenBGValue', greenBGValue);
    await prefs.setDouble('blueBGValue', blueBGValue);
  }

  ///Generates a random colour for the background
  void randomiseBGColor() {
    final randomiser = Random();

    final r = randomiser.nextInt(256);
    final g = randomiser.nextInt(256);
    final b = randomiser.nextInt(256);

    setBGColor(r.toDouble(), g.toDouble(), b.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: randomiseBGColor,
        child: DecoratedBox(
          decoration: BoxDecoration(color: bgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 70,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            ColorSliderWidget(
                              label: 'R',
                              colorValue: redBGValue,
                              onChanged: (newRedValue) => setBGColor(
                                newRedValue,
                                greenBGValue,
                                blueBGValue,
                              ),
                            ),
                            ColorSliderWidget(
                              label: 'G',
                              colorValue: greenBGValue,
                              onChanged: (newGreenValue) => setBGColor(
                                redBGValue,
                                newGreenValue,
                                blueBGValue,
                              ),
                            ),
                            ColorSliderWidget(
                              label: 'B',
                              colorValue: blueBGValue,
                              onChanged: (newBlueValue) => setBGColor(
                                redBGValue,
                                greenBGValue,
                                newBlueValue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 11,
                child: Text(
                  'Hello there',
                  style: TextStyle(
                    fontSize: 30, 
                    color: textColor
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
