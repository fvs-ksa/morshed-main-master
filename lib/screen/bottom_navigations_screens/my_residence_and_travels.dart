import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/general_cubit/general_cubit.dart';
import 'package:morshed/bloc/general_cubit/general_state.dart';
import 'package:morshed/constant/text_theme.dart';
import 'package:morshed/screen/bottom_navigations_screens/widget/resisdance_Widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/animation_component.dart';
import '../../component/cutom_text_filed.dart';
import '../../component/gesut_widget.dart';
import '../../constant/const_color.dart';
import '../../component/info_profile_component.dart';
import '../../tranlations/locale_keys.g.dart';

class MyResidenceAndTravels extends StatelessWidget {
  const MyResidenceAndTravels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalCubit = GeneralCubit.get(context);
    return token==null?GuestWidget(): BlocConsumer<GeneralCubit, GeneralState>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController arrivalController = TextEditingController(
              text: generalCubit.profileModel.data!.arrivalDate??'');
          TextEditingController departureController = TextEditingController(
              text: generalCubit.profileModel.data!.departureDate??'');
          TextEditingController mozdalifaLocationController =
              TextEditingController(
                  text: generalCubit.profileModel.data!.locationMozdalifa ?? '');
          TextEditingController mennaLocationConroller = TextEditingController(
              text: generalCubit.profileModel.data!.locationMina ?? '');
          TextEditingController arafaLocationController = TextEditingController(
              text: generalCubit.profileModel.data!.locationArfat ?? '');
          TextEditingController visaNumberController = TextEditingController(
              text: generalCubit.profileModel.data!.visaNumber??'');
          TextEditingController maccaHotelLocationController =
              TextEditingController(
                  text: generalCubit.profileModel.data!.hotelMakkah??'');
          TextEditingController madinahHotelNumberController =
              TextEditingController(
                  text: generalCubit.profileModel.data!.hotelMadinah??'');
          return  Column(
            children: [
              PreferredSize(
                  child: Stack(
                    children: [
                      Container(
                        height: 190.h,
                        child: Center(
                            child: FittedBox(
                                child: Text(
                          LocaleKeys.myAccommodationAndTrips.tr(),
                          style: cairoBold.copyWith(
                              color: whiteColor, fontSize: 20),
                        ))),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/header1.png'),
                                fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 14.w, top: 140.h),
                        child: CircleAvatar(
                          backgroundColor: darkMainColor,
                          backgroundImage: NetworkImage(
                              generalCubit.profileModel.data!.image ?? ''),
                          //  child: Image.asset('assets/images/profile.png'),
                          //   child: Image.network(generalCubit.profileModel.data!.image??''),
                          radius: 45.sp,
                        ),
                      )
                    ],
                  ),
                  preferredSize: Size.fromHeight(220.h)),
              Expanded(
                child: generalCubit.isGetProfile
                    ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 18.h),
                          child: Column(
                            children: [
                              accountTypeName == 'pilgrimUmrah'
                                  ? SizedBox()
                                  : clikedLocationWidget(
                                      controller: mennaLocationConroller,
                                      fct: () async {
                                        if (generalCubit.profileModel.data!
                                                .latitudeMina ==
                                            null) {
                                          showToast(
                                              text: 'لا يوجد موقع لمخيم منى',
                                              state: ToastState.ERROR);
                                        } else {
                                          if (Platform.isIOS) {
                                            await launchUrl(Uri.parse(
                                                "comgooglemaps://?q=${generalCubit.profileModel.data!.latitudeMina},"
                                                "${generalCubit.profileModel.data!.longitudeMina}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                          } else {
                                            await launchUrl(Uri.parse(
                                                'google.navigation:q='
                                                '${generalCubit.profileModel.data!.latitudeMina}, '
                                                '${generalCubit.profileModel.data!.longitudeMina}'
                                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                          }
                                        }
                                      },
                                      context: context,
                                      labelText: LocaleKeys.menna_loc.tr()),

                              accountTypeName == 'pilgrimUmrah'
                                  ? SizedBox()
                                  : clikedLocationWidget(
                                      controller: arafaLocationController,
                                      fct: () async {
                                        if (generalCubit.profileModel.data!
                                                .latitudeArfat ==
                                            null) {
                                          showToast(
                                              text: 'لا يوجد موقع لمخيم عرفات',
                                              state: ToastState.ERROR);
                                        } else {
                                          if (Platform.isIOS) {
                                            await launchUrl(Uri.parse(
                                                "comgooglemaps://?q=${generalCubit.profileModel.data!.latitudeArfat},"
                                                "${generalCubit.profileModel.data!.longitudeArfat}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                          } else {
                                            await launchUrl(Uri.parse(
                                                'google.navigation:q='
                                                '${generalCubit.profileModel.data!.latitudeArfat}, '
                                                '${generalCubit.profileModel.data!.longitudeArfat}'
                                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                          }
                                        }
                                      },
                                      context: context,
                                      labelText: LocaleKeys.arafa_loc.tr()),
                              accountTypeName == 'pilgrimUmrah'
                                  ? SizedBox()
                                  : clikedLocationWidget(
                                      controller: mozdalifaLocationController,
                                      fct: () async {
                                        if (generalCubit.profileModel.data!
                                                .latitudeMozdalifa ==
                                            null) {
                                          showToast(
                                              text:
                                                  'لا يوجد موقع لمخيم المزدلفه',
                                              state: ToastState.ERROR);
                                        } else {
                                          if (Platform.isIOS) {
                                            await launchUrl(Uri.parse(
                                                "comgooglemaps://?q=${generalCubit.profileModel.data!.latitudeMozdalifa},"
                                                "${generalCubit.profileModel.data!.longitudeMozdalifa}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                          } else {
                                            await launchUrl(Uri.parse(
                                                'google.navigation:q='
                                                '${generalCubit.profileModel.data!.latitudeMozdalifa}, '
                                                '${generalCubit.profileModel.data!.longitudeMozdalifa}'
                                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                          }
                                        }
                                      },
                                      context: context,
                                      labelText: LocaleKeys.mozdalifa_loc.tr()),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 8),
                                child: clikedLocationWidget(
                                    controller: maccaHotelLocationController,
                                    fct: () async {
                                      if (generalCubit.profileModel.data!
                                              .latitudeMakkah ==
                                          null) {
                                        showToast(
                                            text:
                                                'لا يوجد موقع لفندق الإقامه في مكه المكرمة',
                                            state: ToastState.ERROR);
                                      } else {
                                        if (Platform.isIOS) {
                                          await launchUrl(Uri.parse(
                                              "comgooglemaps://?q=${generalCubit.profileModel.data!.latitudeMakkah},"
                                              "${generalCubit.profileModel.data!.longitudeMakkah}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                        } else {
                                          await launchUrl(Uri.parse(
                                              'google.navigation:q='
                                              '${generalCubit.profileModel.data!.latitudeMakkah}, '
                                              '${generalCubit.profileModel.data!.longitudeMakkah}'
                                              '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                        }
                                      }
                                    },
                                    context: context,
                                    labelText: LocaleKeys.maccaHotelName.tr()),
                              ),

                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 8),
                                child: clikedLocationWidget(
                                    controller: madinahHotelNumberController,
                                    fct: () async {
                                      if (generalCubit.profileModel.data!
                                              .latitudeMadinah ==
                                          null) {
                                        showToast(
                                            text:
                                                'لا يوجد موقع لفندق الإقامه في المدينة المنورة',
                                            state: ToastState.ERROR);
                                      } else {
                                        if (Platform.isIOS) {
                                          await launchUrl(Uri.parse(
                                              "comgooglemaps://?q=${generalCubit.profileModel.data!.latitudeMadinah},"
                                              "${generalCubit.profileModel.data!.longitudeMadinah}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                        } else {
                                          await launchUrl(Uri.parse(
                                              'google.navigation:q='
                                              '${generalCubit.profileModel.data!.latitudeMadinah}, '
                                              '${generalCubit.profileModel.data!.longitudeMadinah}'
                                              '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                        }
                                      }
                                    },
                                    context: context,
                                    labelText:
                                        LocaleKeys.madina_hotels_name.tr()),
                              ),

                              // CustomTextField(
                              //     isEnabled: false,
                              //   controller: visaNumberController,
                              //     labelText: LocaleKeys.visaNo.tr(), ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: CustomTextField(
                                        isEnabled: false,
                                        controller: arrivalController,
                                        labelText: LocaleKeys.arriveDate.tr(),
                                        // hintText: '14/2/1966',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          //  profileCubit.chooseDateTime(context: context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: decorationContainerWidget(
                                              context: context,
                                              radius: 50.sp,
                                              width: 70.w,
                                              height: 54.h,
                                              child: SvgPicture.asset(
                                                  'assets/svg/Calendar.svg')),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: CustomTextField(
                                        isEnabled: false,
                                        controller: departureController,
                                        labelText: LocaleKeys.leaveDate.tr(),
                                        // hintText: '14/2/1966',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        //  profileCubit.chooseDateTime(context: context);
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: decorationContainerWidget(
                                              context: context,
                                              radius: 50.sp,
                                              width: 70.w,
                                              height: 54.h,
                                              child: SvgPicture.asset(
                                                  'assets/svg/Calendar.svg'))),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator.adaptive(
                        backgroundColor: orangeColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          darkMainColor, //<-- SEE HERE
                        ),
                      )),
              ),
            ],
          );
        });
  }
}
