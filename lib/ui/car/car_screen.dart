import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/utils/mixins/ui_tool_mixin.dart';
import 'notifier/car_vm.dart';

class CarScreen extends ConsumerStatefulWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends ConsumerState<CarScreen> with UIToolMixin {
  final ScrollController _controller = ScrollController();
  final _formKey = GlobalKey<FormState>();
  int crossAxisCount = 2;

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.extentAfter < 100 &&
          ref.read(carVm).fetchMore!) {
        ref.read(carVm.notifier).getMoreCars();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final vm = ref.watch(carVm);
      final carIndex = ref.watch(selectedCarIndex.state).state;
      return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: CustomScrollWidget(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        InkWell(
                          onTap: () => navigationService.pop(),
                          child: const Icon(
                            FontAwesomeIcons.chevronLeft,
                            size: 20,
                            color: AppColors.black,
                          ),
                        ),
                        verticalSpace(20),
                        const CustomText(
                          'Cars',
                          textType: TextType.bigText,
                          fontWeight: FontWeight.bold,
                        ),
                        verticalSpace(eqH(20)),
                        SizedBox(
                          height: screenHeight * 0.8,
                          child: Builder(builder: (co) {
                            if (vm.viewState.isLoading) {
                              return AnimationLimiter(
                                child: GridView.count(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  children: List.generate(
                                    9,
                                    (int index) {
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: crossAxisCount,
                                        child: const ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: LoaderWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else if (vm.viewState.isError) {
                              return RefreshWidget(
                                onPressed: () =>
                                    ref.read(carVm.notifier).getCars(),
                              );
                            } else {
                              return AnimationLimiter(
                                child: GridView.builder(
                                  itemCount: vm.cars.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 10),
                                  // physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          crossAxisCount: crossAxisCount),
                                  itemBuilder: (BuildContext context, int i) {
                                    return AnimationConfiguration.staggeredGrid(
                                        position: i,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: crossAxisCount,
                                        child: ScaleAnimation(
                                            child: FadeInAnimation(
                                          child: GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(selectedCarIndex
                                                        .notifier)
                                                    .state = i;
                                                showToast('coming soon');
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: eqW(20),
                                                    vertical: 30),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                      color: carIndex == i
                                                          ? AppColors
                                                              .primaryColor
                                                          : AppColors.grey),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      color: Colors.black12,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // CacheNetworkImage(
                                                    //   imgUrl: vm
                                                    //       .cars[i]
                                                    //       .imagesCloudinaryIds!
                                                    //       .last,
                                                    //   height: eqH(50),
                                                    //   width: eqW(50),
                                                    // ),
                                                    verticalSpace(5),
                                                    CustomText(
                                                        '${vm.cars[i].brand}'),
                                                    verticalSpace(5),
                                                    CustomText(
                                                        '${vm.cars[i].model}'),
                                                    verticalSpace(5),
                                                    CustomText(
                                                        '${vm.cars[i].year}')
                                                  ],
                                                ),
                                              )),
                                        )));
                                  },
                                ),
                              );
                            }
                          }),
                        ),
                        verticalSpace(20),
                        vm.gettingMore!
                            ? AnimationLimiter(
                                child: GridView.count(
                                  crossAxisCount: crossAxisCount,
                                  children: List.generate(
                                    3,
                                    (int index) {
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: crossAxisCount,
                                        child: const ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: LoaderWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : verticalSpace(0)
                      ]),
                ),
              ),
            ),
          ));
    });
  }
}
