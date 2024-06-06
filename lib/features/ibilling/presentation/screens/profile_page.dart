import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_billing/features/ibilling/domain/enteties/user.dart';
import 'package:i_billing/features/ibilling/presentation/bloc/ibilling_bloc/ibilling_bloc.dart';
import 'package:i_billing/features/ibilling/presentation/widgets/shimmer_contract_card.dart';
import 'package:i_billing/generated/locale_keys.g.dart';

import '../widgets/custom_language_change.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<IbillingBloc>(context)
        .add(const GetUserInfo('abd.ofokov@gmail.com'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          BlocBuilder<IbillingBloc, IbillingState>(
            builder: (context, state) {
              if (state is Initial) {
                return Center(
                  child: Text('gyhujioklp;'),
                );
              } else if (state is Loading) {
                print('LOAAAAAAAAAAAAAAAAADIIIIING');
                return ShimmerContractsCard();
              } else if (state is LoadedUserInfo) {
                print('SUCESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
                return DisplayUserInfo(user: state.user);
              } else if (state is Erorr) {
                print(state.message);
                Container(
                  color: Colors.white,
                  width: 400,
                  height: 200,
                );
              }
              return Container(color: Colors.pink);
            },
          ),
          const SizedBox(height: 12),
          const CustomLanguageChange(),
        ],
      ),
    );
  }
}

class DisplayUserInfo extends StatelessWidget {
  final User user;
  const DisplayUserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Color(0xff00A795),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff00A795),
                      ),
                    ),
                    Text(
                      user.profession,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffE7E7E7),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: LocaleKeys.date_of_birth.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      height: 2.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "${user.dateOfBirth}\n",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: LocaleKeys.phone_number.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      height: 2.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "${user.phoneNumber}\n",
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: 'E-mail: ',
                    style: TextStyle(
                      color: Colors.white,
                      height: 2.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: user.email,
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
