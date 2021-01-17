import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> with SingleTickerProviderStateMixin {
  AnimationController progressController;
  Animation<double> animation;

  double percent = 0.0, flag = 0.0;
  int timeInMinute = 25;
  int timeInSec = 25 * 60;

  String timeStr;

  Timer timer;

  bool isRunning = false;

  String _convertToTime(count) {
    int minutes = (count / 60).floor();
    String minutesStr = minutes.toString();
    int seconds = count % 60;
    String secondsStr =
        seconds < 10 ? ('0' + seconds.toString()) : seconds.toString();
    print("$minutesStr:$secondsStr");
    timeStr = "$minutesStr:$secondsStr";
    return timeStr;
  }

  void _startTimer() {
    double percentage = 1 / timeInSec;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        isRunning = true;
        if (timeInSec > 0) {
          timeInSec--;
          _convertToTime(timeInSec);
          if (timeInSec % 60 == 0) {
            timeInSec--;
          }

          flag += percentage;
          if (flag < 1) {
            percent += percentage;
          } else {
            percent = 1;
          }
        } else {
          setState(() {
            percent = flag = 0.0;
            isRunning = false;
            timeStr = _convertToTime(timeInMinute * 60);
            timer.cancel();
          });
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      isRunning = false;
      timer.cancel();
    });
  }

  void _resetTimer() {
    setState(() {
      percent = flag = 0.0;
      timeInMinute = 25;
      timeInSec = 25 * 60;
      isRunning = false;
      timeStr = _convertToTime(timeInSec);

      if (timer != null) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    progressController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: 80).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    timeStr = _convertToTime(timeInSec);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff434343), Color(0xff000000)],
          begin: FractionalOffset(0.5, 1),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CircularPercentIndicator(
              percent: percent,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animateFromLastPercent: true,
              radius: 200.0,
              lineWidth: 10.0,
              progressColor: Colors.white,
              center: Text(
                timeStr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Container(
              width: double.infinity,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [Color(0xff4481eb), Color(0xff04befe)],
              //   ),
              //   borderRadius: BorderRadius.only(
              //     topRight: Radius.circular(20.0),
              //     topLeft: Radius.circular(20.0),
              //   ),
              // ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  children: [
                    Text(
                      "Session Time",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(Icons.keyboard_arrow_down),
                            onPressed: () {
                              setState(() {
                                if (timeInMinute > 1 && !isRunning) {
                                  timeInMinute--;
                                  timeInSec = timeInMinute * 60;
                                  timeStr = _convertToTime(timeInSec);
                                }
                              });
                            }),
                        Text(
                          "$timeInMinute",
                          style: TextStyle(fontSize: 40.0),
                        ),
                        IconButton(
                            icon: Icon(Icons.keyboard_arrow_up),
                            onPressed: () {
                              setState(() {
                                if (timeInMinute < 60 && !isRunning) {
                                  timeInMinute++;
                                  timeInSec = timeInMinute * 60;
                                  timeStr = _convertToTime(timeInSec);
                                }
                              });
                            }),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: isRunning ? _pauseTimer : _startTimer,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.5),
                                  )
                                ],
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(
                                isRunning
                                    ? Icons.pause_circle_outline_sharp
                                    : Icons.play_arrow_sharp,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          GestureDetector(
                            onTap: _resetTimer,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 15.0,
                                    offset: Offset(0.0, 0.75),
                                  )
                                ],
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(Icons.sync),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
