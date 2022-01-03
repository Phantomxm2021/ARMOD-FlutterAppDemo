import 'package:armod_flutter_store/src/model/general_experience.dart';
import 'package:armod_flutter_store/src/widgets/column_builder.dart';

import 'package:armod_flutter_store/src/model/recommand_experience.dart';
import 'package:armod_flutter_store/src/widgets/experience_card.dart';
import 'package:armod_flutter_store/src/widgets/recommend_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../utils.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  late List<RecommandARExperience> recommandARExperience = [];
  late List<GeneralExperence> generalExperience = [];

  @override
  void initState() {
    super.initState();
    startToPullRecommand();
  }

  void startToPullRecommand() async {
    recommandARExperience = await queryRecommand();
    generalExperience = await queryGeneralExperence();
    setState(() {});
  }

  void _onItemFocus(int index) {}

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 330,
        child: RecommandCard(
          recommandItem: recommandARExperience[index],
        ));
  }

  final PageController controller = PageController(initialPage: 0);
  Widget _recommandWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: AppTheme.fullWidth(context),
          height: AppTheme.fullHeight(context) * 0.38,
          child: ScrollSnapList(
            margin: EdgeInsets.symmetric(vertical: 5),
            onItemFocus: _onItemFocus,
            itemSize: 340,
            itemBuilder: _buildListItem,
            itemCount: recommandARExperience.length,
            key: sslKey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Divider(),
        ),
      ],
    );
  }

  Widget _buildGeneralExperience(BuildContext context, int index) {
    return ExperienceCard(generalExperienceItem: generalExperience[index]);
  }

  void _onGeneralARExperienceFocus(int index) {
    setState(() {});
  }

  Widget _allARexperiences() {
    return SingleChildScrollView(
        child: ColumnBuilder(
            focusToItem: _onGeneralARExperienceFocus,
            itemBuilder: _buildGeneralExperience,
            itemCount: generalExperience.length));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent.withOpacity(0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _recommandWidget(),
            _allARexperiences(),
          ],
        ),
      ),
    );
  }

  ///Used to get all recommended showcases of the current APP
  Future<List<RecommandARExperience>> queryRecommand() async {
    var result = await Utils.queryPhantomCloud("getshowcaserecommends", null);
    List<dynamic> recommandItems = result['data'];
    List<RecommandARExperience> recommandARExperiences = [];
    for (var idx = 0; idx < recommandItems.length; idx++) {
      recommandARExperiences
          .add(RecommandARExperience.fromJson(recommandItems[idx]));
    }
    return recommandARExperiences;
  }

  ///Get all showcases
  Future<List<GeneralExperence>> queryGeneralExperence() async {
    var result = await Utils.queryPhantomCloud('getshowcaselist', null);
    List<dynamic> generalItems = result['data'];
    List<GeneralExperence> generalExperences = [];
    for (var idx = 0; idx < generalItems.length; idx++) {
      generalExperences.add(GeneralExperence.fromJson(generalItems[idx]));
    }
    return generalExperences;
  }
}
