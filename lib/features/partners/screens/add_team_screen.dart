import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eClassify/core/theme/pallete.dart';
import 'package:eClassify/features/jobs/screens/recuiter/recuiter_information_screen.dart';
import 'package:eClassify/features/partners/controller/partner_controller.dart';

class AddTeamScreen extends ConsumerStatefulWidget {
  const AddTeamScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends ConsumerState<AddTeamScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String _selectedItem = "Cleaner";

  // List of items in our dropdown menu
  var items = [
    'Cleaner',
    'Worker',
    'IT Worker',
    'Receptional Caller',
    'Security',
    'Advocate',
    'Financial Advisor',
    'Ad panel editor',
    'Management Manager',
  ];

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Pallete.borderColor,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your Team"),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ref.read(partnerControllerProvider.notifier).addTeams(
                      name: nameController.text.trim(),
                      number: int.parse(phoneController.text.trim()),
                      email: emailController.text.trim(),
                      ref: ref,
                      context: context,
                      department: _selectedItem,
                    );
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              InfoTextField(
                controller: nameController,
                title: "Add Name",
              ),
              const SizedBox(height: 10),
              InfoTextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                title: "Add Phone-Number",
              ),
              const SizedBox(height: 10),
              InfoTextField(
                controller: emailController,
                title: "Add Email",
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Department"),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          value: _selectedItem,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedItem = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Department',
                            labelStyle: TextStyle(color: Pallete.blackColor),
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                          items: items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
