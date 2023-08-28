import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/submitting_report/submit_report_cubit.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/component/info_profile_component.dart';
import 'package:morshed/constant/text_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../component/cutom_text_filed.dart';
import '../../../component/navigation_functions.dart';
import '../../../constant/const_color.dart';
import '../../../component/guide_escorts_component.dart';
import '../../../tranlations/locale_keys.g.dart';
import '../../bottom_navigations_screens/widget/resisdance_Widget.dart';

class MyReportsDetailsScreen extends StatelessWidget {
  String status;
  int reportId;
  int index;

  MyReportsDetailsScreen({Key? key, required this.index,required this.reportId,required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reportCubit=SubmitReportCubit.get(context);
    return BlocConsumer<SubmitReportCubit,SubmitReportState>(
      listener: (context,state){},
       // bloc: reportCubit.getMyReports(),
      builder: (context,state) {
        TextEditingController reportIdController=TextEditingController(text:reportCubit.getMyReportsModel.reports![index].id!.toString() );
        TextEditingController passportNoController=TextEditingController(text: reportCubit.getMyReportsModel.reports![index].passportNumber);
        TextEditingController locationController=TextEditingController(text:reportCubit.getMyReportsModel.reports![index].location??'');
        TextEditingController detailsController=TextEditingController(text:reportCubit.getMyReportsModel.reports![index].reportDetails??'');

        return Scaffold(
          // appBar: headerOfTechnicalSupport(
          //     context: context, title: LocaleKeys.reportDetails.tr()),
          appBar: headerOfTechnicalSupport(
              context: context, title: "${LocaleKeys.report_no.tr()} $reportId"),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: 62.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(status == '1'
                                    ? 'assets/images/Group 204366.png'
                                    : status == '2'
                                        ? 'assets/images/Group 204365.png'
                                        : 'assets/images/Group 204367.png'),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        status == '1'
                            ? LocaleKeys.underProcessing.tr()
                            : status == '2'
                                ? LocaleKeys.guideOnTheWay.tr()
                                : LocaleKeys.Resolved.tr(),
                        style: status == '3'
                            ? cairoBold.copyWith(fontSize: 14,color: darkMainColor)
                            : cairoBold.copyWith(fontSize: 14,color: whiteColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 15.w, vertical: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextField(
                          padding: 10,
                            labelText: LocaleKeys.reportNumber.tr(),
                            controller: reportIdController,
                            isEnabled: false),
                        CustomTextField(
                            padding: 10,
                            labelText: LocaleKeys.passportNo.tr(),
                            controller: passportNoController,
                            isEnabled: false),
                        clikedLocationWidget(controller: locationController,
                            fct: () async {
                              if(reportCubit.getMyReportsModel.reports![index].latitude==null){
                                showToast(text: 'لا يوجد موقع للبلاغ', state: ToastState.ERROR);
                              }else{
                                if (Platform.isIOS) {
                                  await launchUrl(Uri.parse(
                                      "comgooglemaps://?q=${reportCubit.getMyReportsModel.reports![index].latitude},"
                                          "${reportCubit.getMyReportsModel.reports![index].longitude}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                } else {
                                  await launchUrl(Uri.parse(
                                      'google.navigation:q='
                                          '${reportCubit.getMyReportsModel.reports![index].latitude}, '
                                          '${reportCubit.getMyReportsModel.reports![index].longitude}'
                                          '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                }
                              }

                            },
                            context: context, labelText: LocaleKeys.reportLocation.tr(),),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: GestureDetector(
                        //         onTap: () async {
                        //           if(reportCubit.getMyReportsModel.reports![index].latitude==null){
                        //             showToast(text: 'لا يوجد موقع لفندق الإقامه في المدينة المنورة', state: ToastState.ERROR);
                        //           }else{
                        //             if (Platform.isIOS) {
                        //               await launchUrl(Uri.parse(
                        //                   "comgooglemaps://?q=${reportCubit.getMyReportsModel.reports![index].latitude},"
                        //                       "${reportCubit.getMyReportsModel.reports![index].longitude}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                        //             } else {
                        //               await launchUrl(Uri.parse(
                        //                   'google.navigation:q='
                        //                       '${reportCubit.getMyReportsModel.reports![index].latitude}, '
                        //                       '${reportCubit.getMyReportsModel.reports![index].longitude}'
                        //                       '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                        //             }
                        //           }
                        //
                        //         },
                        //         // onTap: ()async{
                        //         //   await launchUrl(Uri.parse
                        //         //     ('google.navigation:q='
                        //         //       '${reportCubit.getMyReportsModel.reports![index].latitude!}, '
                        //         //       '${reportCubit.getMyReportsModel.reports![index].longitude!}'
                        //         //       '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                        //         //
                        //         // },
                        //         child: CustomTextField(
                        //             padding: 10,
                        //             labelText: LocaleKeys.reportLocation.tr(),
                        //             controller: locationController,
                        //             isEnabled: false),
                        //       ),
                        //     ),
                        //     decorationContainerWidget(
                        //         context: context,
                        //         radius: 50.sp,
                        //         width: 70.w,
                        //         height: 54.h,
                        //         child: Padding(
                        //             padding: EdgeInsets.all(8),
                        //             child: FittedBox(
                        //               child: AutoSizeText(
                        //                   presetFontSizes: [10,8,6],
                        //                   "press_here".tr(),
                        //                   style:cairoMedium.copyWith(color: darkMainColor)
                        //                 // TextStyle(color: darkMainColor),
                        //               ),
                        //             ))),
                        //   ],
                        // ),
                        bigTextFieldForNotes(
                          controller: detailsController,
                            context: context,
                            isEnabled: false,

                            hint: LocaleKeys.commentsAndAssistance.tr()),
                        Text(
                          LocaleKeys.WhatCanWeDoToAssistYou.tr(),
                          style: cairoBold.copyWith(fontSize: 17),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          reportCubit.getMyReportsModel.reports![index].assistanceMethod??'',
                          style: cairoSemiBold.copyWith(fontSize: 14),
                        ),
                        status == 1
                            ? Align(
                                alignment: AlignmentDirectional.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.h, horizontal: 10.w),
                                  child: mainButton(
                                      text: LocaleKeys.cancelReport.tr(),
                                      color: orangeColor,
                                      context: context,
                                      fct: () {}),
                                ))
                            : const SizedBox(),
                        status == '1'
                            ?  SizedBox()
                            :Card(
                          elevation: 3,
                          margin: EdgeInsetsDirectional.only(top: 10.h),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.sp)),
                          child: Container(
                            padding: EdgeInsetsDirectional.only(end: 15.w),
                            height: 140.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: darkMainColor,
                                borderRadius: BorderRadius.circular(8.sp)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 25.sp,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile.png'),
                                      ),
                                      title: Text(
                                        reportCubit.getMyReportsModel.reports![index].receiverName,
                                        style: cairoBold.copyWith(fontSize: 17),
                                      ),
                                      subtitle: RichText(
                                        text: TextSpan(
                                            text:
                                            '${LocaleKeys.phoneNumber.tr()} : ',
                                            style: cairoSemiBold.copyWith(fontSize: 12,color: greyColor),
                                            children: [
                                              TextSpan(
                                                text: reportCubit.getMyReportsModel.reports![index].receiverMobile,
                                                style: cairoRegular.copyWith(fontSize: 14,color: blackColor),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    circleAvtarWidget(
                                        svgImage: 'assets/svg/end call.svg',
                                        fct: () {
                                          launchCall(context: context,phoneNumber: reportCubit.getMyReportsModel.reports![index].receiverMobile);
                                        }),
                                    circleAvtarWidget(
                                        svgImage: 'assets/svg/msg.svg',
                                        fct: () {
                                          showToast(text:LocaleKeys.service_under_development.tr(), state: ToastState.WARNING);
                                        })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
