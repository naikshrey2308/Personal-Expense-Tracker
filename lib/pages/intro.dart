import "package:flutter/material.dart";
import "../globalVars.dart" as globals;
import "../widgets/indicators.dart";


/// This is the default screen loaded when user visits the app without Logging in.
/// 
/// [IntroScreen] renders a list of pages that describe the purpose of the application.
/// Whenever a new user opens the app, by clicking on the ["GET STARTED"] button, this 
/// component can be rendered. Basically, this is a list of hint or informative screens
/// that guide the user to make the first steps by creating their account.
/// 
class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

/// Provides the state to the [IntroScreen] widget.
class _IntroScreenState extends State<IntroScreen> {

  // keeps track of the current page
  int slide = -1;
  // the minimum index of the page list
  int minSlide = 0;
  // the maximum index of the page list
  int maxSlide = 3;

// The slides are not actually moved. Just the new content is loaded and the old one is
// replaced. This array has those list of states values.
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
      "content":
          "And start saving! What are you waiting for? Create your account now!"
    }
  ];

  @override
  Widget build(BuildContext context) {

    // If it is the first slide, it is the Welcome slide.
    if (slide == -1) {
      return Scaffold(

        /// [Stack] is a widget provided by the Material Library in Flutter.
        /// 
        /// We can position the elements inside the stack on top of another.
        /// That is, instead of using relative positioning to calculate their location,
        /// widgets use the absolute positioning instead.
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

              /// [deviceHeight] returns the height of the current viewport.
              /// 
              height: globals.deviceHeight(context) * 0.8,
              
              /// [deviceWidth] returns the width of the current viewport.
              /// 
              width: globals.deviceWidth(context),
              
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Colors.red,

                    /// globals module has some of the neccessary application scope properties.
                    /// 
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
                // makes a container in the shape of a filled circle
                shape: BoxShape.circle,
                // overlaying the first to create a multiple wave effect
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

            /// [Positioned] element acts as a wrapper element for absolute measures.
            /// 
            /// Just like the [Container] is used as a wrapper in terms of relative positioning, 
            /// the [Positioned] is a wrapper in terms of absolute positioning.
            Positioned(
              top: globals.deviceHeight(context) * 0.75,
              left: globals.deviceWidth(context) * 0.28,
              child: Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {

                          // once a user clicks on this button, the manual slideshow should begin.
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
                          if (slide == maxSlide) {
                            Navigator.of(context).pushNamed("/login");
                          } else {
                            slide++;
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
