import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/const_color.dart';
import '../constant/text_theme.dart';
import '../screen/borading_screen/account_type_screen.dart';
import '../tranlations/locale_keys.g.dart';
import 'component.dart';
import 'navigation_functions.dart';

class GuestWidget extends StatelessWidget {
  const GuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
    //  alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/sign_first.png')),
          SizedBox(height: 15,),
          Text(LocaleKeys.youArenotLogin.tr(),style: cairoSemiBold.copyWith(color: greyColor),),
          SizedBox(height: 10,),
          mainButton(text: LocaleKeys.YouMustLoginFirst.tr(), color: darkMainColor, context: context, fct: (){
            navigateForward(AccountTypeScreen());
          },
              height: 50,textStyle: cairoBold.copyWith(color: whiteColor))
          // Text('أنت غير مسجل بالتطبيق'),
          // mainButton(text: 'سجل للمتابعه', color: Colors.transparent, context: context, fct: (){},width: 150,textStyle: cairoSemiBold.copyWith(color: darkMainColor))
        ],
      ),
    );
  }
}
