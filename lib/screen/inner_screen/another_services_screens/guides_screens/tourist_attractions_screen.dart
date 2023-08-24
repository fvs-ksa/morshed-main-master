import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../bloc/another_services_cubit/another_service/cubit.dart';
import '../../../../bloc/another_services_cubit/another_service/state.dart';
import '../../../../component/guide_for_hajj_widget.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/text_theme.dart';
import '../../../../tranlations/locale_keys.g.dart';

class TouristAttractionsScreen extends StatelessWidget {
  const TouristAttractionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var touristAttraction = AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit, AnotherServicesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: headerForHijGuides(
                image: 'assets/images/guides.png',
                context: context,
                title: LocaleKeys.touristAttractions.tr()),
            body: touristAttraction.isGetTouristAttraction
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ListView.builder(
                      itemCount: touristAttraction.touristAttraction.data?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/svg/Path 198320.svg'),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  touristAttraction.touristAttraction
                                          .data![index].title ??
                                      '',
                                  style: cairoSemiBold,
                                )
                              ],
                            ),
                            Html(
                                data: touristAttraction.touristAttraction
                                        .data![index].content ??
                                    '')
                          ],
                        );
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: orangeColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        darkMainColor, //<-- SEE HERE
                      ),
                    ),
                  ),
          );
        });
  }
}
