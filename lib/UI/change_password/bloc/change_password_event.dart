part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}



class SaveProfileEvent extends ChangePasswordEvent {
  final User user;
  final String name;

  SaveProfileEvent({required this.user, required this.name});
}

class CheckErrorEvent extends ChangePasswordEvent{
  final User? user;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  CheckErrorEvent({
    required this.user,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class OnChangePasswordEvent extends ChangePasswordEvent {
  final String newPassword;
  final User? user;

  OnChangePasswordEvent({required this.user,required this.newPassword});
}
