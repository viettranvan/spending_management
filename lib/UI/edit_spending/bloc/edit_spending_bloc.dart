import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'edit_spending_event.dart';
part 'edit_spending_state.dart';

class EditSpendingBloc extends Bloc<EditSpendingEvent, EditSpendingState> {
  final moneyController = TextEditingController();
  final noteController = TextEditingController();
  EditSpendingBloc() : super(EditSpendingInitial()) {
    on<EditSpendingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
