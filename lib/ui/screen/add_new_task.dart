import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app_using_getx/ui/controller/add_new_task_controller.dart';
import 'package:task_manager_app_using_getx/ui/widget/background_widget.dart';
import 'package:task_manager_app_using_getx/ui/widget/profile_app_bar.dart';
import '../widget/center_progress_indicator.dart';
import '../widget/snackbar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AddNewTaskController>(
                      builder: (addNewTaskController) {
                    return Visibility(
                      visible:
                          addNewTaskController.addNewTaskInProgress == false,
                      replacement: const CenterProgressIndicator(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _addNewTask();
                            }
                          },
                          child: const Text('Add')),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }

  Future<void> _addNewTask() async {
    final AddNewTaskController addTaskController =
        Get.find<AddNewTaskController>();
    bool success = await addTaskController.addNewTask(
      _titleTEController.text.trim(),
      _descriptionTEController.text.trim(),
    );
    if (success) {
      _clearTextFields();
      Get.back();
    } else {
      showSnackbarMessage(context, addTaskController.errorMessage);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
