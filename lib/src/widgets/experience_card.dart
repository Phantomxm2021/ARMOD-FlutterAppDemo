import 'package:armod_flutter_store/src/model/data.dart';
import 'package:armod_flutter_store/src/model/general_experience.dart';
import 'package:armod_flutter_store/src/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

import 'package:armod_flutter_store/src/themes/light_color.dart';
import 'package:armod_flutter_store/src/widgets/title_text.dart';

class ExperienceCard extends StatelessWidget {
  final GeneralExperence? generalExperienceItem;
  final ValueChanged<GeneralExperence>? onSelected;
  ExperienceCard({Key? key, this.generalExperienceItem, this.onSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AppData.seleted_showcase_uid = generalExperienceItem!.showcase_uid!;
          Navigator.of(context).pushNamed('/detail');
          if (onSelected != null) onSelected!(generalExperienceItem!);
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(generalExperienceItem!.showcase_icon!),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: generalExperienceItem!.showcase_name!,
                        fontSize: 20,
                      ),
                      SubTitleText(
                        text: generalExperienceItem!.showcase_brief!,
                        fontSize: 12,
                        color: LightColor.grey,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 3),
                        // width: 250,
                        child: Divider(),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
