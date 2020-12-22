import 'package:flutter/material.dart';
import 'package:veridflutterplugin_example/liveTests.dart';
import 'package:veridflutterplugin_example/mocks.dart';
import 'package:veridflutterplugin_example/uiUtils.dart';

class DetectFaceInImage extends StatefulWidget {
  @override
  _DetectFaceInImageState createState() => _DetectFaceInImageState();
}

class _DetectFaceInImageState extends State<DetectFaceInImage> {
  String _operationResult = '';
  LiveTests liveTests = LiveTests.getInstance();

  @override
  void initState() {
    super.initState();
  }

  void onError(e) {
    if (e != null) {
      setState(() {
        _operationResult = 'Error is: $e';
      });
    }
  }

  void onSuccess(message) {
    setState(() {
      _operationResult = 'Success: $message';
    });
  }

  List<Widget> getViewContent(context) {
    List<Widget> buttons = [];
    buttons.add(UiUtils.createButton('Detect face in image: Image has face', () {
      liveTests.detectFaceInImage(Mocks.FACE_IMAGE).then((face) {
        onSuccess(face.toString());
      }).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Detect face in image: Image is empty', () {
      liveTests.detectFaceInImage(Mocks.EMPTY_IMAGE).then((face) {
        onSuccess(face.toString());
      }).catchError(onError);
    }));

    List<Widget> content = [
      Center(child: Text('Operation result: $_operationResult\n'))
    ];
    content.addAll(buttons);

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detect Face in Image'),
        ),
        body: Center(
          //child: Text('Running on: $_platformVersion\n' ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              children: getViewContent(context),
            )
        )
    );
  }
}