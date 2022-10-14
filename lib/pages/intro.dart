import "package:flutter/material.dart";
import "../globalVars.dart" as globals;
import "../widgets/indicators.dart";

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int slide = -1;
  int minSlide = 0;
  int maxSlide = 3;

  List<Map<String, String>> introTexts = [
    {
      "title": "Manage Money",
      "content": "Finding it difficult to manage your daily expenses?"
    },
    {
      "title": "About Expensee",
      "content": "You've come to the right place. Expensee has got your back!"
    },
    {
      "title": "Your Account", 
      "content": "Just create an account. It's completely free."
    },
    {
      "title": "Save Money",
      "content": "And start saving! What are you waiting for? Create your account now!"
    }
  ];

  @override
  Widget build(BuildContext context) {
    if (slide == -1) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: globals.deviceHeight(context) * 0.4,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.red,
                globals.primary,
              ])),
            ),
            Container(
              height: globals.deviceHeight(context) * 0.8,
              width: globals.deviceWidth(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Colors.red,
                    globals.primary,
                  ])),
              child: Column(
                children: [
                  Row(),
                ],
              ),
            ),
            Container(
              height: globals.deviceHeight(context) * 0.9,
              width: globals.deviceWidth(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x22ff5757),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(children: [
                Container(
                  height: globals.deviceHeight(context) * 0.6,
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("assets/images/logos/logo_no_bg.png"),
                  ),
                ),
              ]),
            ),
            Positioned(
              top: globals.deviceHeight(context) * 0.75,
              left: globals.deviceWidth(context) * 0.28,
              child: Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          slide = 0;
                        });
                      },
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: globals.primary,
                        elevation: 0,
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: globals.deviceHeight(context) * 0.85,
              left: globals.deviceWidth(context) * 0.28,
              child: Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/login");
                      },
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[100],
                        elevation: 0,
                        padding: EdgeInsets.fromLTRB(56, 16, 56, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(),
              Container(
                child: Image(
                  image: AssetImage("assets/images/intros/${slide + 1}.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                alignment: Alignment.center,
                child: Text(
                  introTexts[slide]["title"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                alignment: Alignment.center,
                child: Text(
                  introTexts[slide]["content"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(120, 0, 120, 0),
                child: Indicators(
                  size: (maxSlide - minSlide + 1),
                  active: slide,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          slide = (slide == minSlide) ? slide : (slide - 1);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: (slide == minSlide)
                          ? null
                          : Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(slide == maxSlide) {
                            Navigator.of(context).popAndPushNamed("/login");
                          }
                          else {
                            slide ++;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                          elevation: 0,
                          primary: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
