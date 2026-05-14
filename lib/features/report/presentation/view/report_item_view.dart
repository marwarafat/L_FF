import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/report_bloc.dart';
import '../bloc/report_event.dart';
import '../bloc/report_state.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/di/service_locator.dart';

class ReportItemView extends StatelessWidget {
  const ReportItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReportBloc>()..add(LoadCategories()),
      child: const _ReportItemBody(),
    );
  }
}

class _ReportItemBody extends StatefulWidget {
  const _ReportItemBody();

  @override
  State<_ReportItemBody> createState() => _ReportItemBodyState();
}

class _ReportItemBodyState extends State<_ReportItemBody> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null && context.mounted) {
      context.read<ReportBloc>().add(SetImage(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.reportSubmittedSuccess),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: false,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: AppColors.black,
              ),
            ),
            title: Text(
              l10n.reportItemTitle,
              style: const TextStyle(
                fontFamily: 'AbhayaLibre',
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLostFoundToggle(context, state),

                  if (state.isLost != null) ...[
                    const SizedBox(height: 20),
                    _buildItemPeopleToggle(context, state),
                  ],

                  if (state.isLost != null && state.isItemSelected != null) ...[
                    const SizedBox(height: 25),
                    _buildForm(context, state),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Lost / Found toggle ────────────────────────────────────────────────────
  Widget _buildLostFoundToggle(BuildContext context, ReportState state) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<ReportBloc>().add(SetLostFound(true)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: state.isLost == true
                    ? AppColors.danger
                    : AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  l10n.iLostItem,
                  style: const TextStyle(
                    fontFamily: 'AbhayaLibre',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<ReportBloc>().add(SetLostFound(false)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: state.isLost == false
                    ? AppColors.success
                    : AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  l10n.iFoundItem,
                  style: const TextStyle(
                    fontFamily: 'AbhayaLibre',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Item / People toggle ───────────────────────────────────────────────────
  Widget _buildItemPeopleToggle(BuildContext context, ReportState state) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<ReportBloc>().add(SetItemPeople(true)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: state.isItemSelected == true
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  l10n.item,
                  style: const TextStyle(
                    fontFamily: 'AbhayaLibre',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => context.read<ReportBloc>().add(SetItemPeople(false)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: state.isItemSelected == false
                    ? AppColors.primary
                    : AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  l10n.people,
                  style: const TextStyle(
                    fontFamily: 'AbhayaLibre',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Main form ──────────────────────────────────────────────────────────────
  Widget _buildForm(BuildContext context, ReportState state) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── SubCategory Dropdown (from API) ───────────────────────────
        _label(state.isItemSelected == true ? l10n.itemType : l10n.personType),
        const SizedBox(height: 6),
        state.categoriesLoading
            ? const Center(child: CircularProgressIndicator())
            : DropdownButtonFormField<int>(
                decoration: _inputDecoration(hintText: l10n.selectCategory),
                value: state.selectedSubCategoryId,
                dropdownColor: Colors.white,
                iconEnabledColor: AppColors.black,
                iconSize: 35,
                style: const TextStyle(color: AppColors.black),
                items: state.filteredSubCategories
                    .map(
                      (c) => DropdownMenuItem<int>(
                        value: c.subCategoryId,
                        child: Text(
                          c.subCategory,
                          style: const TextStyle(
                            fontFamily: 'AbhayaLibre',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val == null) return;
                  final selected = state.filteredSubCategories.firstWhere(
                    (c) => c.subCategoryId == val,
                  );
                  context.read<ReportBloc>().add(
                    SelectSubCategory(
                      subCategoryId: selected.subCategoryId,
                      subCategoryName: selected.subCategory,
                    ),
                  );
                },
              ),
        const SizedBox(height: 16),

        // ── Description ───────────────────────────────────────────────
        _label(l10n.description),
        const SizedBox(height: 6),
        TextFormField(
          controller: _descController,
          maxLines: 4,
          onChanged: (v) => context.read<ReportBloc>().add(SetDescription(v)),
          decoration: _inputDecoration(hintText: l10n.describeItemHint),
          validator: (v) => (v == null || v.trim().length < 10)
              ? l10n.descriptionValidation
              : null,
        ),
        const SizedBox(height: 6),
        Text(
          l10n.includeIdentifiersWarning,
          style: const TextStyle(
            fontFamily: 'AbhayaLibre',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 16),

        // ── Date ──────────────────────────────────────────────────────
        _label(state.isLost == true ? l10n.dateLost : l10n.dateFound),
        const SizedBox(height: 6),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(
            text: state.selectedDate != null
                ? DateFormat('dd/MM/yyyy').format(state.selectedDate!)
                : '',
          ),
          decoration: _inputDecoration(
            hintText: l10n.dateFormat,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/icons/calendar_date_light.png',
                width: 24,
                height: 24,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/icons/calendar_date_light.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            );
            if (picked != null && context.mounted) {
              context.read<ReportBloc>().add(SelectDate(picked));
            }
          },
        ),
        const SizedBox(height: 16),

        // ── Location ──────────────────────────────────────────────────
        _label(l10n.location),
        const SizedBox(height: 6),
        TextFormField(
          controller: _locationController,
          onChanged: (v) => context.read<ReportBloc>().add(SetLocation(v)),
          decoration: _inputDecoration(
            hintText: state.isLost == true
                ? l10n.whereLostHint
                : l10n.whereFoundHint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/icons/location_outline.png',
                width: 24,
                height: 24,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // ── Map placeholder ───────────────────────────────────────────
        _label(l10n.putLocationOnMap),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/location_outline.png',
                  width: 50,
                  height: 50,
                  color: state.isLost == true
                      ? AppColors.dangerLight
                      : AppColors.success,
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.tapToSelectLocation,
                  style: const TextStyle(
                    fontFamily: 'AbhayaLibre',
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Photos ────────────────────────────────────────────────────
        _label(l10n.addPhotos),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            height: state.imagePath != null ? 200 : 125,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textSecondary),
            ),
            child: state.imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      state.imagePath!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.file_upload_outlined,
                        size: 35,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.clickToUploadPhotos,
                        style: const TextStyle(
                          fontFamily: 'AbhayaLibre',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.photoFormatWarning,
                        style: const TextStyle(
                          fontFamily: 'AbhayaLibre',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 20),

        // ── Submit button ─────────────────────────────────────────────
        CustomButton(
          text: l10n.submitReport,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ReportBloc>().add(SubmitReport());
            }
          },
          isLoading: state.isSubmitting,
          backgroundColor: AppColors.primaryDark,
          height: 50,
          fontSize: 18,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'AbhayaLibre',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.black,
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.textSecondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}
