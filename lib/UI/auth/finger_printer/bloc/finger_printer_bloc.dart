import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:spending_management/services/shared_preferences.dart';

part 'finger_printer_event.dart';
part 'finger_printer_state.dart';

class FingerPrinterBloc extends Bloc<FingerPrinterEvent, FingerPrinterState> {
  FingerPrinterBloc() : super(FingerPrinterInitial()) {
    on<EnableFinger>(_enableFinger);
    on<DisableFinger>(_disableFinger);
    on<FetchData>(_onFetchData);
  }

  _enableFinger(EnableFinger event, Emitter<FingerPrinterState> emit) async {
    var currentState = state;
    if (currentState is FingerPrinterInitial) {
      emit(currentState.update(enable: true));
    }
  }

  _disableFinger(DisableFinger event, Emitter<FingerPrinterState> emit) async {
    var currentState = state;
    if (currentState is FingerPrinterInitial) {
      await HelperSharedPreferences.saveIsFingerPrinterLogin(false);
      await HelperSharedPreferences.saveEmail('');
      await HelperSharedPreferences.savePassword('');
      emit(currentState.update(enable: false));
    }
  }

  _onFetchData(FetchData event, Emitter<FingerPrinterState> emit) async {
    try {
      bool? enable = await HelperSharedPreferences.getIsFingerPrinterLogin();
      var currentState = state;
      if (currentState is FingerPrinterInitial) {
        emit(currentState.update(enable: enable));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
