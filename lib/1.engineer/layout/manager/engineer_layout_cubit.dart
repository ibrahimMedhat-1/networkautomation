import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/1.engineer/features/browse_clients/view/browse_clients.dart';

part 'engineer_layout_state.dart';

class EngineerLayoutCubit extends Cubit<EngineerLayoutState> {
  EngineerLayoutCubit() : super(EngineerLayoutInitial());
  static EngineerLayoutCubit get(context) => BlocProvider.of(context);
  List<Widget> pages = const [
    EngineerHomePage(),
  ];
  int page = 0;
  void changePage(page) {
    this.page = page;
    emit(ChangeEngineerLayoutPage());
  }
}
