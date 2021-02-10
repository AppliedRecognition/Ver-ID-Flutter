# Ver-ID Person Plugin for Flutter

## Introduction

Ver-ID gives your users the ability to authenticate using their face.

## Compatibility 

The Ver-ID plugin has been tested to work with Flutter against the following compatibility matrix for iOS and Android.  Please note that the SDK versions of the corresponding OSes are for compilation purposes (target iOS version on iOS and compile SDK version on Android):

| Flutter Version   | iOS       | Android   |
|-----------------  |-------    |---------  |
| 1.20.4 (stable)   | 13+       | SDK 17+   |
| 1.24.0-10.1.pre   | 13+       | SDK 17+   |


Other combinations may work, but your mileage may vary.  Be sure to run the unit test suite in the example of the plugin to make sure the mobile OS platform combination you are using works before proceeding.

## Adding Ver-ID Person Plugin to Your Flutter App

1. [Request a License File and password](https://dev.ver-id.com/admin/register) for your app.
1. Clone the plugin Git repo into your file system, specify the git repository, or install using the Pub.dev package.  


	1. If cloning from source (install/path/to/plugin is the directory created on the filesystem after you clone the repository):

		~~~bash
		git clone https://github.com/AppliedRecognition/Ver-ID-Flutter.git on your filesystem

		on your pubspec file under dependencies, add:

		dependencies:
		  verid_flutter_plugin: 'relative/path/to/plugin/directory'
		~~~

	1. Specify the path using your project's pubspec.yaml:

		~~~bash
		dependencies:
          veridflutterplugin: '>=0.1.0'
		~~~

    1. Specify the repository (master branch):
        ~~~bash
        dependencies:
            verid_flutter_plugin:
                git:
                    url: 'https://github.com/AppliedRecognition/Ver-ID-Flutter.git'
        ~~~

    1. Specify the repository (custom branch or reference tag):
        ~~~bash
        dependencies:
            verid_flutter_plugin:
                git:
                    url: 'https://github.com/AppliedRecognition/Ver-ID-Flutter.git'
                    ref: 'my_custom_branch or tag'
        ~~~


1. If your app includes the iOS platform, please be patient as we are working on finalizing iOS support at this point in time.
4. If your app includes the Android platform:
    - Ensure your app targets Android API level 21 or newer. Open your Cordova project's **config.xml** file and add the following entry:
        
        ~~~xml
        <widget>
            <platform name="android">
                <preference name="android-minSdkVersion" value="21" />
            </platform>
        </widget>
        ~~~    
   
## Loading Ver-ID

Ver-ID must be loaded before you can run face detection sessions or compare faces.

The load operation may take up to a few of seconds. Load Ver-ID using the `load` call:

~~~dart
    VerID result;
    // Platform messages may fail, so we use a try/catch with the PlatformException
    try {
      //platformVersion = await Veridflutterplugin.platformVersion;
      result = await Veridflutterplugin
          .load(); //.load('efe89f85-b71f-422b-a068-605c3f62603b');
      pluginProcessResult = "VerID instance loaded successfully.";
    } on PlatformException catch (ex) {
      pluginProcessResult = 'Platform Exception: ' + ex.message.toString();
      developer.log(ex.message.toString());
    }
~~~

## Register and Authenticate User From Flutter
The Ver-ID Person plugin module will be available in your script from the import class VerID.  The rest of the support classes can be imported from the main package via the route package:veridflutterplugin/src/ :

~~~dart
  //method for user registration
  Future<SessionResult> registerUser(String userId) async {
    if (verID != null) {
      RegistrationSessionSettings settings =
          new RegistrationSessionSettings(userId: userId);
      settings.showResult = true;
      return VerID.register(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }
  
  Future<SessionResult> registerUser(String userId) async {
    if (verID != null) {
      RegistrationSessionSettings settings =
          new RegistrationSessionSettings(userId: userId);
      settings.showResult = true;
      return VerID.register(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }
~~~


### Liveness Detection

In a liveness detection session the user is asked to assume a series of random poses in front of the camera.

Liveness detection sessions follow the same format as registration and authentication.

## Extracting faces for face comparison

~~~dart
Future<SessionResult> captureLiveFace() async {
    if (verID != null) {
      LivenessDetectionSessionSettings settings =
          new LivenessDetectionSessionSettings();
      return VerID.captureLiveFace(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }
~~~

## Face detection session without asking for poses

~~~dart
Future<SessionResult> captureLiveFace() async {
    if (verID != null) {
      LivenessDetectionSessionSettings settings =
          new LivenessDetectionSessionSettings();
      return VerID.captureLiveFace(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }
~~~

## Session Response Format
The callback of a successful session will contain [an object](https://appliedrecognition.github.io/Ver-ID-Person-Cordova-Plugin/classes/_ver_id_.sessionresult.html) that represents the result of the session.

## Comparing Faces

~~~dart
Future<FaceComparisonResult> compareFaces(Face face1, Face face2) async {
    if (verID != null) {
      return VerID.compareFaces(face1: face1, face2: face2);
    } else {
      throw verIdNotInitialized;
    }
  }
~~~

## Detecting Faces In Images

~~~dart
Future<Face> detectFaceInImage(String imageData) async {
    if (verID != null) {
      return VerID.detectFaceInImage(image: imageData);
    } else {
      throw verIdNotInitialized;
    }
  }
~~~

## Project Samples
Project samples can be found on the samples branch of this repository, to be used as a reference for development purposes.

## Module API Reference
- [Ver-ID](https://appliedrecognition.github.io/Ver-ID-Person-Cordova-Plugin/modules/_ver_id_.html)
