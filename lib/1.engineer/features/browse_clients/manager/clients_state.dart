part of 'clients_cubit.dart';

sealed class ClientsState {}

final class ClientsInitial extends ClientsState {}
final class GetAllClientsLoading extends ClientsState {}
final class GetAllClientsSuccessfully extends ClientsState {}
final class GetAllClientsError extends ClientsState {}
