import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:networkautomation/1.engineer/layout/view/layout.dart';
import 'package:networkautomation/models/eng_model.dart';
import 'package:networkautomation/shared/network/cached_preference.dart';

import '../../../../2.user/layout/view/layout.dart';
import '../../../../models/user_model.dart';
import '../../../constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController emailAddressSignUpController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordSignUpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool checkBoxValue = false;
  bool obscure = true;
  bool obscureSignUp = true;
  IconData suffixIcon = Icons.visibility_off;
  IconData suffixIconSignUp = Icons.visibility_off;

  void changeCheckBoxValue(value) {
    checkBoxValue = value;
    emit(ChangeCheckBoxValue());
  }

  void login(BuildContext context) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailAddressController.text.trim(), password: passwordController.text)
        .then((value) {
      if (checkBoxValue) {
        FirebaseFirestore.instance.collection('engineers').doc(value.user!.uid).get().then((value) async {
          Constants.engModel = EngModel.fromJson(value.data());
          if (value.data() != null) {
            emit(LoginSuccessfully());
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (builder) => const EngineerLayout()));
          } else {
            emit(LoginError());
            Fluttertoast.showToast(msg: 'Not an engineer ');
          }
        });
      } else {
        FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get().then((value) async {
          Constants.userModel = UserModel.fromJson(value.data());
          print(value.data());
          print(Constants.userModel!.steps);
          if (value.data() != null) {
            emit(LoginSuccessfully());
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const UserLayout()));
          } else {
            emit(LoginError());
            Fluttertoast.showToast(msg: 'Not a user');
          }
        });
      }
    }).catchError((onError) {
      emit(LoginError());
      Fluttertoast.showToast(msg: onError.message.toString());
    });
  }

  void signUp(BuildContext context) {
    emit(CreateUserLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailAddressSignUpController.text.trim(), password: passwordSignUpController.text)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(UserModel(
                  id: value.user!.uid,
                  name: nameController.text,
                  email: emailAddressSignUpController.text,
                  phoneNo: phoneController.text,
                  image: '',
                  price: '',
                  computers: '',
                  desks: '',
                  floors: '',
                  rooms: '',
                  buisnessTitle: '')
              .toMap())
          .then((value) {
        emit(CreateUserSuccessfully());
        Navigator.pop(context);
      }).catchError((onError) {
        emit(CreateUserError());
        Fluttertoast.showToast(msg: onError.message.toString());
      });
    }).catchError((onError) {
      emit(CreateUserError());
      Fluttertoast.showToast(msg: onError.message.toString());
    });
  }

  Future<void> cachingUser(DocumentSnapshot<Map<String, dynamic>> value, String userType) async {
    List<String> map = [];
    dynamic array = value.data().toString().split('');
    await array.removeAt(0);
    await array.removeLast();
    array = await array.join('');
    array = await array.split(',');
    await CacheHelper.setData(key: userType, value: (handlingMapResponse(array, map).toString()));
  }

  String handlingMapResponse(List array, List<String> map) {
    for (int i = 0; i < array.length; i++) {
      dynamic key = array[i].toString().trim().split(" ")[0].split("");
      var value = array[i].toString().trim().split(" ").last == array[i].toString().trim().split(" ")[0]
          ? ''
          : array[i].toString().trim().split(":").last.trim();
      debugPrint(array[i].toString().trim().split(":").last.trim());
      key.removeLast();
      key = key.join();
      map.add('"$key" : "$value",');
    }
    String last = (map.last.split('')..removeLast()).join();
    map
      ..removeLast()
      ..insert(map.length, last);
    debugPrint(map.join());
    return '{${map.join().toString()}}';
  }

  void suffixPressed() {
    obscure = !obscure;
    if (obscure) {
      suffixIcon = Icons.visibility_off;
      emit(ChangeObscure());
    } else {
      suffixIcon = Icons.visibility;
      emit(ChangeObscure());
    }
  }

  void suffixPressedSignUp() {
    obscureSignUp = !obscureSignUp;
    if (obscureSignUp) {
      suffixIconSignUp = Icons.visibility_off;
      emit(ChangeObscure());
    } else {
      suffixIconSignUp = Icons.visibility;
      emit(ChangeObscure());
    }
  }

  void clearTextFormFields() {
    emailAddressController.text = '';
    emailAddressSignUpController.text = '';
    passwordController.text = '';
    passwordSignUpController.text = '';
    emit(ClearAllTextFormFields());
  }
}
