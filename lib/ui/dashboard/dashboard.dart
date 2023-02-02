import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/services/auth_data_service.dart';

class Dashboard extends ConsumerStatefulWidget {
  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final AuthService _authService = locator<AuthService>();
  String name = '';
  @override
  void initState() {
    name = _authService.user!.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CustomScrollWidget(
        child: Scaffold(
            body: Column(
          children: [
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.hamburger,
                      color: AppColors.primaryColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
            verticalSpace(20),
            CustomText(
              'Hi, $name',
              textType: TextType.largeText,
            ),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    height: eqH(150),
                    width: eqW(200),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.delivery_dining),
                        verticalSpace(5),
                        const CustomText('Send item')
                      ],
                    ),
                  ),
                ),
                horizontalSpace(20),
                InkWell(
                  child: Container(
                    height: eqH(150),
                    width: eqW(200),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.food_bank),
                        verticalSpace(5),
                        const CustomText('Food')
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
