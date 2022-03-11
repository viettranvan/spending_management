part of 'finger_printer_bloc.dart';

@immutable
abstract class FingerPrinterEvent {}

class FetchData extends FingerPrinterEvent{}

class EnableFinger extends FingerPrinterEvent{}

class DisableFinger extends FingerPrinterEvent{}