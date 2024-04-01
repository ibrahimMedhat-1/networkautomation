import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/shared/constants.dart';

part 'form_state.dart';

class FormWidgetCubit extends Cubit<FormWidgetState> {
  FormWidgetCubit() : super(FormInitial());
  static FormWidgetCubit get(context) => BlocProvider.of(context);
  TextEditingController computersController = TextEditingController();
  TextEditingController floorsController = TextEditingController();
  TextEditingController roomsController = TextEditingController();
  TextEditingController desksController = TextEditingController();
  TextEditingController buissnessTitleController = TextEditingController();
  bool isDataAvailable = false;

  void initialize() {
    computersController.text = Constants.userModel!.computers!;
    floorsController.text = Constants.userModel!.floors!;
    roomsController.text = Constants.userModel!.rooms!;
    desksController.text = Constants.userModel!.desks!;
    buissnessTitleController.text = Constants.userModel!.buisnessTitle!;
  }

  void uploadData()async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userModel!.id)
        .update({
      "steps":0,
      "computers":computersController.text,
      "desks":desksController.text,
      "floors":floorsController.text,
      "rooms":roomsController.text,
      "buisnessTitle":buissnessTitleController.text,

    })
        .then((value) {
      emit(UploadData());
    });

  }


}
