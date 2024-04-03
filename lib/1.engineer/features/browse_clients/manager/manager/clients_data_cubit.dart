
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'clients_data_state.dart';

class ClientsDataCubit extends Cubit<ClientsDataState> {
  ClientsDataCubit() : super(ClientsDataInitial());

  static ClientsDataCubit get(context) => BlocProvider.of(context);
  String? _fileName;
  bool isUploading = false;

  void setStep(String id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      "steps": 2,
    }).then((value) {
      emit(UploadData());
    });
  }

  Future<void> pickAndUploadPdf(String userId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _fileName = result.files.single.name;
      isUploading = true;
      emit(UploadfileLoading());
      await FirebaseFirestore.instance.collection("users")
          .doc(userId)
          .update({
        "steps":3
      });

      Uint8List? fileBytes = result.files.single.bytes;
      if (fileBytes != null) {
        try {
          await uploadPdfToFirebase(fileBytes,userId);

          isUploading = false;
          emit(UploadfileSuccess());
        } catch (e) {
          isUploading = false;
          emit(UploadfileFail());
        }
      }
    }
  }

  Future<void> uploadPdfToFirebase(Uint8List fileBytes,String userId) async {
    String fileName = 'pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    await ref.putData(fileBytes);
    String downloadURL = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection("users")
    .doc(userId)
    .update({
      "fileURl":downloadURL,
      "steps":4
    });

  }
}
