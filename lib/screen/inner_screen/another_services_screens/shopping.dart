import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/another_services_cubit/another_service/cubit.dart';
import '../../../bloc/another_services_cubit/another_service/state.dart';
import '../../../component/guide_for_hajj_widget.dart';
import '../../../constant/const_color.dart';
import '../../../constant/text_theme.dart';
import '../../../tranlations/locale_keys.g.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var shopping=AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit,AnotherServicesState>(
        listener: (context,index){},
        builder: (context,index) {
          return Scaffold(
            appBar: headerForHijGuides(
                context: context,
                title: LocaleKeys.shopping.tr(),
                image: 'assets/images/guides.png'),
            body:shopping.isGetShopping? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView.separated(itemBuilder: (context,index){return Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/Path 198320.svg'),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(shopping.shoppingModel.data![index].title??'',style: cairoSemiBold,)
                    ],
                  ),
                  Html(data:
                  shopping.shoppingModel.data![index].content??'',
                  ),
                ],
              );}, separatorBuilder: (context,index){
                return SizedBox(height: 10,);
              }, itemCount: shopping.shoppingModel.data!.length),
            ):Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: orangeColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  darkMainColor, //<-- SEE HERE
                ),
              ),
            ),
          );
        }
    );
  }
}
