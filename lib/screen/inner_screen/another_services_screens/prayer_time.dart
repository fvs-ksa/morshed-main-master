import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/component/navigation_functions.dart';

import '../../../bloc/another_services_cubit/another_service/cubit.dart';
import '../../../bloc/another_services_cubit/another_service/state.dart';
import '../../../component/guide_for_hajj_widget.dart';
import '../../../constant/const_color.dart';
import '../../../constant/text_theme.dart';
import '../../../tranlations/locale_keys.g.dart';
import 'full_image.dart';

class PrayerTimeScreen extends StatelessWidget {
  const PrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var prayerTime=AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit,AnotherServicesState>(
        listener: (context,index){},
        builder: (context,index) {
          return Scaffold(
            appBar: headerForHijGuides(
                context: context,
                title: LocaleKeys.salah.tr(),
                image: 'assets/images/hajj (1).png'),
            body:prayerTime.isGetPrayer? Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView.separated(itemBuilder: (context,index){return Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/Path 198320.svg'),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(prayerTime.prayerModel.data![index].title??'',style: cairoSemiBold,)
                    ],
                  ),
                  GestureDetector(
                    onTap: (){navigateForward(FullImageScreen(index:index));},
                    child: Hero(
                      tag: 'image',
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(prayerTime.prayerModel.data![index].imagepath??''),
                      ),
                    ),
                  )
                ],
              );}, separatorBuilder: (context,index){
                return SizedBox(height: 10,);
              }, itemCount: prayerTime.prayerModel.data!.length),
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
