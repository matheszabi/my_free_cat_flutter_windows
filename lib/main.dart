import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'webservice_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter My Free Cats'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // a blank memory image:
  var _displayedImage = Image.asset('assets/images/transparent_1px.png');

  void updateImage(Image img) {
    setState(() {

      //======== Exception caught by image resource service ================================================
      // The following ImageCodecException was thrown resolving an image codec:
      // Failed to load network image.
      // Image URL: https://cdn2.thecatapi.com/images/131.jpg
      // Trying to load an image from another domain? Find answers at:
      // https://flutter.dev/docs/development/platform-integration/web-images
      //
        _displayedImage = img;


    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(

          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, // first row
                children: [
                  // a label:
                  const Text('Load a random free cat:'),
                  // and a button:
                  ElevatedButton.icon(
                    onPressed: () {
                      debugPrint("Button clicked");
                      Future<Image?> resultAsync = callWebservice();
                      resultAsync.then((Image? value) => {
                        //debugPrint("value.runtimeType:  + $value.runtimeType")
                        if (value != null) {updateImage(value)}
                      });
                    },
                    icon: const Icon(
                      // <-- Icon
                      Icons.download,
                      size: 24.0,
                    ),
                    label: const Text('Download'), // <-- Text
                  ),
                ]),
            //BoxFit.cover
            Container(
              margin: const EdgeInsets.only(left: 20, top:10, right: 20, bottom:10),
              child: FittedBox(// Assertion failed: file:///C:/flutter/packages/flutter/lib/src/rendering/box.dart:319:12                 width > 0.0 is not true
                child: _displayedImage,
                fit: BoxFit.cover,
              ),
            )


          ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}