import 'package:armod_flutter_store/src/model/general_experience_detail.dart';
import 'package:flutter/material.dart';
import 'package:armod_flutter_store/src/model/data.dart';
import 'package:armod_flutter_store/src/themes/light_color.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:armod_flutter_store/src/widgets/title_text.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class ARExperienceDetailPage extends StatefulWidget {
  ARExperienceDetailPage({Key? key}) : super(key: key);
  @override
  _ARExperienceDetailPageState createState() => _ARExperienceDetailPageState();
}

class _ARExperienceDetailPageState extends State<ARExperienceDetailPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late GeneralExperenceDetail generalExperience;
  bool hasData = false;
  bool luanched_ar = false;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    startToPullRecommand();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    hasData = false;
  }

  bool isLiked = true;
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
                  child:
                      Icon(Icons.arrow_back, color: Colors.black54, size: 20),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pop(true);
          },
        ));
  }

  void startToPullRecommand() async {
    generalExperience = await queryGeneralExperenceDetail();
    setState(() {
      hasData = true;
    });
  }

  ///Get all showcases
  Future<GeneralExperenceDetail> queryGeneralExperenceDetail() async {
    var result = await Utils.queryPhantomCloud('getarexperience',"POST",
        {"project_id": AppData.seleted_project_id.toString()});
    return GeneralExperenceDetail.fromJson(result['data']);
  }

  Widget _arExperienceImage() {
    return AnimatedBuilder(
        builder: (context, child) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: animation.value,
            child: child,
          );
        },
        animation: animation,
        child: Container(
          width: AppTheme.fullWidth(context),
          height: AppTheme.fullHeight(context) * 0.5,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(generalExperience.project_header ?? ""),
                  fit: BoxFit.cover)),
        ));
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .6,
      minChildSize: .6,
      builder: (context, scrollController) {
        return Container(
            padding: AppTheme.padding.copyWith(bottom: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: LightColor.iconColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TitleText(
                              text: generalExperience.project_name ?? "",
                              fontSize: 25),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _description(),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "描述",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(generalExperience.project_description ?? ""),
      ],
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {
        if (luanched_ar) return;
        luanched_ar = true;
        AppData.ar_experience_uid =
            generalExperience.project_id.toString();
        Navigator.of(context).pushNamed("/ar_view");
        luanched_ar = false;
      },
      child: Container(
        width: 60,
        height: 60,
        child: Icon(Icons.view_in_ar,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                LinearGradient(colors: [Color(0xFFCE9FFC), Color(0xFF7367F0)])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Fix status bar not display
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
        floatingActionButton: _flotingButton(),
        body: SafeArea(
          top: false,
          child: hasData
              ? Stack(
                  children: [
                    _arExperienceImage(),
                    _detailWidget(),
                    _appBar(),
                  ],
                )
              : Stack(children: <Widget>[
                  Column(children: <Widget>[_appBar()])
                ]),
        ));
  }
}
