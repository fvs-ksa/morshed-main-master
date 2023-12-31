import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morshed/bloc/account_type_cubit/cubit.dart';
import 'package:morshed/bloc/account_type_cubit/state.dart';
import 'package:morshed/bloc/location_cubit/cubit.dart';
import 'package:morshed/bloc/location_cubit/state.dart';
import 'package:morshed/bloc/register_cubit/cubit.dart';
import 'package:morshed/bloc/register_cubit/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/auth_header_widget.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/screen/inner_screen/locations/set_location_on_map.dart';
import '../../../component/custom_alert_dialog.dart';
import '../../../component/custom_drop_down.dart';
import '../../../component/cutom_text_filed.dart';
import '../../../component/info_profile_component.dart';
import '../../../component/navigation_functions.dart';
import '../../../constant/text_theme.dart';
import '../../../tranlations/locale_keys.g.dart';
import '../../inner_screen/privacy_policy.dart';
import '../hajji/login_screen.dart';
import '../widget/country_picker_key.dart';

class RegisterMoetamerScreen extends StatelessWidget {
  //ignore: must_be_immutable
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController dateOfArrivalController = TextEditingController();
  TextEditingController dateOfDepartureController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController visaNumberController = TextEditingController();
  TextEditingController borderNumberController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController maccaHotelLocController = TextEditingController();
  TextEditingController madinaHotelLocController = TextEditingController();
  TextEditingController maccaHotelNameController = TextEditingController();
  TextEditingController madinaHotelNameController = TextEditingController();
  final FocusNode _nameArFocus = FocusNode();
  final FocusNode _nameEnFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passportFocus = FocusNode();
  final FocusNode _visaFocus = FocusNode();
  final FocusNode _idFocus = FocusNode();
  final FocusNode _maccaHotelFocus = FocusNode();
  final FocusNode _madinaHotelFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String? numberSave;
  @override
  Widget build(BuildContext context) {
    var registerCubit = RegisterCubit.get(context);
    var accountTypeCubit = AccountTypeCubit.get(context);
    return BlocConsumer<LocationCubit,LocationState>(
      listener: (context,state){},
      builder: (context,state) {
        return BlocConsumer<AccountTypeCubit, AccountTypeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {},
                  bloc: registerCubit.viewAboveKeyBoard(),
                  builder: (context, state) {
                    return Scaffold(
                      appBar: headerAuthScreen(
                        context: context,
                        title: accountTypeCubit.isUmrah
                            ? LocaleKeys.registerNewMoetamer.tr()
                            : LocaleKeys.registerNewHajji.tr(),
                      ),
                      body: registerCubit.isGetCompany &&
                              registerCubit.isGetNationality
                          ? GestureDetector(
                              onTap: () =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 15.w,
                                      end: 15.w,
                                      bottom: registerCubit.viewInsets.bottom,
                                      top: 10.h),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextField(
                                          padding: 10,
                                          focusNode: _nameArFocus,
                                            nextFocus: _nameEnFocus,
                                            isRequired: true,
                                            minHeight: 10.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            labelText:
                                                LocaleKeys.arabicNamePassport.tr(),
                                            validator: (val) {
                                              if (val.isEmpty || val == null) {
                                                // return LocaleKeys
                                                //     .enter_Full_arabic_name
                                                //     .tr();
                                                return '';
                                              }
                                              return null;
                                            },
                                            controller: arabicNameController),
                                        CustomTextField(
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            isRequired: true,
                                            minHeight: 10.h,
                                            focusNode: _nameEnFocus,
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys
                                                //     .enter_Full_english_name
                                                //     .tr();
                                              }
                                              return null;
                                            },
                                            labelText:
                                                LocaleKeys.englishNamePassport.tr(),
                                            // hintText: 'الاسم بالكامل بالانجليزيه حسب الجواز',
                                            controller: englishNameController),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LocaleKeys.profilePic.tr(),
                                              style:
                                                  cairoBold.copyWith(fontSize: 20),
                                            ),
                                            Text('"${LocaleKeys.requiredField.tr()}"',style: cairoSemiBold.copyWith(fontSize: 10,color: Colors.red),),
                                            Spacer(),
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                !registerCubit.isPickImage
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 35.sp,
                                                        backgroundImage:
                                                            const AssetImage(
                                                                'assets/images/profile.png'),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 35.sp,
                                                        backgroundImage: FileImage(
                                                            registerCubit.file!),
                                                      ),
                                                CustomAlertDialog(),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: CustomTextField(
                                                  focusNode: _phoneFocus,
                                                    isRequired: true,
                                                    padding: 10,
                                                    minHeight: 10.h,
                                                    maxHeight: 80.h,
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return '';
                                                        // return LocaleKeys
                                                        //     .enter_phone_number
                                                        //     .tr();
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    labelText:
                                                        LocaleKeys.phoneNumber.tr(),
                                                    controller:
                                                        phoneNumberController),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: decorationContainerWidget(
                                                radius: 35.sp,
                                                context: context,
                                                width: 100,
                                                  child: CountryPickedCode(countryKey: numberSave??'+966',),
                                                  // child: Text(
                                                  //   '+966',
                                                  //   style: cairoBold.copyWith(
                                                  //       fontSize: 14,
                                                  //       color: darkMainColor),
                                                  //   textAlign: TextAlign.center,
                                                  // )
                                              ),
                                            ),
                                          ],
                                        ),
                                        CustomDropDown(),
                                        Text(LocaleKeys.requiredField,style: cairoSemiBold.copyWith(fontSize: 10,color: Colors.red),).tr(),
                                        dropDownButton(
                                            items: registerCubit.sexList.map((e) {
                                              return DropdownMenuItem(child: Text(e),value: e,);
                                            }).toList(),
                                            value: registerCubit.chooseSex,
                                            hint: LocaleKeys.sex.tr(),

                                            fct: (onChange){
                                              return registerCubit.onChangeSex(onChange);
                                            },
                                            context: context),
                                        Text(LocaleKeys.requiredField,style: cairoSemiBold.copyWith(fontSize: 10,color: Colors.red),).tr(),
                                        // dropDownButton(
                                        //   items: registerCubit
                                        //       .nationalityModel.data!
                                        //       .map((e) {
                                        //     return DropdownMenuItem(
                                        //      // alignment: AlignmentDirectional.bottomCenter,
                                        //       child: Text(e.name.toString()),
                                        //       value: e.name.toString(),
                                        //     );
                                        //   }).toList(),
                                        //   value:
                                        //       registerCubit.chooseNationality,
                                        //   hint: LocaleKeys.nationality.tr(),
                                        //   fct: (onChange) {
                                        //     registerCubit.onChangeCountryName(
                                        //         onChange);
                                        //   },
                                        //   context: context,
                                        // ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: GestureDetector(
                                                  onTap: ()async{
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                    await registerCubit
                                                        .chooseDateTimeForBirth(
                                                        context: context,
                                                        controller:
                                                        dateOfBirthController);
                                                  },
                                                  child: CustomTextField(
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return '';
                                                        // return LocaleKeys
                                                        //     .enter_date_of_birth
                                                        //     .tr();
                                                      }
                                                      return null;
                                                    },
                                                    minHeight: 10.h,
                                                    isRequired: true,
                                                    padding: 10,
                                                    maxHeight: 80.h,
                                                    maxWidth: 400.w,
                                                    minWidth: 400.w,
                                                    isEnabled: false,
                                                    labelText:
                                                        LocaleKeys.dateOfBirth.tr(),
                                                    controller: dateOfBirthController,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                    await registerCubit
                                                        .chooseDateTimeForBirth(
                                                            context: context,
                                                            controller:
                                                                dateOfBirthController);
                                                    print("222222222222222222${dateOfBirthController.text}");
                                                  },
                                                  child: decorationContainerWidget(
                                                      radius: 35.sp,
                                                      context: context,
                                                      child: SvgPicture.asset(
                                                          'assets/svg/Calendar.svg'))),
                                            ),
                                          ],
                                        ),

                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys
                                                //     .enter_Passport_number
                                                //     .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 10.h,
                                            padding: 10,
                                            isRequired: true,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _passportFocus,
                                            nextFocus: _visaFocus,
                                            labelText: LocaleKeys.passportNo.tr(),
                                            // hintText: 'رقم الجواز',
                                            controller: passportController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys.enter_vise_no
                                                //     .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 10.h,
                                            isRequired: true,
                                            padding: 10,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _visaFocus,
                                            nextFocus: _idFocus,
                                            labelText: LocaleKeys.visaNo.tr(),
                                            controller: visaNumberController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys
                                                //     .enter_borderOrIdOrIqama_no
                                                //     .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 10.h,
                                            isRequired: true,
                                            padding: 10,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _idFocus,
                                            labelText: LocaleKeys
                                                .enter_borderOrIdOrIqama_no
                                                .tr(),
                                            controller: borderNumberController),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await  registerCubit
                                                        .chooseDateTimeForArrival(
                                                        controller:
                                                        dateOfArrivalController,
                                                        context: context);
                                                  },
                                                  child: CustomTextField(
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return '';
                                                        // return LocaleKeys
                                                        //     .enter_arrival_date
                                                        //     .tr();
                                                      }
                                                      return null;
                                                    },
                                                    minHeight: 10.h,
                                                    isRequired: true,
                                                    padding: 10,
                                                    maxHeight: 80.h,
                                                    isEnabled: false,
                                                    labelText:
                                                        LocaleKeys.arriveDate.tr(),
                                                    controller:
                                                        dateOfArrivalController,
                                                    // hintText:registerCubit.convertedDateTime?? 'تاريخ الوصول',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                await  registerCubit
                                                      .chooseDateTimeForArrival(
                                                          controller:
                                                              dateOfArrivalController,
                                                          context: context);
                                                },
                                                child: decorationContainerWidget(
                                                    context: context,
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                            'assets/svg/Calendar.svg')),
                                                    radius: 35.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                   await registerCubit
                                                        .chooseDateTimeDepuration(
                                                        controller:
                                                        dateOfDepartureController,
                                                        context: context);
                                                  },
                                                  child: CustomTextField(
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return '';
                                                        // return LocaleKeys
                                                        //     .enter_depurate_date
                                                        //     .tr();
                                                      }
                                                      return null;
                                                    },
                                                    minHeight: 10.h,
                                                    maxHeight: 80.h,
                                                    isRequired: true,
                                                    padding: 10,
                                                    // validator: (String val){
                                                    //   if(val.isEmpty){
                                                    //     return 'رجاء ادخال البيانات المطلوبه';
                                                    //   }
                                                    // },
                                                    isEnabled: false,
                                                    labelText:
                                                        LocaleKeys.leaveDate.tr(),
                                                    controller:
                                                        dateOfDepartureController,
                                                    // hintText:registerCubit.convertedDateTime?? 'تاريخ المغادره',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  FocusManager.instance.primaryFocus!.unfocus();
                                                await  registerCubit
                                                      .chooseDateTimeDepuration(
                                                          controller:
                                                              dateOfDepartureController,
                                                          context: context);
                                                },
                                                child: decorationContainerWidget(
                                                    context: context,
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                            'assets/svg/Calendar.svg')),
                                                    radius: 35.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // dropDownButton(
                                        //     items: registerCubit.residence.map((e) {
                                        //       return DropdownMenuItem(
                                        //         child: Text(
                                        //             e['residenceName'].toString()),
                                        //         value: e['id'].toString(),
                                        //       );
                                        //     }).toList(),
                                        //     value: registerCubit.chooseResidence,
                                        //     hint: LocaleKeys.residentialAddress.tr(),
                                        //     fct: (onChange) {
                                        //       registerCubit
                                        //           .onChangeResidence(onChange);
                                        //       print(onChange);
                                        //     },
                                        //     context: context,
                                        //     validator: () {}),
                                        // registerCubit.chooseResidence == '1'
                                        //     ?
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys.enter_makka_hotel
                                                //     .tr();
                                              }
                                              return null;
                                            },
                                            isRequired: true,
                                            padding: 10,
                                            minHeight: 10,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _maccaHotelFocus,
                                            labelText:
                                                LocaleKeys.enter_makka_hotel.tr(),
                                            controller: maccaHotelNameController),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                    navigateForward(
                                                        MapScreenForSetLocation(
                                                            locationName:
                                                            maccaHotelLocController,
                                                            i: 4));
                                                  },
                                                  child: CustomTextField(
                                                      validator: (String val) {
                                                        if (val.isEmpty) {
                                                          return '';
                                                          // return LocaleKeys
                                                          //     .macca_hotel_loc
                                                          //     .tr();
                                                        }
                                                        return null;
                                                      },
                                                      isRequired: true,
                                                      padding: 10,
                                                      minHeight: 10,
                                                      maxHeight: 80.h,
                                                      isEnabled: false,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      labelText: LocaleKeys
                                                          .macca_hotel_loc
                                                          .tr(),
                                                      controller:
                                                          maccaHotelLocController),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusManager.instance.primaryFocus!.unfocus();
                                                  navigateForward(
                                                      MapScreenForSetLocation(
                                                          locationName:
                                                              maccaHotelLocController,
                                                          i: 4));
                                                },
                                                child: decorationContainerWidget(
                                                    context: context,
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                            'assets/svg/loc.svg')),
                                                    radius: 35.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys.madina_hotels_name
                                                //     .tr();
                                              }
                                              return null;
                                            },
                                            isRequired: true,
                                            padding: 10,
                                            minHeight: 10,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _madinaHotelFocus,
                                            labelText:
                                                LocaleKeys.madina_hotels_name.tr(),
                                            // hintText: 'رقم الحدود',
                                            controller: madinaHotelNameController),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(top: 8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    navigateForward(
                                                        MapScreenForSetLocation(
                                                            locationName:
                                                            madinaHotelLocController,
                                                            i: 5));
                                                  },
                                                  child: CustomTextField(
                                                      validator: (String val) {
                                                        if (val.isEmpty) {
                                                          return '';
                                                          // return LocaleKeys
                                                          //     .madina_hotel_loc
                                                          //     .tr();
                                                        }
                                                        return null;
                                                      },
                                                      isRequired: true,
                                                      padding: 10,
                                                      minHeight: 10,
                                                      maxHeight: 80.h,
                                                      isEnabled: false,
                                                      // keyboardType: TextInputType.phone,
                                                      labelText: LocaleKeys
                                                          .madina_hotel_loc
                                                          .tr(),
                                                      // hintText: 'رقم الجوال',
                                                      controller:
                                                          madinaHotelLocController),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  navigateForward(
                                                      MapScreenForSetLocation(
                                                          locationName:
                                                              madinaHotelLocController,
                                                          i: 5));
                                                },
                                                child: decorationContainerWidget(
                                                    context: context,
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                            'assets/svg/loc.svg')),
                                                    radius: 35.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     navigateForward(
                                        //         MapScreenForSetLocation(
                                        //             locationName: mennaLocController,
                                        //             i: 0));
                                        //   },
                                        //   child: CustomTextField(
                                        //       validator: (String val){
                                        //         if(val.isEmpty){
                                        //           return 'برجاء تحديد موقع منى';
                                        //         }
                                        //         return null;
                                        //       },
                                        //       minHeight: 80.h,
                                        //       maxHeight: 80.h,
                                        //       isEnabled: false,
                                        //       maxWidth: 400.w,
                                        //       minWidth: 400.w,
                                        //       lines: 1,
                                        //       labelText:  'موقع منى',
                                        //
                                        //       // hintText: 'رقم المخيم  (منى)',
                                        //       controller: mennaLocController),
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     navigateForward(
                                        //         MapScreenForSetLocation(
                                        //             locationName: arafaLocController,
                                        //             i: 1));
                                        //   },
                                        //   child: CustomTextField(
                                        //       validator: (String val){
                                        //         if(val.isEmpty){
                                        //           return 'برجاء تحديد موقع عرفه';
                                        //         }
                                        //         return null;
                                        //       },
                                        //       minHeight: 80.h,
                                        //       maxHeight: 80.h,
                                        //       isEnabled: false,
                                        //       maxWidth: 400.w,
                                        //       minWidth: 400.w,
                                        //       lines: 1,
                                        //       labelText: 'موقع عرفه',
                                        //       // hintText: 'رقم المخيم  (عرفه)',
                                        //       controller: arafaLocController),
                                        // ),
                                        // GestureDetector(
                                        //     onTap: () {
                                        //       navigateForward(
                                        //           MapScreenForSetLocation(
                                        //               locationName:mozdalifaLocController ,
                                        //               i: 2));
                                        //     },
                                        //     child: CustomTextField(
                                        //         validator: (String val){
                                        //           if(val.isEmpty){
                                        //             return 'برجاء تحديد موقع المزدلفه';
                                        //           }
                                        //           return null;
                                        //         },
                                        //         minHeight: 80.h,
                                        //         maxHeight: 80.h,
                                        //         isEnabled: false,
                                        //         maxWidth: 400.w,
                                        //         minWidth: 400.w,
                                        //         lines: 1,
                                        //         labelText:'موقع المزدلفه',
                                        //         controller:
                                        //         mozdalifaLocController)),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LocaleKeys.haveDisability.tr(),
                                              style:
                                                  cairoBold.copyWith(fontSize: 17),
                                            ),
                                            Switch.adaptive(
                                                value: registerCubit.isDisability,
                                                onChanged: (onChanged) {
                                                  registerCubit
                                                      .changeDisabilityValue();
                                                  print(registerCubit.isDisability);
                                                })
                                          ],
                                        ),
                                        // registerCubit.isDisability
                                        //     ? dropDownButton(
                                        //         items: registerCubit.disabilities
                                        //             .map((e) {
                                        //           return DropdownMenuItem(
                                        //             child: Text(
                                        //               e.toString(),
                                        //               style: cairoSemiBold,
                                        //             ),
                                        //             value: e.toString(),
                                        //           );
                                        //         }).toList(),
                                        //         value:
                                        //             registerCubit.chooseDisability,
                                        //         hint:
                                        //             LocaleKeys.disabilityType.tr(),
                                        //         fct: (onChange) {
                                        //           registerCubit
                                        //               .onChangeDisability(onChange);
                                        //           print(onChange);
                                        //         },
                                        //         context: context,
                                        //       )
                                        //     : const SizedBox(),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        dropDownButton(
                                          items: registerCubit
                                              .companyModel.companies!
                                              .map((e) {
                                            return DropdownMenuItem(
                                              child: Text(e.companyName!),
                                              value: e.id.toString(),
                                            );
                                          }).toList(),
                                          value: registerCubit.chooseCompany,
                                          hint: LocaleKeys.agentName.tr(),
                                          fct: (onChange) {
                                            registerCubit.onChangeCompany(onChange);
                                            print(onChange);
                                          },
                                          context: context,
                                          //  validator: () {}
                                        ),
                                        Text(LocaleKeys.requiredField,style: cairoSemiBold.copyWith(fontSize: 10,color: Colors.red),).tr(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // CustomTextField(
                                        //     context: context,
                                        //     labelText: LocaleKeys.agentName.tr(),
                                        //     maxWidth: 400.w,
                                        //     minWidth: 400.w,
                                        //     // hintText: 'اسم الوكيل',
                                        //     controller: agentNameController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys.enter_user_name
                                                //     .tr();
                                              } else if (!val.contains("@")) {
                                                return LocaleKeys
                                                    .enter_user_name_correctly
                                                    .tr();
                                              }
                                            },
                                            isRequired: true,
                                            padding: 10,
                                            minHeight: 10.h,
                                            focusNode: _emailFocus,
                                            nextFocus: _passwordFocus,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            labelText: LocaleKeys.email.tr(),
                                            // hintText: 'البريد الالكتروني',
                                            controller: emailController),

                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys.enter_password
                                                //     .tr();
                                              }else if(val.length<8){
                                                return LocaleKeys.passwordLenght.tr();
                                              }
                                              return null;
                                            },
                                            isRequired: true,
                                            padding: 10,
                                            minHeight: 10.h,
                                            focusNode: _passwordFocus,
                                            nextFocus: _confirmPasswordFocus,
                                            maxHeight: 80.h,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                registerCubit
                                                    .changeVisabilityState();
                                              },
                                              icon: registerCubit.isVisable
                                                  ? Icon(Icons.visibility_off)
                                                  : Icon(Icons.visibility),
                                            ),
                                            labelText: LocaleKeys.password.tr(),
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            secure: registerCubit.isVisable,
                                            //  hintText: 'كلمه المرور',
                                            controller: passwordController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return '';
                                                // return LocaleKeys.confirmPassword
                                                //     .tr();
                                              }else if(val.length<8){
                                                return LocaleKeys.passwordLenght.tr();
                                              }
                                              return null;
                                            },
                                            isRequired: true,
                                            padding: 10,
                                            minHeight: 10.h,
                                         //   focusNode: _confirmPasswordFocus,
                                            maxHeight: 80.h,
                                            secure: registerCubit.isVisable,
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                registerCubit
                                                    .changeVisabilityState();
                                              },
                                              icon: registerCubit.isVisable
                                                  ? const Icon(Icons.visibility_off)
                                                  : const Icon(Icons.visibility),
                                            ),
                                            labelText:
                                                LocaleKeys.confirmPassword.tr(),
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            controller: confirmPasswordController),
                                        richText(
                                            navigation: () => navigateForward(
                                                const TermsScreen()),
                                            text: LocaleKeys.whenYouRegisterYouAgree
                                                .tr(),
                                            tappedText:
                                                LocaleKeys.privacyPolicy.tr(),
                                            context: context),
                                        SizedBox(
                                          height: 15.w,
                                        ),
                                        state is RegisterLoadingState
                                            ? CircularProgressIndicator.adaptive(
                                                backgroundColor: orangeColor,
                                                valueColor:
                                                    AlwaysStoppedAnimation<Color>(
                                                  darkMainColor,
                                                ),
                                              )
                                            : mainButton(
                                                text: LocaleKeys.registerNow.tr(),
                                                color: darkMainColor,
                                                context: context,
                                                fct: () {
                                                  //   if (registerCubit.file == null) {
                                                  //   showToast(
                                                  //       text:
                                                  //       'برجاء تحديد صوره شخصية',
                                                  //       state:
                                                  //       ToastState.ERROR);
                                                  // }else
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    // else {
                                                    registerCubit.moetamerRegister(
                                                        context: context,
                                                        dateOfArrival:
                                                            dateOfArrivalController
                                                                .text,
                                                        dateOfBirth:
                                                            dateOfBirthController
                                                                .text,
                                                        dateOfDeparture:
                                                            dateOfDepartureController
                                                                .text,
                                                        maccaHotelName:
                                                            maccaHotelNameController
                                                                .text,
                                                        madinahHotelName:
                                                            madinaHotelNameController
                                                                .text,
                                                        nameAr: arabicNameController
                                                            .text,
                                                        nameEn:
                                                            englishNameController
                                                                .text,
                                                        phoneNumber:
                                                            phoneNumberController
                                                                .text,
                                                        email: emailController.text,
                                                        visaNo: visaNumberController
                                                            .text,
                                                        passportNo:
                                                            passportController.text,
                                                        borderNo:
                                                            borderNumberController
                                                                .text,
                                                        password:
                                                            passwordController.text,
                                                        confirmPassword:
                                                            confirmPasswordController
                                                                .text,
                                                        // imageFile:
                                                        //     registerCubit.file!
                                                    );
                                                    //  }
                                                  }
                                                }),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        richText(
                                            navigation: () =>
                                                navigateForward(LoginScreen(
                                                  index: 0,
                                                )),
                                            text: LocaleKeys.haveAccount.tr(),
                                            tappedText: LocaleKeys.loginNow.tr(),
                                            context: context),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          : Center(
                              child: CircularProgressIndicator.adaptive(
                              backgroundColor: orangeColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                darkMainColor, //<-- SEE HERE
                              ),
                            )),
                    );
                  });
            });
      }
    );
  }
}
