part of 'form_cubit.dart';

@immutable
sealed class FormWidgetState {}

final class FormInitial extends FormWidgetState {}
final class UploadData extends FormWidgetState {}
