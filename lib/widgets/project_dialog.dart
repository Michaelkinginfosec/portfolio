import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/widgets/custom_text_field.dart';

class ProjectDialog extends StatefulWidget {
  const ProjectDialog({super.key});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final Map<String, TextEditingController> linkControllers = {
    'GitHub': TextEditingController(),
    'Website': TextEditingController(),
    'App Store': TextEditingController(),
    'Play Store': TextEditingController(),
  };
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
            SizedBox(height: 40, child: CustomTextField(hintText: 'Title')),
            SizedBox(height: 5),
            CustomTextField(hintText: 'Subtitle', maxLine: 5),

            const SizedBox(height: 10),

            InkWell(
              onTap: () async {
                try {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowMultiple: false,
                    withData: true, // important for web!
                  );
                  if (result != null && result.files.isNotEmpty) {
                    setState(() => pickedImage = result.files.first);
                    print("Picked: ${pickedImage!.name}");
                  } else {
                    print("User canceled the picker.");
                  }
                } catch (e) {
                  print("FilePicker error: $e");
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
                    SizedBox(width: 5),
                    Text(
                      'Pick Project Image',
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
                          const SizedBox(height: 15),
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
            style: TextStyle(
              color: CustomColor.yellowSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.yellowSecondary,
          ),
          child: const Text(
            'Add',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: CustomColor.whitePrimary,
            ),
          ),
        ),
      ],
    );
  }
}
