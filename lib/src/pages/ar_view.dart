import 'dart:async';

import 'package:armod_flutter_store/src/model/data.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_armod_widget/flutter_armod_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';

import '../config/phantomsxrConfig.dart';

class ARView extends StatefulWidget {
  ARView({Key? key}) : super(key: key);

  @override
  ARViewState createState() => ARViewState();
}

class ARViewState extends State<ARView> {
  late ARMODWidgetController _armodWidgetController;
  bool _onWillPop = false;
  bool _isClosedByBack = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
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
            await _onBackPressed();
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        body: Card(
             margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child:       Stack(
          children: [
            ARMODWidget(
              onARMODCreated: onARMODCreate,
              onARMODExit: onARMODExit,
              onARMODLaunch: onARMODLaunch,
              onAddLoadingOverlay: onAddLoadingOverlay,
              onDeviceNotSupport: onDeviceNotSupport,
              onNeedInstallARCoreService: onNeedInstallARCoreService,
              onOpenBuiltInBrowser: onOpenBuiltInBrowser,
              onPackageSizeMoreThanPresetSize: onPackageSizeMoreThanPresetSize,
              onRecognitionComplete: onRecognitionComplete,
              onRecognitionStart: onRecognitionStart,
              onRemoveLoadingOverlay: onRemoveLoadingOverlay,
              onSdkInitialized: onSdkInitialized,
              onThrowException: onThrowException,
              onTryAcquireInformation: onTryAcquireInformation,
              onUpdateLoadingProgress: onUpdateLoadingProgress,
              useAndroidViewSurface: false,
            ),
            _appBar()
          ],
        ),
        )
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
    _isClosedByBack = true;
    return _onWillPop;
  }

  showAlertDialog(BuildContext context, String title, String msg, bool close) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () async {
        if (close) {
          //Dismiss loading ui
          EasyLoading.dismiss();

          //Dismiss alert
          Navigator.of(context, rootNavigator: true).pop();

          //Dismiss view
          await _onBackPressed();
        }
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
      barrierDismissible: false,
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
    //Set the app orientation
    var orientationId =
        MediaQuery.of(context).orientation == Orientation.portrait ? '1' : '2';
    _armodWidgetController.setDeivcesOrientation(orientationId);

    //Init XRMOD Engine
    _armodWidgetController.initARMOD(
        '{"EngineType":"Native","dashboardConfig":{"dashboardGateway":"https://phantomsxr.cn/api/v2/getarresources","token":"${PhantomsXRConfig.AppToken}","timeout":30,"maximumDownloadSize":30},"imageCloudRecognizerConfig":{"gateway":"","maximumOfRetries":5,"frequencyOfScan":5}}');

    //Fetch the data from XRMOD Cloud
    _armodWidgetController.fetchProject(AppData.ar_experience_uid);
  }

  void onThrowException(String errorMsg, int erorCode) {
    EasyLoading.dismiss();
    showAlertDialog(context, "(Error:$erorCode)", errorMsg, true);
  }

  void onARMODExit() {
    //Wait to release all asset
    _onWillPop = true;
    //Close by AR-Experiences
    if (!_isClosedByBack) Navigator.of(context).pop(true);
  }

  void onUpdateLoadingProgress(progress) {
    print("Load progress:$progress");
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
    print("onRemoveLoadingOverlay");
    EasyLoading.dismiss();
  }

  void onDeviceNotSupport() {
    showAlertDialog(
        context,
        "Device Not Supported",
        "Your device is not supoorted! \n Will downgrade to normal version",
        false);
  }

  void onRecognitionStart() {}

  void onNeedInstallARCoreService() {
    showAlertDialog(context, "ARCore Service Need",
        "You need to install the ARCore service!", false);
  }

  void onSdkInitialized() {
    print("\nSdkInitialized\n");
  }

  void onOpenBuiltInBrowser(url) {}

  void onPackageSizeMoreThanPresetSize(currentSize, presetSize) {}

  void onRecognitionComplete() {}
}
