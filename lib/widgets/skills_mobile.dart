import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/skills_item.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          for (int i = 0; i < platformItems.length; i++)
            Container(
              margin: EdgeInsets.only(bottom: 5),
              width: double.maxFinite,
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
                  platformItems[i]['img'],
                  width: 26,
                  color: CustomColor.whitePrimary,
                ),
                title: Text(platformItems[i]['title']),
              ),
            ),
          SizedBox(height: 50),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
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
        ],
      ),
    );
  }
}
