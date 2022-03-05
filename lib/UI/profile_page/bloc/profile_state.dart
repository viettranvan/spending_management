part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class SaveProfileSuccess extends ProfileState{}

class UploadAvatarSuccess extends ProfileState{}

class SaveProfileFailure extends ProfileState{
  final String errorText;
   SaveProfileFailure({required this.errorText});
}
