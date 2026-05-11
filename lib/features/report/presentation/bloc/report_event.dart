import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetLostFound extends ReportEvent {
  final bool isLost;
  SetLostFound(this.isLost);
  @override
  List<Object?> get props => [isLost];
}

class SetItemPeople extends ReportEvent {
  final bool isItemSelected;
  SetItemPeople(this.isItemSelected);
  @override
  List<Object?> get props => [isItemSelected];
}

class SelectItemType extends ReportEvent {
  final String value;
  SelectItemType(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectPeopleType extends ReportEvent {
  final String value;
  SelectPeopleType(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectDate extends ReportEvent {
  final DateTime date;
  SelectDate(this.date);
  @override
  List<Object?> get props => [date];
}

class SetImage extends ReportEvent {
  final String imagePath;
  SetImage(this.imagePath);
  @override
  List<Object?> get props => [imagePath];
}

class SetTitle extends ReportEvent {
  final String title;
  SetTitle(this.title);
  @override
  List<Object?> get props => [title];
}

class SetDescription extends ReportEvent {
  final String description;
  SetDescription(this.description);
  @override
  List<Object?> get props => [description];
}

class SetLocation extends ReportEvent {
  final String location;
  SetLocation(this.location);
  @override
  List<Object?> get props => [location];
}

class SelectSubCategory extends ReportEvent {
  final int subCategoryId;
  final String subCategoryName;
  SelectSubCategory({required this.subCategoryId, required this.subCategoryName});
  @override
  List<Object?> get props => [subCategoryId, subCategoryName];
}

/// Triggered on screen open to load categories from API
class LoadCategories extends ReportEvent {}

/// Triggered when user taps Submit
class SubmitReport extends ReportEvent {}