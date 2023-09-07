import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morshed/bloc/setting_cubit/cubit.dart';
import 'package:morshed/bloc/setting_cubit/state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/component/guide_escorts_component.dart';
import 'package:morshed/constant/text_theme.dart';
import 'package:morshed/screen/borading_screen/boarding_screen.dart';

import '../../component/component.dart';
import '../../tranlations/locale_keys.g.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var settingCubit = SettingCubit.get(context);
    return BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          {
            return Scaffold(
              appBar: headerOfTechnicalSupport(
                  context: context, title: LocaleKeys.settings.tr()),
              body: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8.w, vertical: 10.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                      height: 100.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.language.tr(),
                            style: cairoSemiBold.copyWith(fontSize: 17),
                          ),
                          Row(
                            children: [
                              Text(
                                'Ar',
                                style: cairoSemiBold.copyWith(
                                    fontSize: 17, color: darkMainColor),
                              ),
                              Switch.adaptive(
                                  inactiveThumbColor: darkMainColor,
                                  inactiveTrackColor: whiteGreyColor,
                                  activeColor: orangeColor,
                                  activeTrackColor: whiteGreyColor,
                                  value: isEnglish!,
                                  onChanged: (onChange) {
                                    setState(() {
                                      settingCubit.changeLanguage(context);
                                      myLocale = context.locale.languageCode;
                                    });
                                  }),
                              Text(
                                'En',
                                style: cairoSemiBold.copyWith(
                                    fontSize: 17, color: orangeColor),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  state is DeleteUserLoadingState&&settingCubit.isDeleteUser==false? CircularProgressIndicator.adaptive(
                    backgroundColor: orangeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      darkMainColor, //<-- SEE HERE
                    ),
                  ):TextButton(
                      onPressed: () async {
                        showAdaptiveDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog.adaptive(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: AlignmentDirectional.center,
                                content: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/delete_dialog.svg'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'هل تريد حذف الحساب ؟',
                                      style: cairoBold.copyWith(
                                          color: orangeColor),
                                    ),
                                  ],
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  mainButton(
                                      height: 40,
                                      textStyle: cairoBold.copyWith(
                                          color: blackColor, fontSize: 17),
                                      text: LocaleKeys.yes.tr(),
                                      color: whiteGreyColor,
                                      context: context,
                                      fct: () {

                                        settingCubit.deleteUser(context);
                                        //     .then((value) {
                                        //   if (state is DeleteUserSuccessState) {
                                        //
                                        //   }
                                        // });


                                      },
                                      width: 80),
                                  mainButton(
                                      text: LocaleKeys.no.tr(),
                                      height: 40,
                                      textStyle: cairoBold.copyWith(
                                          color: darkMainColor, fontSize: 17),
                                      color: whiteColor,
                                      borderColor: whiteGreyColor,
                                      context: context,
                                      fct: () {
                                        Navigator.pop(context);
                                      },
                                      width: 80),
                                  // TextButton(
                                  //     onPressed: (){}, child: Text('نعم')),
                                  // TextButton(
                                  //     onPressed: (){}, child:  Text('لا')),
                                ],
                              );
                            });
                      },
                      child: Text(
                        LocaleKeys.deleteAccount.tr(),
                        style: cairoBold.copyWith(
                            color: orangeColor,
                            fontSize: 17,
                            decoration: TextDecoration.underline),
                      ),
                    )

                  ],
                ),
              ),
            );
          }
        });
  }
}
