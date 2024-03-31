import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../model/profile.dart';
import '../../../utils/helper.dart';
import '../../widgets/error_snackbar.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/navbar_button.dart';
import '../../widgets/success_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final String id;

  const EditProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return FutureBuilder<Profile>(
      future: userBloc.getProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var user = snapshot.data!;
        return EditProfileBody(id: id, user: user);
      },
    );
  }
}

class EditProfileBody extends StatefulWidget {
  final Profile user;
  final String id;

  const EditProfileBody({super.key, required this.user, required this.id});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final studioCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final rePasswordCtrl = TextEditingController();
  bool showPassword = false;
  bool reShowPassword = false;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.user.name ?? 'NA';
    mobileCtrl.text = widget.user.mobile ?? 'NA';
    studioCtrl.text = widget.user.studio ?? 'NA';
    emailCtrl.text = widget.user.email ?? 'NA';
    addressCtrl.text = widget.user.address ?? 'NA';
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: mobileCtrl,
              keyboardType: TextInputType.number,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
              ),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: studioCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: textTheme.bodyLarge,
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Studio Name',
              ),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
              ],
              decoration: const InputDecoration(
                labelText: 'Email Id',
              ),
              validator: (text) {
                if (!text!.isValidEmail()) {
                  return 'Please check the email you entered';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: addressCtrl,
              maxLines: 4,
              keyboardType: TextInputType.text,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: newPassCtrl,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: const Color(0xFFFAFAFA),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
              ),
              obscureText: !showPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: rePasswordCtrl,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFFAFAFA),
                labelText: 'Re- Enter password',
                suffixIcon: IconButton(
                  icon: Icon(
                    reShowPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => reShowPassword = !reShowPassword),
                ),
              ),
              obscureText: !reShowPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          try {
            final navigator = Navigator.of(context);

            if (!(formKey.currentState?.validate() ?? true)) return;
            formKey.currentState?.save();

            if (mobileCtrl.text != '' && mobileCtrl.text.length != 10) {
              return ErrorSnackBar.show(
                context,
                'Please enter valid mobile number',
              );
            }
            if (newPassCtrl.text != rePasswordCtrl.text) {
              return ErrorSnackBar.show(
                context,
                'Password you entered should be same in both fields',
              );
            }

            Map<String, dynamic> body = {
              'name': nameCtrl.text,
              'mobile': mobileCtrl.text,
              'email': emailCtrl.text,
              'password': newPassCtrl.text,
              'studio': studioCtrl.text,
              'address': addressCtrl.text,
              'role': 'USER',
              'status': true
            };
            await userBloc.updateUser(id: widget.id, body: body);

            if (mounted) {
              SuccessScreen.open(
                context,
                text: 'Your details are updated successfully',
                onProcess: () {
                  navigator.pushNamedAndRemoveUntil(
                    Routes.main,
                    (route) => false,
                  );
                },
              );
            }
          } on Exception catch (e) {
            if (mounted) return ErrorSnackBar.show(context, e);
          }
        },
        child: const Text('Edit Profile'),
      ),
    );
  }
}
