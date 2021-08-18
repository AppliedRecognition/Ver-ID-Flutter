import 'package:flutter/material.dart';
import 'package:veridflutterplugin_example/liveTests.dart';
import 'package:veridflutterplugin_example/uiUtils.dart';
import 'package:veridflutterplugin/src/Face.dart';

class CompareFaces extends StatefulWidget {
  @override
  _CompareFacesState createState() => _CompareFacesState();
}

class _CompareFacesState extends State<CompareFaces> {
  String _operationResult = '';
  Face _face1;
  Face _face2;
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

  void handleCaptureLiveFaceResult(sessionResult, faceToUpdate) {
    if (sessionResult.attachments.isNotEmpty) {
      Face face = sessionResult.attachments[0].recognizableFace;
      if (faceToUpdate == 'face1') {
        _face1 = face;
      } else {
        _face2 = face;
      }
      onSuccess('Got Face correctly');
    } else {
      onError('Detected faces attachments from capture live face are empty');
    }
  }

  List<Widget> getCompareFacesViewContent(context) {
    List<Widget> buttons = [];
    buttons.add(UiUtils.createButton('Get Face 1 from capture live face', () {
      liveTests.captureLiveFace().then((sessionResult) {
        handleCaptureLiveFaceResult(sessionResult, 'face1');
      }).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Get Face 2 from capture live face', () {
      liveTests.captureLiveFace().then((sessionResult) {
        handleCaptureLiveFaceResult(sessionResult, 'face2');
      }).catchError(onError);
    }));
    buttons.add(UiUtils.createButton('Compare Face 1 and Face 2', () {
      if (_face1 == null) {
        onError('Face 1 is undefined');
        return;
      }
      if (_face2 == null) {
        onError('Face 2 is undefined');
        return;
      }
      liveTests.compareFaces(_face1, _face2).then((comparisonResult) {
        onSuccess(comparisonResult.toString());
      }).catchError(onError);
    }));

    List<Widget> content = [
      Center(child: Text('Operation result: $_operationResult\n')),
      Center(child: Text('Face 1: ${_face1 != null ? _face1.toString() : 'EMPTY'}\n')),
      Center(child: Text('Face 2: ${_face2 != null ? _face2.toString() : 'EMPTY'}\n')),
    ];
    content.addAll(buttons);

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Compare Faces'),
        ),
        body: Center(
          //child: Text('Running on: $_platformVersion\n' ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              children: getCompareFacesViewContent(context),
            )
        )
    );
  }
}