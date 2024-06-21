import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clients_data_state.dart';

class ClientsDataCubit extends Cubit<ClientsDataState> {
  ClientsDataCubit() : super(ClientsDataInitial());

  static ClientsDataCubit get(context) => BlocProvider.of(context);
  String _fileName = '';
  bool isUploading = false;
  bool isLoading = false;
  TextEditingController priceController = TextEditingController();
  Future<void> setStep(BuildContext context, String id) async {
    isLoading = true;
    emit(UploadData());

    await FirebaseFirestore.instance.collection('users').doc(id).update({
      "steps": 2,
      "price": int.parse(priceController.text),
    }).then((value) {
      emit(UploadData());
      isLoading = false;
    });
  }

  Future<void> pickAndUploadPdf(String userId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'zip'],
    );

    if (result != null) {
      _fileName = result.files.single.name;
      isUploading = true;
      emit(UploadfileLoading());
      await FirebaseFirestore.instance.collection("users").doc(userId).update({"steps": 3});

      Uint8List? fileBytes = result.files.single.bytes;
      if (fileBytes != null) {
        try {
          await uploadPdfToFirebase(fileBytes, userId, _fileName);

          isUploading = false;
          emit(UploadfileSuccess());
        } catch (e) {
          isUploading = false;
          emit(UploadfileFail());
        }
      }
    }
  }

  Future<void> uploadPdfToFirebase(Uint8List fileBytes, String userId, String fileName) async {
    print(fileName);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    await ref.putData(fileBytes);
    String downloadURL = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection("users").doc(userId).update({"fileURl": downloadURL, "steps": 4});
  }
}
