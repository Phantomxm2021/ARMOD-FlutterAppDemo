import 'dart:async';

import 'package:armod_flutter_store/src/model/data.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_armod_widget/flutter_armod_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
        '{"EngineType":"Native","dashboardConfig":{"dashboardGateway":"https://weacw.com/api/v1/getarexperience","token":"eyJhbGciOiJIUzUxMiIsImlhdCI6MTYxODgyMDQ0NSwiZXhwIjoxMDI1ODgyMDQ0NX0.eyJwYWNrYWdlaWQiOiJjb20uY2VsbHN0dWRpby5hcmxpYnJhcnkiLCJ1c2VyX3VpZCI6LTF9.tUEyJ32Z0QHPrGoYEs51d_2q6LnXAQTyinwX4p7Zi192mGJDDZ4whwNX_E-f8rITuXA39tK5u6UVq7A_8D7c7w","timeout":30,"maximumDownloadSize":30},"imageCloudRecognizerConfig":{"gateway":"","maximumOfRetries":5,"frequencyOfScan":5}}');

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
