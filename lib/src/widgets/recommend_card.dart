import 'package:armod_flutter_store/src/model/data.dart';
import 'package:armod_flutter_store/src/model/recommand_experience.dart';
import 'package:armod_flutter_store/src/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:armod_flutter_store/src/themes/light_color.dart';
import 'package:armod_flutter_store/src/widgets/title_text.dart';

class RecommandCard extends StatelessWidget {
  final RecommandARExperience recommandItem;
  final ValueChanged<RecommandARExperience>? onSelected;
  RecommandCard({Key? key, required this.recommandItem, this.onSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AppData.seleted_showcase_uid = recommandItem.showcase_uid!;
          Navigator.of(context).pushNamed('/detail');
          if (onSelected != null) onSelected!(recommandItem);
        },
        child: Container(
            padding: EdgeInsets.only(right: 8),
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: recommandItem.showcase_name!,
                  fontSize: 20,
                ),
                SubTitleText(
                  text: recommandItem.showcase_brief!,
                  fontSize: 12,
                  color: LightColor.grey,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(recommandItem.showcase_header!),
                        fit: BoxFit.cover),
                    color: LightColor.background,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color(0xfff8f8f8),
                          blurRadius: 5,
                          spreadRadius: 2),
                    ],
                  ),
                )
              ],
            )));
  }
}
