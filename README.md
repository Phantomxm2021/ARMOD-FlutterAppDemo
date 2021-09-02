# ARMOD-FlutterAppDemo
Flutter AR-MOD widget for embedding AR features in flutter.

# flutter_armod_widget

Flutter AR-MOD widget for embedding AR features in flutter.

# What is the ARMOD SDK?
In short, [ARMOD's](https://docs.phantomsxr.com/) solution is an AR experience platform solution similar to Snapchat ([Lens Studio](https://lensstudio.snapchat.com/)) and Facebook ([SparkAR](https://sparkar.facebook.com/ar-studio/))!


AR-MOD is a derivative framework based on Unity ARFoundation. MOD in AR-MOD means Modification in English, meaning: modification and module. This concept is widely used in games, corresponding to modifiable video games. Famous games such as Warcraft, Red Alert, Half-Life, CS, Victory Day and more! 


We transplant the MOD concept into AR technology to give users more freedom to create the AR creative interactive experience content they need! In this process, users do not need to worry about AR-SDK algorithm and code implementation, but only need to devote themselves to the production of AR creative interactive experience content. With only a small amount of code, you can use all the capabilities of AR-MOD on the APP to create greater commercial value.

## Getting Started

1. Install this plugin to your flutter project. If you do not know how to install the `Flutter Package` you can [click here](https://flutter.dev/docs/development/packages-and-plugins/using-packages) to see the document.

2. Go to [PhantomsXR](https://github.com/Phantomxm2021/ARMOD-Framework) github respository. Download and Unzip it.

3. Go to the location of your `FLUTTER SDK PATH/.pub-cache/hosted/pub.dartlang.org/flutter_armod_widget-0.0.3/` folder, then paste the `libs` to `android` platform folder.

4. Create and write your app token to [PhantomsXRConfig.dart](lib/config/phantomsxrConfig.dart)

5. And write a new screen for AR-MOD

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
