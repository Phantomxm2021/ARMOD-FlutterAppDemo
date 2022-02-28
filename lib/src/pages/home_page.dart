import 'package:armod_flutter_store/src/model/general_experience.dart';
import 'package:armod_flutter_store/src/widgets/column_builder.dart';

import 'package:armod_flutter_store/src/model/recommand_experience.dart';
import 'package:armod_flutter_store/src/widgets/experience_card.dart';
import 'package:armod_flutter_store/src/widgets/recommend_card.dart';
import 'package:flutter/material.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'dart:async';
import '../utils.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  late List<RecommandARExperienceProject> recommandARExperienceProject = [];
  late List<GeneralV2Experence> generalV2Experience = [];
  ScrollController _scrollController = ScrollController();
  int page_num = 1;
  int page_size = 10;
  bool isLoadMoreData = false;

  @override
  void initState() {
    super.initState();
    startToPullRecommand();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent + 200 &&
          !isLoadMoreData) {
        isLoadMoreData = true;

        var tmp_NextPageNum = page_num + 1;
        var tmp_AdditionData = await queryV2GeneralExperence(tmp_NextPageNum);
        if (tmp_AdditionData.length > 0) {
          generalV2Experience.addAll(tmp_AdditionData);
          page_num = tmp_NextPageNum;
        }
        isLoadMoreData = false;
        setState(() {});
      }
    });
  }

  void startToPullRecommand() async {
    recommandARExperienceProject = await queryV2Recommand();
    generalV2Experience = await queryV2GeneralExperence(page_num);
    setState(() {});
  }

  void _onItemFocus(int index) {}

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
        child: RecommandCard(
      recommandItem: recommandARExperienceProject[index],
    ));
  }

  // final PageController controller = PageController(initialPage: 0);
  Widget _recommandWidget() {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 10),
            width: AppTheme.fullWidth(context),
            height: AppTheme.fullHeight(context) * 0.34,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: ScrollSnapList(
                // margin: EdgeInsets.only(top: 5),
                onItemFocus: _onItemFocus,
                itemSize: 340,
                itemBuilder: _buildListItem,
                itemCount: recommandARExperienceProject.length,
                key: sslKey,
              ),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
      ],
    );
  }

  Widget _buildGeneralExperience(BuildContext context, int index) {
    return ExperienceCard(generalExperienceItem: generalV2Experience[index]);
  }

  void _onGeneralARExperienceFocus(int index) {
    setState(() {});
  }

  Widget _allARexperiences() {
    // return SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   child: ColumnBuilder(
    //       focusToItem: _onGeneralARExperienceFocus,
    //       itemBuilder: _buildGeneralExperience,
    //       itemCount: generalV2Experience.length),
    //   controller: _scrollController,
    // );
    return ColumnBuilder(
        focusToItem: _onGeneralARExperienceFocus,
        itemBuilder: _buildGeneralExperience,
        itemCount: generalV2Experience.length);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _recommandWidget(),
              _allARexperiences(),
            ],
          ),
          controller: _scrollController,
        ),
        onRefresh: _onRefresh);
  }

  Future<Null> _onRefresh() async {
    recommandARExperienceProject.clear();
    generalV2Experience.clear();
    startToPullRecommand();
    // setState(() {
    //   isLoading = true;
    // });
  }

  Future<Null> _loadMore() async {
    recommandARExperienceProject.clear();
    generalV2Experience.clear();
    startToPullRecommand();
    // setState(() {
    //   isLoading = true;
    // });
  }

  Future<List<RecommandARExperienceProject>> queryV2Recommand() async {
    var result = await Utils.queryPhantomCloud("getrecommendslist", null);
    List<dynamic> recommandItems = result['data'];
    List<RecommandARExperienceProject> recommandARExperiences = [];
    for (var idx = 0; idx < recommandItems.length; idx++) {
      recommandARExperiences
          .add(RecommandARExperienceProject.fromJson(recommandItems[idx]));
    }
    return recommandARExperiences;
  }

  Future<List<GeneralV2Experence>> queryV2GeneralExperence(
      int _nextPage) async {
    var result = await Utils.getARExperienceProjects(
        'getarexperiencelist', _nextPage, page_size);
    List<dynamic> generalItems = result['data'] ?? null;
    List<GeneralV2Experence> generalExperences = [];
    for (var idx = 0; idx < generalItems.length; idx++) {
      generalExperences.add(GeneralV2Experence.fromJson(generalItems[idx]));
    }
    return generalExperences;
  }
}
