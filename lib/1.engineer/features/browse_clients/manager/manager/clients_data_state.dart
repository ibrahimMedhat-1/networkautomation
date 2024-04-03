part of 'clients_data_cubit.dart';

@immutable
sealed class ClientsDataState {}

final class ClientsDataInitial extends ClientsDataState {}
final class UploadData extends ClientsDataState {}
final class UploadfileLoading extends ClientsDataState {}
final class UploadfileSuccess extends ClientsDataState {}
final class UploadfileFail extends ClientsDataState {}
