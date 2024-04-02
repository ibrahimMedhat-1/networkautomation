import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/2.user/features/home_page/view/home_page_view.dart';
import 'package:networkautomation/models/eng_model.dart';
import 'package:networkautomation/shared/constants.dart';


part 'user_layout_state.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(UserLayoutInitial());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  void getEngineer() {
    FirebaseFirestore.instance
        .collection("engineers")
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var engineerData = snapshot.docs[0].data();
        if (engineerData is Map<String, dynamic>) {
          Constants.engModel = EngModel.fromJson(engineerData);
        } else {
          print("Invalid engineer data format");
        }
      }
    }).catchError((error) {
      print("Error getting engineer data: $error");
    });
  }

  List<Widget> pages =  [
    const UserHomePage(),

  ];
  int page = 0;

  void changePage(page) {
    this.page = page;
    emit(ChangePage());
  }
}
