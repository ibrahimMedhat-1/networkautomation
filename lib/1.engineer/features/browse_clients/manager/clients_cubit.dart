import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkautomation/models/user_model.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit() : super(ClientsInitial());
  static ClientsCubit get(context) => BlocProvider.of(context);
  List<UserModel> clients = [];
  void getAllClients() {
    emit(GetAllClientsLoading());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        clients.add(UserModel.fromJson(element.data()));

      }
      emit(GetAllClientsSuccessfully());
    }).catchError((onError) {
      emit(GetAllClientsError());
      print(onError);
    });
  }





}
