# Ver-ID Person Plugin for Flutter

## Introduction

Ver-ID gives your users the ability to authenticate using their face.

## Compatibility 

The Ver-ID plugin has been tested to work with Flutter against the following compatibility matrix for iOS and Android.  Please note that the SDK versions of the corresponding OSes are for compilation purposes (target iOS version on iOS and compile SDK version on Android):

| Flutter Version   | iOS       | Android   |
|-----------------  |-------    |---------  |
| 1.20.4 (stable)   | 13+       | SDK 17+   |


Other combinations may work, but your mileage may vary.  Be sure to run the unit test suite in the example of the plugin to make sure the mobile OS platform combination you are using works before proceeding.

## Adding Ver-ID Person Plugin to Your Flutter App

1. [Request a License File and password](https://dev.ver-id.com/admin/register) for your app.
1. Clone the plugin Git repo into your file system, specify the git repository, or install using the Cordova CLI.  


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
          verid_flutter_plugin: '>=0.1.0'
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


1. If your app includes iOS platform, please be patient as we are working on finalizing iOS support at this point in time.
4. If your app includes Android platform:
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


### Face detection session without asking for poses

### Liveness detection session defining the bearings (poses) the user may be asked to assume

## Session Response Format

## Comparing Faces

## Detecting Faces In Images

## Project Samples

## Module API Reference

