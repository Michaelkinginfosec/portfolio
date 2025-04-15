import 'dart:js_interop';

import 'package:flutter/material.dart';

import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/datasource/models/project_models.dart';

@JS('window.open')
external JSAny? openWindow(JSString url, JSString target);

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.projectModel});

  final ProjectModel projectModel;

  void openLink(String url) {
    openWindow(url.toJS, '_blank'.toJS);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 290,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColor.bgLight2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            projectModel.image,
            width: 260,
            height: 140,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
            child: Text(
              projectModel.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColor.whitePrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              projectModel.subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: CustomColor.whiteSecondary,
              ),
            ),
          ),
          const Spacer(),
          Container(
            color: CustomColor.bgLight1,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const Text(
                  'Available on:',
                  style: TextStyle(
                    color: CustomColor.yellowSecondary,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                if (projectModel.androidLink != null)
                  InkWell(
                    onTap: () {
                      openLink(projectModel.androidLink!);
                    },
                    child: Image.asset(
                      projectModel.androidLink!,
                      width: 17,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                if (projectModel.iosLink != null)
                  InkWell(
                    onTap: () {
                      openLink(projectModel.iosLink!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Image.asset(
                        projectModel.iosLink!,
                        width: 19,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                  ),
                if (projectModel.webLink != null)
                  InkWell(
                    onTap: () {
                      openLink(projectModel.webLink!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Image.asset(
                        projectModel.webLink!,
                        width: 17,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                  ),

                if (projectModel.githubLink != null)
                  InkWell(
                    onTap: () {
                      openLink(projectModel.githubLink!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Image.asset(
                        'assets/images/world-globe-line-icon.png',
                        width: 17,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
