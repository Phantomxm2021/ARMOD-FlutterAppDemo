# ARMOD-Flutter App Demo
This repository is used to demonstrate how the AR-MOD SDK can be used in Flutter. 

## Getting Started


1. Install this plugin to your flutter project. If you do not know how to install the `Flutter Package` you can [click here](https://flutter.dev/docs/development/packages-and-plugins/using-packages) to see the document.

    <details>
      <summary>Install Guid</summary>

      The AR-MOD SDK currently provides a plug-in package for Flutter. You can install it through `flutter_armod_widget: ^0.0.3` in your flutter project `pubspec.yaml` !

      ```yaml
      # Other config
      dependencies:
        flutter:
          sdk: flutter
        flutter_armod_widget: ^0.0.3
      # Other config

      ```
    
    </details>


2. Go to [PhantomsXR](https://github.com/Phantomxm2021/ARMOD-Framework) github respository. Download and Unzip it.

3. Choose iOS or Android platform from the options below to set.

    <details>
    <summary>Android Setup</summary>

      1. Go to the location of your `FLUTTER SDK PATH/.pub-cache/hosted/pub.dartlang.org/flutter_armod_widget-0.0.3/` folder, then paste the `libs` to `android` platform folder.
      
      2. Run `Flutter pub get` command in your termial.

    </details>



    <details>
    <summary>iOS Setup</summary>

      1. Create the `ThirdParties` folder to your XCode project.

      2. Import `UnityFramework.framework` to the folder(ThridParties). 
      
      3. Add the Framewrok to Xcode -> Targets -> Your APP -> General -> Franework,Libraries, and Embedded Content area, And set the Embed mode to Embed & Sign.

      4. Execute the `cd iOS` command and run `Pod install` command in your termial.

      5. Double-Click to open the `Runner.xcworkspace` file. It will be launch the XCode app.

      6. If you're using Swift, open the *ios/Runner/AppDelegate.swift* file and change the following:

          ```diff
              import UIKit
              import Flutter
          +    import flutter_armod_widget

              @UIApplicationMain
              @objc class AppDelegate: FlutterAppDelegate {
                  override func application(
                      _ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
                  ) -> Bool {
          +            InitARMODIntegrationWithOptions(argc: CommandLine.argc, argv: CommandLine.unsafeArgv, launchOptions)

                      GeneratedPluginRegistrant.register(with: self)
                      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
                  }
              }
          ```

          > If you're using Objective-C, open the *ios/Runner/main.m* file and change the following:
          ```diff
          +    #import "flutter_armod_widget.swift.h"

              int main(int argc, char * argv[]) {
                    @autoreleasepool {
          +             InitARMODIntegration(argc, argv);
                        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
                    }
              }
          ```

      7. Edit the info.plist

          ```diff
              <dict>
          +        <key>io.flutter.embedded_views_preview</key>
          +        <string>YES</string>
              </dict>
          ```

          ```diff
              <dict>
          +        <key>Privacy - Camera Usage Description</key>
          +        <string>$(PRODUCT_NAME) uses Cameras</string>
              </dict>
          ```

          ```diff
              <dict>
          +       <key>NSBonjourServices</key>
          +       <string>_dartobservatory._tcp</string>
              </dict>
          ```
    </details>


4. Create and write your app token to [PhantomsXRConfig.dart](lib/src/config/phantomsxrConfig.dart).

5. And write a new screen for AR-MOD.

# Common mistakes
## iOS Error
- Q: ios/Flutter/Generated.xcconfig must exist.
  - A: Execute `Flutter run` command to generate the `Generated.xcconfig` file

- Q: CocoaPods could not find compatible versions for pod "flutter_armod_widget"
  - A: Find and replace the `platform :ios, '9.0'`  to `platform :ios, '11.0'` in the Podfile. Then Execute `Pod update` command to refresh your project.

## Example Code
```dart
import 'dart:async';

import 'package:armod_flutter_store/src/model/data.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_armod_widget/flutter_armod_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../config/phantomsxrConfig.dart';

class ARView extends StatefulWidget {
  ARView({Key? key}) : super(key: key);

  @override
  ARViewState createState() => ARViewState();
}

class ARViewState extends State<ARView> {
  late ARMODWidgetController _armodWidgetController;
  bool _onWillPop = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _appBar() {
    return SafeArea(
        top: true,
        child: GestureDetector(
          child: Container(
            padding: AppTheme.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Icon(Icons.close, color: Colors.black54, size: 20),
                )
              ],
            ),
          ),
          onTap: () async {
            bool willPop = await _onBackPressed();
            if (willPop) Navigator.of(context).pop(true);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        body: SafeArea(
            top: true,
            child: Stack(
              children: [
                ARMODWidget(
                  onARMODCreated: onARMODCreate,
                  onARMODExit: onARMODExit,
                  onARMODLaunch: onARMODLaunch,
                  onAddLoadingOverlay: onAddLoadingOverlay,
                  onDeviceNotSupport: onDeviceNotSupport,
                  onNeedInstallARCoreService: onNeedInstallARCoreService,
                  onOpenBuiltInBrowser: onOpenBuiltInBrowser,
                  onPackageSizeMoreThanPresetSize:
                      onPackageSizeMoreThanPresetSize,
                  onRecognitionComplete: onRecognitionComplete,
                  onRecognitionStart: onRecognitionStart,
                  onRemoveLoadingOverlay: onRemoveLoadingOverlay,
                  onSdkInitialized: onSdkInitialized,
                  onThrowException: onThrowException,
                  onTryAcquireInformation: onTryAcquireInformation,
                  onUpdateLoadingProgress: onUpdateLoadingProgress,
                  fullscreen: true,
                ),
                _appBar()
              ],
            )),
      ),
    );
  }

  ///Handling the back event
  Future<bool> _onBackPressed() async {
    //Close AR-MOD SDK
    _armodWidgetController.unloadAndHideARMOD();

    while (!_onWillPop) {
      //We need to delayed executed because release AR-MOD operation is async.
      //May need to wait one more frame
      await Future.delayed(Duration(milliseconds: 1));
    }

    return _onWillPop;
  }

  showAlertDialog(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> onARMODCreate(controller) async {
    this._armodWidgetController = controller;
    if (await _armodWidgetController.isLoaded() != false)
      _armodWidgetController.create();
  }

  void onARMODLaunch() {
    print("----------------------------");
    print("-------onARMODLaunch---------");
    print("----------------------------");
    _armodWidgetController.initARMOD(
        '{"EngineType":"Native","dashboardConfig":{"dashboardGateway":"https://weacw.com/api/v1/getarexperience","token":"${PhantomsXRConfig.AppToken}","timeout":30,"maximumDownloadSize":30},"imageCloudRecognizerConfig":{"gateway":"","maximumOfRetries":5,"frequencyOfScan":5}}');

    Future.delayed(Duration(milliseconds: 125),
        () => {_armodWidgetController.fetchProject(AppData.ar_experience_uid)});
  }

  void onThrowException(String errorMsg, int erorCode) {
    EasyLoading.dismiss();
    showAlertDialog(context, "(Error:$erorCode)", errorMsg);
  }

  void onARMODExit() {
    print("----------------------------");
    print("-------onARMODExit---------");
    print("----------------------------");
    _onWillPop = true;
  }

  void onUpdateLoadingProgress(progress) {
    EasyLoading.showProgress(progress,
        status: '${(progress * 100).toStringAsFixed(0)}%');
  }

  Future<String> onTryAcquireInformation(String opTag) async {
    await Future.delayed(Duration(seconds: 3));
    return "onTryAcquireInformation_$opTag";
  }

  void onAddLoadingOverlay() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..maskColor = Colors.red.withOpacity(0.5)
      ..dismissOnTap = false;
  }

  void onRemoveLoadingOverlay() {
    EasyLoading.dismiss();
  }

  void onDeviceNotSupport() {}

  void onRecognitionStart() {}

  void onNeedInstallARCoreService() {}

  void onSdkInitialized() {}

  void onOpenBuiltInBrowser(url) {}

  void onPackageSizeMoreThanPresetSize(currentSize, presetSize) {}

  void onRecognitionComplete() {}
}
```
