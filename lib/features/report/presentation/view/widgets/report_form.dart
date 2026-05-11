import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/report_bloc.dart';
import '../../bloc/report_event.dart';
import '../../bloc/report_state.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/styles/app_colors.dart';

class ReportForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final List<String> itemTypes = [
    "Electronics",
    "Wallets",
    "Keys",
    "Bags",
    "Pets",
    "Other",
  ];
  final List<String> peopleTypes = [
    "Child",
    "Elderly",
    "Adult",
    "Special Needs",
  ];
  ReportForm({super.key, required this.formKey});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state.isItemSelected == null) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Type",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // 1. الـ Dropdown الديناميكي
            DropdownButtonFormField<String>(
              initialValue: state.isItemSelected == true
                  ? state.selectedItemType
                  : state.selectedPeopleType,
              hint: Text(
                state.isItemSelected == true
                    ? "Select Item Type"
                    : "Select Person Type",
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              items: (state.isItemSelected == true ? itemTypes : peopleTypes)
                  .map(
                    (type) => DropdownMenuItem(value: type, child: Text(type)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  state.isItemSelected == true
                      ? context.read<ReportBloc>().add(SelectItemType(value))
                      : context.read<ReportBloc>().add(SelectPeopleType(value));
                }
              },
              validator: (value) =>
                  value == null ? "Please select a type" : null,
            ),

            const SizedBox(height: 20),
            const Text(
              "Upload Image",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),

            // 2. الـ Image Picker UI
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  context.read<ReportBloc>().add(SetImage(image.path));
                }
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                  image: state.imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(state.imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: state.imagePath == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 40,
                            color: AppColors.primaryDark,
                          ),
                          Text(
                            "Click to upload photo",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // 3. الـ Date Picker
            ListTile(
              title: Text(
                state.selectedDate == null
                    ? "Select Date"
                    : "Date: ${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}",
              ),
              trailing: const Icon(
                Icons.calendar_month,
                color: AppColors.primaryDark,
              ),
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  context.read<ReportBloc>().add(SelectDate(picked));
                }
              },
            ),

            const SizedBox(height: 30),

            // 4. زرار الـ Submit
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Report Submitted Successfully!"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Submit Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
