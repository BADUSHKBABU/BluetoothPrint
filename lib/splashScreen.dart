import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printapp/printpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    delay(BuildContext);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center
            ,
        children: [Image.asset("assets/easyprint.jpg")],
      )),
    );
  }

  Future delay(BuildContext) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return PrintPage();
    }));
  }
}
