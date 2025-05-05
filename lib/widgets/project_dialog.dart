import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/project/project_bloc.dart';
import 'package:portfolio/bloc/project/project_event.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/datasource/models/project_models.dart';
import 'package:portfolio/widgets/custom_text_field.dart';

class ProjectDialog extends StatefulWidget {
  const ProjectDialog({super.key});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final Map<String, TextEditingController> linkControllers = {
    'GitHub': TextEditingController(),
    'Website': TextEditingController(),
    'App Store': TextEditingController(),
    'Play Store': TextEditingController(),
  };

  String selectedType = 'hobby';
  PlatformFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColor.scaffoldBg,
      title: const Text(
        'Add Project',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedType,
              dropdownColor: CustomColor.bgLight1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items:
                  ['hobby', 'work']
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
              onChanged: (val) {
                if (val != null) setState(() => selectedType = val);
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(controller: titleController, hintText: 'Title'),
            const SizedBox(height: 5),
            CustomTextField(
              controller: subTitleController,
              hintText: 'Subtitle',
              maxLine: 5,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false,
                  withData: true,
                );
                if (result != null && result.files.isNotEmpty) {
                  setState(() => pickedImage = result.files.first);
                }
              },
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CustomColor.yellowPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image),
                    const SizedBox(width: 5),
                    Text(
                      pickedImage != null
                          ? 'Image Selected'
                          : 'Pick Project Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children:
                  linkControllers.entries
                      .expand(
                        (entry) => [
                          CustomTextField(
                            controller: entry.value,
                            hintText: "${entry.key} link (Optional)",
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                      .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: CustomColor.yellowSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text.trim();
            final subTitle = subTitleController.text.trim();

            if (title.isEmpty || subTitle.isEmpty || pickedImage == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please fill all required fields"),
                ),
              );
              return;
            }

            final model = ProjectModel(
              image: '',
              imageFile: pickedImage,
              title: title,
              subTitle: subTitle,
              githubLink: linkControllers['GitHub']?.text,
              webLink: linkControllers['Website']?.text,
              iosLink: linkControllers['App Store']?.text,
              androidLink: linkControllers['Play Store']?.text,
            );

            context.read<ProjectBloc>().add(
              AddProjectEvent(model, selectedType),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.yellowSecondary,
          ),
          child: const Text(
            'Add',
            style: TextStyle(color: CustomColor.whitePrimary),
          ),
        ),
      ],
    );
  }
}
