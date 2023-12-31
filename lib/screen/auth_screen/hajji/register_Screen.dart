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
import 'package:morshed/constant/text_theme.dart';
import 'package:morshed/screen/inner_screen/locations/set_location_on_map.dart';
import '../../../component/custom_alert_dialog.dart';
import '../../../component/custom_drop_down.dart';
import '../../../component/cutom_text_filed.dart';
import '../../../component/info_profile_component.dart';
import '../../../component/navigation_functions.dart';
import '../../../tranlations/locale_keys.g.dart';
import '../../inner_screen/privacy_policy.dart';
import '../widget/country_picker_key.dart';
import 'login_screen.dart';
import 'dart:ui' as intel;

class RegisterScreen extends StatelessWidget {
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
  TextEditingController arafaLocController = TextEditingController();
  TextEditingController mozdalifaLocController = TextEditingController();
  TextEditingController mennaLocController = TextEditingController();
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
 // PhoneNumber number = PhoneNumber(isoCode: 'SA');
  String? numberSave;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var registerCubit = RegisterCubit.get(context);
    var accountTypeCubit = AccountTypeCubit.get(context);
    return BlocConsumer<LocationCubit,LocationState>(
      listener: (context,state){

      },
      builder: (context,state) {
        return BlocConsumer<AccountTypeCubit, AccountTypeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if(state is RegisterLoadingState){

                      showAdaptiveDialog(
                          barrierDismissible:  false,
                          context: context, builder: (context){
                        return AlertDialog.adaptive(
                              backgroundColor: Colors.transparent,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          content:Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // ClipRRect(
                                  //     borderRadius: BorderRadius.circular(20),
                                  //     child: Image.asset('assets/images/app icon.png',height: 50,width: 50,)),
                                  Text('إنتظر من فضلك',style: cairoRegular.copyWith(color: whiteColor),),
                                  Center(
                                      child: CircularProgressIndicator.adaptive(
                                        backgroundColor: orangeColor,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          darkMainColor, //<-- SEE HERE
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                    }
                    if(state is RegisterErrorState){
                      Navigator.pop(context);
                    }
                  },
                  bloc: registerCubit.viewAboveKeyBoard(),
                  builder: (context, state) {
                    return Scaffold(
                      appBar: headerAuthScreen(
                        context: context,
                        title: accountTypeCubit.isUmrah
                            ? LocaleKeys.registerNewMoetamer.tr()
                            : LocaleKeys.registerNewHajji.tr(),
                      ),
                      body:
                      registerCubit.isGetCompany &&
                              registerCubit.isGetNationality
                          ?
                      GestureDetector(
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
                                      children: [
                                        CustomTextField(
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _nameArFocus,
                                            nextFocus: _nameEnFocus,
                                            labelText:
                                                LocaleKeys.arabicNamePassport.tr(),
                                            validator: (val) {
                                              if (val.isEmpty || val == null) {
                                                return LocaleKeys
                                                    .enter_Full_arabic_name
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            controller: arabicNameController),
                                        CustomTextField(
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            focusNode: _nameEnFocus,
                                           // nextFocus: _phoneFocus,
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys
                                                    .enter_Full_english_name
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            labelText:
                                                LocaleKeys.englishNamePassport.tr(),
                                            // hintText: 'الاسم بالكامل بالانجليزيه حسب الجواز',
                                            controller: englishNameController),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LocaleKeys.profilePic.tr(),
                                              style:
                                                  cairoBold.copyWith(fontSize: 20),
                                            ),
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
                                                    minHeight: 80.h,
                                                    maxHeight: 80.h,
                                                    focusNode: _phoneFocus,
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return LocaleKeys
                                                            .enter_phone_number
                                                            .tr();
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
                                                  // CountryCodePicker(
                                                  //   onChanged: (prints) {
                                                  //     print('${prints.name}');
                                                  //     print('${prints.dialCode}');
                                                  //     numberSave = prints.name;
                                                  //   },
                                                  //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  //   initialSelection: 'SA',
                                                  //   alignLeft: true,
                                                  //   favorite: const ['SA', 'EG'],
                                                  //   //  countryFilter: const ['IT', 'FR'],
                                                  //   showFlagDialog: true,
                                                  //   showFlag: true,
                                                  //   flagWidth: 20,
                                                  //   textStyle: TextStyle(
                                                  //       locale: Locale('ar'),
                                                  //       fontSize: 10,
                                                  //       color: darkMainColor),
                                                  //   comparator: (a, b) => b.name!
                                                  //       .compareTo(a.name ?? ''),
                                                  //   //Get the country information relevant to the initial selection
                                                  //   onInit: (code) => debugPrint(
                                                  //       "on init ${code?.name} ${code?.dialCode} ${code?.name}"),
                                                  // )
                                              ),
                                              // decorationContainerWidget(
                                              //     radius: 35.sp,
                                              //     context: context,
                                              //     child: Text(
                                              //       '+966',
                                              //       style:
                                              //       cairoBold.copyWith(fontSize: 14,color: darkMainColor),
                                              //       textAlign:
                                              //       TextAlign.center,
                                              //     )),
                                            ),
                                          ],
                                        ),

                                        // SizedBox(height: 10,),
                                        // Directionality(
                                        //   textDirection:intel.TextDirection.ltr,
                                        //   child: Card(
                                        //   //  color: darkMainColor,
                                        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        //     semanticContainer: true,
                                        //
                                        //     child: Container(
                                        //       padding: EdgeInsetsDirectional.only(start: 20),
                                        //       child: InternationalPhoneNumberInput(
                                        //
                                        //
                                        //         locale: 'ar',
                                        //         hintText: LocaleKeys.phoneNumber.tr(),
                                        //         inputDecoration: InputDecoration(
                                        //             contentPadding:
                                        //                 EdgeInsetsDirectional.only(
                                        //                     top: 0, start: 10, end: 10,bottom: 0),
                                        //             constraints: BoxConstraints(
                                        //                 minHeight: 54.h,
                                        //                 minWidth: 330.w,
                                        //                 maxHeight: 60.h,
                                        //                 maxWidth: 360.w),
                                        //             // border: OutlineInputBorder(
                                        //             //     borderRadius:
                                        //             //         BorderRadius.circular(20))
                                        //         ),
                                        //         onInputChanged: (onInputChanged) {
                                        //           print(
                                        //               '/////////////////////$onInputChanged //////////////////');
                                        //           numberSave=onInputChanged.phoneNumber;
                                        //           // phoneNumberController.text=onInputChanged.phoneNumber!;
                                        //           // print('object  ${phoneNumberController.text}');
                                        //         },
                                        //         onInputValidated: (bool value) {
                                        //           print(value);
                                        //         },
                                        //         selectorConfig: SelectorConfig(
                                        //           selectorType:
                                        //               PhoneInputSelectorType.BOTTOM_SHEET,
                                        //         ),
                                        //         ignoreBlank: false,
                                        //         autoValidateMode:
                                        //             AutovalidateMode.disabled,
                                        //         // maxLength:10 ,
                                        //         textAlign: TextAlign.start,
                                        //         selectorTextStyle:
                                        //             TextStyle(color: Colors.black),
                                        //         initialValue: number,
                                        //         textFieldController:
                                        //             phoneNumberController,
                                        //         formatInput: true,
                                        //         keyboardType:
                                        //             TextInputType.numberWithOptions(
                                        //                 signed: true, decimal: true),
                                        //         inputBorder: OutlineInputBorder(
                                        //             borderRadius:
                                        //                 BorderRadius.circular(20)),
                                        //         // onFieldSubmitted: (s) {
                                        //         //  // phoneNumberController.text = s;
                                        //         //   phoneNumberController.text=numberSave!;
                                        //         //   print(
                                        //         //       '////////////?????????????${phoneNumberController.text}');
                                        //         // },
                                        //         // onSubmit: (s){
                                        //         //
                                        //         // },
                                        //         onSaved: (PhoneNumber number) {
                                        //           print('On Saved: $number');
                                        //         },
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                           CustomDropDown(),
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
                                        // decorationContainerWidget(
                                        //     radius: 35.sp,
                                        //     context: context,
                                        //     width: 100,
                                        //     child: CountryCodePicker(
                                        //       onChanged: (prints){
                                        //         print('${prints.name}');
                                        //         print('${prints.dialCode}');
                                        //       },
                                        //       // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        //       initialSelection: 'SA',
                                        //       alignLeft: true,
                                        //       favorite: const ['+20', '+966'],
                                        //       //  countryFilter: const ['IT', 'FR'],
                                        //       showFlagDialog: true,
                                        //       showFlag: true,
                                        //       flagWidth: 20,
                                        //       textStyle: TextStyle(locale: Locale('ar'),fontSize: 10,color: darkMainColor),
                                        //       comparator: (a, b) => b.name!.compareTo(a.name??''),
                                        //       //Get the country information relevant to the initial selection
                                        //       onInit: (code) => debugPrint(
                                        //           "on init ${code?.name} ${code?.dialCode} ${code?.name}"),
                                        //     )),

                                        // CustomTextField(
                                        //     onTap: (){
                                        //       showCountryPicker(
                                        //         context: context,
                                        //         //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                        //       //  exclude: <String>['KN', 'MF'],
                                        //         favorite: <String>['SA'],
                                        //        showWorldWide: true,
                                        //
                                        //         //Optional. Shows phone code before the country name.
                                        //         showPhoneCode: false,
                                        //
                                        //         onSelect: (Country country) {
                                        //           print('Select country: ${country.displayName}');
                                        //         },
                                        //         // Optional. Sets the theme for the country list picker.
                                        //         countryListTheme: CountryListThemeData(
                                        //           textStyle: TextStyle(locale:Locale('ar','AR')),
                                        //           // Optional. Sets the border radius for the bottomsheet.
                                        //           borderRadius: BorderRadius.only(
                                        //             topLeft: Radius.circular(40.0),
                                        //             topRight: Radius.circular(40.0),
                                        //           ),
                                        //           // Optional. Styles the search field.
                                        //           inputDecoration: InputDecoration(
                                        //             counterStyle: TextStyle(locale:Locale('ar','AR')),
                                        //             labelText: 'Search',
                                        //             hintText: 'Start typing to search',
                                        //             prefixIcon: const Icon(Icons.search),
                                        //             border: OutlineInputBorder(
                                        //               borderSide: BorderSide(
                                        //                 color: const Color(0xFF8C98A8).withOpacity(0.2),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           // Optional. Styles the text in the search field
                                        //           searchTextStyle: TextStyle(
                                        //             color: Colors.blue,
                                        //             fontSize: 18,
                                        //           ),
                                        //         ),
                                        //       );
                                        //     },
                                        //     isEnabled: false,
                                        //     labelText: LocaleKeys.nationality.tr()),

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
                                                  onTap: () async {
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                    await registerCubit
                                                        .chooseDateTimeForBirth(
                                                        context: context,
                                                        controller:
                                                        dateOfBirthController);
                                                    print(
                                                        "222222222222222222${dateOfBirthController.text}");
                                                    //     .then((value) {
                                                    //      // set
                                                    //   registerCubit.convertedDateTimeBirth=dateOfBirthController.text;
                                                    //   print('DATE OF BIRTH ${dateOfBirthController.text}');
                                                    // });
                                                  },
                                                  child: CustomTextField(
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return LocaleKeys
                                                            .enter_date_of_birth
                                                            .tr();
                                                      }
                                                      return null;
                                                    },
                                                    minHeight: 80.h,
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
                                                    print(
                                                        "222222222222222222${dateOfBirthController.text}");
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
                                                return LocaleKeys
                                                    .enter_Passport_number
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            labelText: LocaleKeys.passportNo.tr(),
                                            focusNode: _passportFocus,
                                            nextFocus: _visaFocus,
                                            controller: passportController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.enter_vise_no
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
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
                                                return LocaleKeys
                                                    .enter_borderOrIdOrIqama_no
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
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
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                    await registerCubit
                                                        .chooseDateTimeForArrival(
                                                        context: context,
                                                        controller:
                                                        dateOfArrivalController);
                                                    print(
                                                        "222222222222222222${dateOfArrivalController.text}");
                                                  },
                                                  child: CustomTextField(
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return LocaleKeys
                                                            .enter_arrival_date
                                                            .tr();
                                                      }
                                                      return null;
                                                    },
                                                    minHeight: 80.h,
                                                    maxHeight: 80.h,
                                                    isEnabled: false,
                                                    isTabbed: true,
                                                    labelText:
                                                        LocaleKeys.arriveDate.tr(),
                                                    onTap: () async {
                                                      await registerCubit
                                                          .chooseDateTimeForBirth(
                                                              context: context,
                                                              controller:
                                                                  dateOfArrivalController);
                                                      print(
                                                          "222222222222222222${dateOfArrivalController.text}");
                                                    },
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
                                                  FocusManager.instance.primaryFocus!.unfocus();
                                                  registerCubit
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
                                                        context: context,
                                                        controller:
                                                        dateOfDepartureController);
                                                    print(
                                                        "222222222222222222${dateOfDepartureController.text}");
                                                  },
                                                  child: CustomTextField(
                                                    validator: (String val) {
                                                      if (val.isEmpty) {
                                                        return LocaleKeys
                                                            .enter_depurate_date
                                                            .tr();
                                                      }
                                                      return null;
                                                    },
                                                    minHeight: 80.h,
                                                    maxHeight: 80.h,
                                                    isEnabled: false,
                                                    labelText:
                                                        LocaleKeys.leaveDate.tr(),
                                                    controller:
                                                        dateOfDepartureController,
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
                                                  registerCubit
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
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.enter_makka_hotel
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            focusNode: _maccaHotelFocus,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            labelText:
                                                LocaleKeys.maccaHotelName.tr(),
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
                                                  onTap: (){
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
                                                          return LocaleKeys
                                                              .macca_hotel_loc
                                                              .tr();
                                                        }
                                                        return null;
                                                      },
                                                      minHeight: 80.h,
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
                                                return LocaleKeys.madina_hotels_name
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            focusNode: _madinaHotelFocus,
                                            minWidth: 400.w,
                                            labelText:
                                                LocaleKeys.madinaHotelName.tr(),
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
                                                  onTap: (){
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                    navigateForward(
                                                        MapScreenForSetLocation(
                                                            locationName:
                                                            madinaHotelLocController,
                                                            i: 5));
                                                  },
                                                  child: CustomTextField(
                                                      validator: (String val) {
                                                        if (val.isEmpty) {
                                                          return LocaleKeys
                                                              .madina_hotel_loc
                                                              .tr();
                                                        }
                                                        return null;
                                                      },
                                                      minHeight: 80.h,
                                                      maxHeight: 80.h,
                                                      isEnabled: false,
                                                      labelText: LocaleKeys
                                                          .madina_hotel_loc
                                                          .tr(),
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
                                                  FocusManager.instance.primaryFocus!.unfocus();
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
                                        GestureDetector(
                                          onTap: () {
                                            FocusManager.instance.primaryFocus!.unfocus();
                                            navigateForward(MapScreenForSetLocation(
                                                locationName: mennaLocController,
                                                i: 0));
                                          },
                                          child: CustomTextField(
                                              validator: (String val) {
                                                if (val.isEmpty) {
                                                  return LocaleKeys.menna_loc.tr();
                                                }
                                                return null;
                                              },
                                              minHeight: 80.h,
                                              maxHeight: 80.h,
                                              isEnabled: false,
                                              maxWidth: 400.w,
                                              minWidth: 400.w,
                                              lines: 1,
                                              labelText: LocaleKeys.menna_loc.tr(),
                                              controller: mennaLocController),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            FocusManager.instance.primaryFocus!.unfocus();
                                            navigateForward(MapScreenForSetLocation(
                                                locationName: arafaLocController,
                                                i: 1));
                                          },
                                          child: CustomTextField(
                                              validator: (String val) {
                                                if (val.isEmpty) {
                                                  return LocaleKeys.arafa_loc.tr();
                                                }
                                                return null;
                                              },
                                              minHeight: 80.h,
                                              maxHeight: 80.h,
                                              isEnabled: false,
                                              maxWidth: 400.w,
                                              minWidth: 400.w,
                                              lines: 1,
                                              labelText: LocaleKeys.arafa_loc.tr(),
                                              controller: arafaLocController),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus!.unfocus();
                                              navigateForward(
                                                  MapScreenForSetLocation(
                                                      locationName:
                                                          mozdalifaLocController,
                                                      i: 2));
                                            },
                                            child: CustomTextField(
                                                validator: (String val) {
                                                  if (val.isEmpty) {
                                                    return LocaleKeys.mozdalifa_loc
                                                        .tr();
                                                  }
                                                  return null;
                                                },
                                                minHeight: 80.h,
                                                maxHeight: 80.h,
                                                isEnabled: false,
                                                maxWidth: 400.w,
                                                minWidth: 400.w,
                                                lines: 1,
                                                labelText:
                                                    LocaleKeys.mozdalifa_loc.tr(),
                                                controller:
                                                    mozdalifaLocController)),
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
                                        registerCubit.isDisability
                                            ? dropDownButton(
                                                items: registerCubit.disabilities
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                      e.toString(),
                                                      style: cairoSemiBold,
                                                    ),
                                                    value: e.toString(),
                                                  );
                                                }).toList(),
                                                value:
                                                    registerCubit.chooseDisability,
                                                hint:
                                                    LocaleKeys.disabilityType.tr(),
                                                fct: (onChange) {
                                                  registerCubit
                                                      .onChangeDisability(onChange);
                                                  print(onChange);
                                                },
                                                context: context,
                                              )
                                            : const SizedBox(),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        dropDownButton(
                                          items: registerCubit
                                              .companyModel.companies!
                                              .map((e) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                e.companyName??'',
                                                style: cairoSemiBold,
                                              ),
                                              value: e.id==null?e.id:e.id.toString(),
                                            );
                                          }).toList(growable: false),
                                          value: registerCubit.chooseCompany,
                                          hint: LocaleKeys.agentName.tr(),
                                          fct: (onChange) {
                                            registerCubit.onChangeCompany(onChange);
                                            print(onChange);
                                          },
                                          context: context,
                                          //  validator: () {}
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.enter_user_name
                                                    .tr();
                                              } else if (!val.contains("@")) {
                                                return LocaleKeys
                                                    .enter_user_name_correctly
                                                    .tr();
                                              }
                                            },
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                             focusNode: _emailFocus,
                                            nextFocus: _passwordFocus,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            labelText: LocaleKeys.email.tr(),
                                            controller: emailController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.enter_password
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
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
                                            focusNode: _passwordFocus,
                                            nextFocus: _confirmPasswordFocus,
                                            maxWidth: 400.w,
                                            minWidth: 400.w,
                                            secure: registerCubit.isVisable,
                                            //  hintText: 'كلمه المرور',
                                            controller: passwordController),
                                        CustomTextField(
                                            validator: (String val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.confirmPassword
                                                    .tr();
                                              }
                                              return null;
                                            },
                                            minHeight: 80.h,
                                            maxHeight: 80.h,
                                            focusNode: _confirmPasswordFocus,
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
                                       // state is RegisterLoadingState && registerCubit.registerLoading==false
                                       //      ?CircularProgressIndicator.adaptive(
                                       //   backgroundColor: orangeColor,
                                       //   valueColor:
                                       //   AlwaysStoppedAnimation<Color>(
                                       //     darkMainColor,
                                       //   ),
                                       // )
                                       //      :
                                       mainButton(
                                                text: LocaleKeys.registerNow.tr(),
                                                color: darkMainColor,
                                                context: context,
                                                fct: () {
                                                  FocusManager.instance.primaryFocus!.unfocus();
                                                    if (registerCubit.file == null) {
                                                    showToast(
                                                        text:
                                                        'برجاء تحديد صوره شخصية',
                                                        state:
                                                        ToastState.ERROR);
                                                  }else{
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        // else {
                                                        registerCubit.hajjiRegister(
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
                                                            phoneNumber:numberSave ?? '+966' + phoneNumberController.text,
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
                                                            // registerCubit.file!
                                                        );
                                                      }
                                                    }

                                                  print(numberSave ??
                                                      '+966' +
                                                          phoneNumberController
                                                              .text);
                                                }),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        richText(
                                            navigation: () =>
                                                navigateForward(LoginScreen(
                                                  index: 1,
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
