part of 'user_chat_cubit.dart';

@immutable
sealed class UserChatState {}

final class UserChatInitial extends UserChatState {}
final class GetAllMessagesSuccessfully extends UserChatState {}
