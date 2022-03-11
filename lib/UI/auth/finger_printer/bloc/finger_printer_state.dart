part of 'finger_printer_bloc.dart';

@immutable
abstract class FingerPrinterState {}

class FingerPrinterInitial extends FingerPrinterState {
  final bool? enable;
   FingerPrinterInitial({this.enable});

   FingerPrinterInitial update({bool? enable}){
     return FingerPrinterInitial(
       enable: enable ?? this.enable
     );
   }
}




