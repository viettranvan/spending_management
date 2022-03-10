import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/models/home_spending.dart';

part 'edit_spending_event.dart';
part 'edit_spending_state.dart';

class EditSpendingBloc extends Bloc<EditSpendingEvent, EditSpendingState> {
  final moneyController = TextEditingController();
  final noteController = TextEditingController();
  EditSpendingBloc() : super(EditSpendingInitial()) {
    on<FetchedData>(_onFetchData);
  }

  _onFetchData(FetchedData event, Emitter<EditSpendingState> emit) async {
    try {
      final _auth = FirebaseAuth.instance;
      var spending = FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('spending');
      var response = await spending.doc(event.itemId).get();

      String datetime =
              '${DateTime.parse(response.data()?['date'].toDate().toString() ?? DateTime.now().toString())}';
          String date = datetime.substring(0, 11);

      HomeSpending homeSpending = HomeSpending(
        id: response.data()?['id'],
        date: date,
        money: response.data()?['money'],
        note: response.data()?['note'],
        type: response.data()?['type'],
        typeItem: response.data()?['type_item'],
        iconPath: response.data()?['icon_path'],
      );
      emit(DataLoaded(homeSpending: homeSpending));
    } catch (_) {}
  }
}
