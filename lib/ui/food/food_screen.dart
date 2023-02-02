import 'package:flutter/material.dart';
import 'package:send_me/_lib.dart';
import 'package:send_me/constants/helpers.dart';
import 'package:send_me/utils/mixins/ui_tool_mixin.dart';
import 'notifier/food_vm.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with UIToolMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScrollWidget(
      child: Consumer(builder: (context, watch, _) {
        final vm = watch.watch(foodVm);
        return Scaffold(
            backgroundColor: AppColors.white,
            body: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    const BackButton(),
                    verticalSpace(20),
                    const CustomText(
                      'Foods',
                      textType: TextType.largeText,
                    ),
                    verticalSpace(20),
                    verticalSpace(eqH(20)),
                    GridView.builder(
                      itemCount: vm.food.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.2,
                          mainAxisSpacing: eqH(30),
                          crossAxisSpacing: eqW(20),
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                            onTap: () {
                              showToast('coming soon');
                            },
                            child: Container(
                              height: eqH(150),
                              width: eqW(200),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.black12,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Icon(Icons.food_bank),
                                  verticalSpace(5),
                                  const CustomText('Food')
                                ],
                              ),
                            ));
                      },
                    ),
                  ]),
            ));
      }),
    );
  }
}
