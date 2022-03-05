part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class SaveProfileEvent extends ProfileEvent {
  final User user;

  SaveProfileEvent({required this.user});
}

class ChangeAvatarEvent extends ProfileEvent {
  final User user;
  final String imagePath;

  ChangeAvatarEvent({required this.user, required this.imagePath});
}
