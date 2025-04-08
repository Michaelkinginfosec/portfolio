import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/skills_item.dart';

class SkillsDesktop extends StatelessWidget {
  const SkillsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (int i = 0; i < platformItems.length; i++)
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: CustomColor.bgLight2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    leading: Image.asset(
                      platformItems[i]["img"],
                      width: 25,
                      color: CustomColor.whitePrimary,
                    ),
                    title: Text(platformItems[i]["title"]),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 50),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 0; i < skillsItem.length; i++)
                  Chip(
                    backgroundColor: CustomColor.bgLight2,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    label: Text(skillsItem[i]['title']),
                    avatar: Image.asset(skillsItem[i]['img']),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
