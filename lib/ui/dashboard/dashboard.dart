import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/core/model/booking_model.dart';
import 'package:send_me/core/repository/auth_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import 'package:send_me/ui/dashboard/notifier/dashboard_vm.dart';
import 'package:send_me/ui/dashboard/view_more_info.dart';
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
      child: Scaffold(
          body: SafeArea(
        bottom: false,
        child: CustomScrollWidget(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.menu,
                          color: AppColors.black,
                        )),
                    InkWell(
                        onTap: () => signOut(),
                        child: const Icon(
                          Icons.logout,
                          color: AppColors.primaryColor,
                        ))
                  ],
                ),
                verticalSpace(20),
                RichText(
                    text: TextSpan(
                        text: "Hi, ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                      TextSpan(
                        text: name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      )
                    ])),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () =>
                          navigationService.navigateTo(sendItemViewRoute),
                      child: Container(
                        height: eqH(150),
                        width: eqW(160),
                        decoration: BoxDecoration(
                          color: AppColors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.delivery_dining),
                            verticalSpace(5),
                            const CustomText('Send item')
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => navigationService.navigateTo(carsViewRoute),
                      child: Container(
                        height: eqH(150),
                        width: eqW(160),
                        decoration: BoxDecoration(
                          color: AppColors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.car_rental),
                            verticalSpace(5),
                            const CustomText('Cars')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                const CustomText(
                  'Orders',
                  textType: TextType.largeText,
                  fontWeight: FontWeight.bold,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: ref.watch(dashboardVm).getMyOrders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                        appPrint('it has error');
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: screenHeight * 0.4,
                                child: const Center(
                                  child: CustomText(
                                    'You have no orders',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        return SizedBox(
                          height: screenHeight * 0.65,
                          width: screenWidth,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            padding: const EdgeInsets.only(top: 8),
                            itemBuilder: (context, i) {
                              var id = snapshot.data!.docs[i].id;
                              BookingModel _data = BookingModel.fromJson(
                                  snapshot.data!.docs[i].data());
                              return CustomOrderTile(
                                data: _data,
                                index: i,
                                listLength: snapshot.data!.docs.length,
                                onTap: () => slideUpdialogshow(
                                    ViewMoreInfo(data: _data, docsId: id),
                                    con: context),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        appPrint('it has error');
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                height: screenHeight * 0.4,
                                child: const Center(
                                  child: CustomText(
                                    'Error fetching Orders',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Screenloader(3);
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
