import 'package:flutter/material.dart';
import 'package:interview_app/widget/inner_shadow.dart';

class ShadowPage extends StatefulWidget {
  const ShadowPage({Key key}) : super(key: key);

  @override
  _ShadowPageState createState() => _ShadowPageState();
}

class _ShadowPageState extends State<ShadowPage> {
  double blur = 10;
  double offsetX = 10;
  double offsetY = 10;

  @override
  Widget build(BuildContext context) {
    // final color = Colors.white;
    // final color = Colors.grey[300];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 150,
                    child: InnerShadow(
                      color: Colors.black,
                      offset: Offset(offsetX, offsetY),
                      blur: blur,
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              offset: Offset(5, 5),
                              blurRadius: 15,
                            )
                          ],
                        ),
                      ),
                      // child: Image.asset(
                      //   "assets/splat.png",
                      // ),
                    ),
                  ),
                ),
                // Container(
                //   width: 50,
                //   color: Colors.transparent,
                // ),
                // Expanded(
                //   child: Container(
                //     child: InnerShadow(
                //       color: Colors.black,
                //       offset: Offset(offsetX, offsetY),
                //       blur: blur,
                //       child: Image.asset(
                //         "assets/splat.png",
                //         fit: BoxFit.fitWidth,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 100),
            Text("Blur ${blur.round()}"),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 300),
              child: Slider.adaptive(
                min: 0,
                max: 50,
                value: blur,
                onChanged: (newValue) {
                  setState(() {
                    blur = newValue;
                  });
                },
              ),
            ),
            Text("Offset X ${offsetX.round()}"),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 300),
              child: Slider.adaptive(
                min: -50,
                max: 50,
                value: offsetX,
                onChanged: (newValue) {
                  setState(() {
                    offsetX = newValue;
                  });
                },
              ),
            ),
            Text("Offset Y ${offsetY.round()}"),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 300),
              child: Slider.adaptive(
                min: -50,
                max: 50,
                value: offsetY,
                onChanged: (newValue) {
                  setState(() {
                    offsetY = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
