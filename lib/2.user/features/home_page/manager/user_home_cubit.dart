import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/constants.dart';

part 'user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  UserHomeCubit() : super(UserHomeInitial());

  static UserHomeCubit get(context) => BlocProvider.of(context);

  TextEditingController computersController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController desksController = TextEditingController();
  TextEditingController buissnessTitleController = TextEditingController();

  String? pdfUrl;

  void listenToStepsChanges() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        int steps = snapshot.get('steps');
        String price = snapshot.get('price').toString();
        Constants.userModel!.steps = steps;
        Constants.userModel!.price = price;

        emit(StepsUpdated(steps));
      }
    });
  }

  void initialize() {
    computersController.text = Constants.userModel!.computers!;
    floorsController.text = Constants.userModel!.floors!;
    roomsController.text = Constants.userModel!.rooms!;
    desksController.text = Constants.userModel!.desks!;
    buissnessTitleController.text = Constants.userModel!.buisnessTitle!;
    pdfUrl = Constants.userModel?.fileURl;

    // Listen to steps changes when initialized
    listenToStepsChanges();
  }

  void uploadData() async {
    await FirebaseFirestore.instance.collection('users').doc(Constants.userModel!.id).update({
      "steps": 1,
      "computers": computersController.text,
      "desks": desksController.text,
      "floors": floorsController.text,
      "rooms": roomsController.text,
      "buisnessTitle": buissnessTitleController.text,
    }).then((value) {
      // Emit a new state after data is uploaded
      emit(UploadData());
    });
  }
}
