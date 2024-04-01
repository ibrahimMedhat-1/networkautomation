part of 'user_home_cubit.dart';

@immutable
sealed class UserHomeState {}

final class UserHomeInitial extends UserHomeState {}
final class UploadData extends UserHomeState {}
