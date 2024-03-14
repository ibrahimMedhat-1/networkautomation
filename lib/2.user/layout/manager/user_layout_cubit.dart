import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/2.user/features/home_page/view/home_page_view.dart';
import 'package:networkautomation/shared/features/chat/view/chat_page.dart';

part 'user_layout_state.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(UserLayoutInitial());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> pages = const [
    UserHomePage(),
    ChatPage(),
  ];
  int page = 0;

  void changePage(page) {
    this.page = page;
    emit(ChangePage());
  }
}
