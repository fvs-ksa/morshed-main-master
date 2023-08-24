import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/register_cubit/cubit.dart';
import 'package:morshed/bloc/register_cubit/state.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../constant/const_color.dart';
import '../constant/text_theme.dart';
import '../tranlations/locale_keys.g.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var registerCubit=RegisterCubit.get(context);
    return  BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context,state){},
      builder: (context,state) {
        return GestureDetector(
          onTap: () {
            QuickAlert.show(

              context: context,
              confirmBtnColor: darkMainColor,
              confirmBtnText:LocaleKeys.yes.tr() ,
              cancelBtnText:LocaleKeys.no.tr() ,
              confirmBtnTextStyle: cairoBold.copyWith(color: whiteColor),
              cancelBtnTextStyle: cairoBold,
              type: QuickAlertType
                  .confirm,
              title:LocaleKeys.choose_please.tr(),

              widget: Column(
                mainAxisSize:
                MainAxisSize.min,
                children: [
                  //  Text(LocaleKeys.choose_please.tr()),
                  GestureDetector(
                    onTap: () {
                      registerCubit
                          .pickImageFromCamera()
                          .then(
                              (value) {
                            Navigator.pop(
                                context);
                          });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons
                              .camera_alt,
                          color:
                          darkMainColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        AutoSizeText(
                          LocaleKeys.camera.tr(),
                          style:cairoBold,
                          presetFontSizes: [
                            15.sp,
                            12.sp,
                            10.sp
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      registerCubit
                          .pickImageFromGallery()
                          .then(
                              (value) {
                            Navigator.pop(
                                context);
                          });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          color:
                          orangeColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        AutoSizeText(
                          LocaleKeys.gallery.tr(),
                          style: cairoBold,
                          presetFontSizes: [
                            15.sp,
                            12.sp,
                            10.sp
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          child: Image.asset(
            'assets/images/camera.png',
            height: 46.h,
          ),
        );
      }
    );
  }
}
