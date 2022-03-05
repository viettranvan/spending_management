import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spending_management/UI/auth/sign_in/view/sign_in_page.dart';
import 'package:spending_management/UI/profile_page/bloc/profile_bloc.dart';

import '../../../components/components.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../change_password/view/change_password_page.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    var bloc = BlocProvider.of<ProfileBloc>(context);

    void onLogOut() async {
      try {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            title: 'Đăng xuất',
            content: 'Bạn có muốn đăng xuất?',
            onSubmit: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const LoadingDialog());

              await AuthService().signOut();

              await AuthService().signOut();
              await HelperSharedPreferences.saveUid('');
              await HelperSharedPreferences.saveToken('');
              await HelperSharedPreferences.saveExpirationTime(-1);
              await HelperSharedPreferences.saveLogin(false);
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInPage.id, (route) => false);
            },
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void onUpdateProfile() {
      showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const LoadingDialog());
      if (_auth.currentUser != null) {
        BlocProvider.of<ProfileBloc>(context)
            .add(SaveProfileEvent(user: _auth.currentUser!));
      }
    }

    Future pickImage() async {
      try {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) {
          return;
        }
        if (_auth.currentUser != null) {
          BlocProvider.of<ProfileBloc>(context).add(ChangeAvatarEvent(
              imagePath: image.path, user: _auth.currentUser!));
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const LoadingDialog());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void gotoChangePassword(BuildContext context) {
      Navigator.of(context).pushNamed(ChangePasswordPage.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile', style: kTextSize28w500White),
        actions: [
          GestureDetector(
            onTap: onLogOut,
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.logout, size: 30.0, color: AppColor.white),
            ),
          )
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case SaveProfileSuccess:
                        // close loading dialog
                        Navigator.of(context).maybePop();
                        Future.delayed(Duration.zero).then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Cập nhật thông tin thành công!',
                                style: kTextSize18w400White),
                            backgroundColor: AppColor.background,
                          ));
                        });
                        return const SizedBox();
                      case SaveProfileFailure:
                        // close loading dialog
                        Navigator.of(context).maybePop();
                        Future.delayed(Duration.zero).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                (state as SaveProfileFailure).errorText,
                                style: kTextSize18w400White),
                            backgroundColor: AppColor.background,
                          ));
                        });
                        return const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: AppColor.blur),
                      borderRadius: BorderRadius.circular(150.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is UploadAvatarSuccess) {
                            Navigator.of(context).maybePop();
                            Future.delayed(Duration.zero).then((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Upload Avatar thành công!',
                                    style: kTextSize18w400White),
                                backgroundColor: AppColor.background,
                              ));
                            });
                          }
                          return FadeInImage(
                            placeholder: const AssetImage(
                              'assets/images/image_placeholder.gif',
                            ),
                            image: NetworkImage(_auth.currentUser == null
                                ? noProfileImage
                                : _auth.currentUser?.photoURL ??
                                    noProfileImage),
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: 150.0,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => pickImage(),
                  child: const Center(
                    child: Text(
                      'Edit Photo',
                      style: kTextSize15w400Blue,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text('Họ tên', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  controller: bloc.nameController,
                  hintText: 'Name',
                ),
                const SizedBox(height: 10.0),
                const Text('Email', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                    controller: bloc.emailController, enabled: false),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: onUpdateProfile,
                  buttonTitle: 'Cập nhật thông tin',
                  buttonColor: AppColor.red,
                ),
                const SizedBox(height: 10.0),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) => ReusableButton(
                    onTap: () => gotoChangePassword(context),
                    buttonTitle: 'Đổi mật khẩu',
                    buttonColor: AppColor.green,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
