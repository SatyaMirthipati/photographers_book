import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../../utils/helper.dart';
import '../../widgets/dialog_confirm.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.accentColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Center(
                //   child: Avatar(
                //     size: 70,
                //     url: '',
                //     name: '',
                //     color: Colors.white,
                //     shape: BoxShape.circle,
                //     borderRadius: null,
                //   ),
                // ),
                // const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(Images.name, width: 12, height: 12),
                          const SizedBox(width: 12),
                          Text(
                            (userBloc.profile.name ?? 'NA').toCapitalized(),
                            style: textTheme.titleSmall!.copyWith(
                              color: MyColors.accentColor1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(Images.mail, width: 12, height: 12),
                          const SizedBox(width: 12),
                          Text(
                            userBloc.profile.email ?? 'NA',
                            style: textTheme.titleSmall!.copyWith(
                              color: MyColors.accentColor1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(Images.call, width: 12, height: 12),
                          const SizedBox(width: 12),
                          Text(
                            userBloc.profile.mobile ?? 'NA',
                            style: textTheme.titleSmall!.copyWith(
                              color: MyColors.accentColor1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(Images.cam, width: 12, height: 12),
                          const SizedBox(width: 12),
                          Text(
                            (userBloc.profile.studio ?? 'NA').toCapitalized(),
                            style: textTheme.titleSmall!.copyWith(
                              color: MyColors.accentColor1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            Images.address,
                            width: 12,
                            height: 12,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            userBloc.profile.address ?? 'NA',
                            style: textTheme.titleSmall!.copyWith(
                              color: MyColors.accentColor1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () async {
                final navigator = Navigator.of(context);
                var res = await ConfirmDialog.show(
                  context,
                  message: 'Are you sure you want to Logout',
                  title: 'Logout ?',
                );
                if (res != true) return;

                userBloc.logout();
                navigator.pushNamedAndRemoveUntil(
                  Routes.root,
                  (route) => false,
                );
              },
              icon: Image.asset(Images.logout),
              label: const Text('Logout'),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Image.asset(Images.delete_account),
              label: Text(
                'Delete Account',
                style: textTheme.bodySmall!.copyWith(color: MyColors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
