import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../../utils/helper.dart';
import '../../widgets/dialog_confirm.dart';
import 'how_it_works_screen.dart';
import 'widgets/contact_us_sheet.dart';
import 'widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const Avatar(
                //   size: 70,
                //   url: '',
                //   name: '',
                //   color: Colors.white,
                //   shape: BoxShape.circle,
                //   borderRadius: null,
                // ),
                // const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (userBloc.profile.name ?? 'NA').toCapitalized(),
                            style: textTheme.titleMedium!.copyWith(
                              color: MyColors.accentColor1,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.editProfile.setId(
                                  userBloc.profile.id.toString(),
                                ),
                              );
                            },
                            child: Text(
                              'Edit',
                              style: textTheme.titleSmall!.copyWith(
                                color: MyColors.accentColor1,
                                fontSize: 11,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        userBloc.profile.email ?? 'NA',
                        style: textTheme.titleSmall!.copyWith(
                          color: MyColors.accentColor1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userBloc.profile.mobile ?? 'NA',
                        style: textTheme.titleSmall!.copyWith(
                          color: MyColors.accentColor1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ProfileWidget(
            onTap: () {
              Navigator.pushNamed(context, Routes.profileDetails);
            },
            title: 'My Profile',
            image: Images.my_profile,
          ),
          // ProfileWidget(
          //   onTap: () {},
          //   title: 'My Dashboard',
          //   image: Images.my_dashboard,
          // ),
          ProfileWidget(
            onTap: () {
              Navigator.pushNamed(context, Routes.myMonthlyEvents);
            },
            title: 'My Events',
            image: Images.my_events,
          ),
          // ProfileWidget(
          //   onTap: () {},
          //   title: 'My Payments',
          //   image: Images.my_payments,
          // ),
          ProfileWidget(
            onTap: () {
              Navigator.pushNamed(context, Routes.dueList);
            },
            title: 'My Duelist',
            image: Images.my_duelist,
          ),
          ProfileWidget(
            onTap: () {
              HowItWorksScreen.open(
                context,
                url: 'https://www.youtube.com/watch?v=ZBCUegTZF7M',
              );
            },
            title: 'How it works',
            image: Images.how_it_works,
          ),
          ProfileWidget(
            onTap: () => ContactUsSheet.open(context),
            title: 'Contact us',
            image: Images.contact_us,
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
            // const SizedBox(height: 20),
            // OutlinedButton.icon(
            //   onPressed: () {},
            //   icon: Image.asset(Images.delete_account),
            //   label: Text(
            //     'Delete Account',
            //     style: textTheme.bodySmall!.copyWith(color: MyColors.red),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
