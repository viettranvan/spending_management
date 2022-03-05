import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial()) {
    emailController.text = _auth.currentUser?.email ?? 'email';
    nameController.text = _auth.currentUser?.displayName ?? '';
    on<SaveProfileEvent>(_saveProfileEvent);
    on<ChangeAvatarEvent>(_onChangeAvatarEvent);
  }
  Future<void> _saveProfileEvent(
      SaveProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      if (nameController.text.isEmpty) {
        emit(SaveProfileFailure(errorText: 'Vui lòng nhập tên'));
      } else {
        await event.user.updateDisplayName(nameController.text);
        emit(SaveProfileSuccess());
      }
    } catch (e) {
      emit(
          SaveProfileFailure(errorText: 'Cập nhật thông tin không thành công'));
      debugPrint(e.toString());
    }
  }

  _onChangeAvatarEvent(
      ChangeAvatarEvent event, Emitter<ProfileState> emit) async {
    try {
      String url = await getUrlImage(event.imagePath);
      await event.user.updatePhotoURL(
          url);
      emit(UploadAvatarSuccess());
    } catch (_) {
      emit(SaveProfileFailure(errorText: 'Upload avatar thất bại!'));
    }
  }

  Future<String> getUrlImage(String? imagePath) async {
    String filename = basename(imagePath ?? "");
    Reference storageReference = FirebaseStorage.instance.ref().child(filename);
    final UploadTask uploadTask = storageReference.putFile(File(imagePath!));
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    nameController.dispose();

    return super.close();
  }
}
