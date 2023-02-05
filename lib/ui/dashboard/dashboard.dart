import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/booking_model.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/ui/dashboard/notifier/dashboard_vm.dart';
import 'package:send_me/utils/mixins/ui_tool_mixin.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> with UIToolMixin {
  final AuthService _authService = locator<AuthService>();
  final AuthRepo _authRepo = locator<AuthRepo>();
  String name = '';
  @override
  void initState() {
    name = _authService.user!.displayName!;
    super.initState();
  }

  signOut() async {
    await _authRepo.signOut();
    navigationService.navigateReplacementTo(loginViewRoute);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CustomScrollWidget(
        physics: const NeverScrollableScrollPhysics(),
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
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: AppColors.buttonPurple,
                        )),
                    horizontalSpace(10),
                    IconButton(
                        onPressed: () => signOut(),
                        icon: const Icon(
                          Icons.logout,
                          color: AppColors.primaryColor,
                        )),
                  ],
                )
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
                  onTap: () => navigationService.navigateTo(sendItemViewRoute),
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
                  onTap: () => navigationService.navigateTo(carsViewRoute),
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
                        const CustomText('Cars')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            const CustomText(
              'Orders',
              textType: TextType.mediumText,
            ),
            verticalSpace(5),
            StreamBuilder<QuerySnapshot>(
                stream: ref.watch(dashboardVm).getMyOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    appPrint('it has error');
                    return Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CustomText(
                                'You have no Appointmnet records',
                              ),
                            ],
                          )),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      padding: const EdgeInsets.only(top: 8),
                      itemBuilder: (context, i) {
                        var id = snapshot.data!.docs[i].id;
                        BookingModel _data = BookingModel.fromJson(
                            snapshot.data!.docs[i].data());
                        appPrint(_data.bookingDate.toString());
                        return CustomOrderTile(
                          data: _data,
                          onDelete: () =>
                              ref.watch(dashboardVm).deleteOrder(id: id),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    appPrint('it has error');
                    return Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 200,
                                child: CustomText(
                                  'Error fetching Data',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                    );
                  } else {
                    return const Screenloader(3);
                  }
                })
          ],
        )),
      ),
    );
  }
}
