import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/guides_cubit/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/component/guide_escorts_component.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/guides_cubit/cubit.dart';
import '../../component/gesut_widget.dart';
import '../../component/navigation_functions.dart';
import '../../constant/const_color.dart';
import '../../constant/text_theme.dart';
import '../../tranlations/locale_keys.g.dart';
import 'chat_with_guides.dart';

class GuidesScreen extends StatefulWidget {
  int? index;

  GuidesScreen({this.index});

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var guidesCubit = GuidesCubit.get(context);
    return   BlocConsumer<GuidesCubit, GuidesState>(
        // bloc: guidesCubit.getAllGuides(),
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: RefreshIndicator(
              onRefresh: () async{
                await Future.delayed(Duration(seconds: 1));
                return guidesCubit.getAllGuides();
              },
              child: Scaffold(
                // appBar: AppBar(
                //   leading: backButtonWidget(context: context),
                //   title: const Text('المرشدين'),
                //   centerTitle: true,
                //   actions: [SvgPicture.asset('assets/svg/')],
                //   backgroundColor: whiteColor,
                //   // toolbarHeight: 180.h,
                //   bottom: PreferredSize(
                //       preferredSize: Size.fromHeight(120.h),
                //       child: Padding(
                //         padding:
                //         EdgeInsetsDirectional.only(start: 18.0.w, end: 18.w,bottom: 18.h),
                //         child:  const AutoSizeText('خدمه البحث عن طريق الاسم ورقم الجوال ما زالت تحت التطوير',maxLines: 1,style: TextStyle(
                //             color: Colors.red,
                //            // fontFamily: 'cairo',
                //             fontWeight: FontWeight.bold
                //
                //         )),
                //         // child: Row(
                //         //   children: [
                //         //     Expanded(
                //         //         child: textFormField(
                //         //             labelText: 'البحث عن طريق الاسم او رقم الجواز',
                //         //             context: context)),
                //         //     SizedBox(
                //         //       width: 12.w,
                //         //     ),
                //         //     Padding(
                //         //       padding: EdgeInsetsDirectional.only(bottom: 14.0.h),
                //         //       child: mainButton(
                //         //           width: 73.w,
                //         //           height: 54.h,
                //         //           text: 'بحث',
                //         //           color: darkMainColor,
                //         //           context: context,
                //         //           fct: () {}),
                //         //     )
                //         //   ],
                //         // ),
                //       )),
                // ),
                appBar: headerForGuide(
                    context: context,
                    title: widget.index == 1
                        ?LocaleKeys.videoCall.tr()
                        : LocaleKeys.guides.tr(),
                    searchController: searchController,
                    dropDownWidget: widget.index == 1
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsetsDirectional.only(start: 10.w),
                            height: 90.h,
                            width: 88.w,
                            child: dropDownButton(
                              items: guidesCubit.flags.map((e) {
                                return DropdownMenuItem(
                                  child: Image.asset(e["flag"].toString()),
                                  value: e['id'].toString(),
                                );
                              }).toList(),
                              value: guidesCubit.flag,
                              isFlag: true,
                              hint: LocaleKeys.country.tr(),
                              fct: (onChange) {
                                guidesCubit.onChangeFlagsSearch(onChange);
                                print(onChange);
                              },
                              context: context,
                              //  validator: () {}
                            ),
                          ),
                    fct: () {
                      searchController.text.isEmpty&&guidesCubit.flag==null
                          ? null
                          : guidesCubit.searchProvider(
                              name: searchController.text,
                              langId: guidesCubit.flag ?? '');
                    }),
                backgroundColor: whiteGreyColor,
                body:token==null?GuestWidget(): guidesCubit.isProvidersGet
                    ? guidesCubit.getProvidersModel.providers!.isEmpty
                        ?

                ListView(

                  children: [

                    Container(
                      alignment: AlignmentDirectional.center,
                      height:
                      MediaQuery.of(context).size.height / 1.5,
                      child: Text(
                        LocaleKeys.no_service_provider.tr(),
                        style: cairoMedium.copyWith(fontSize: 20),
                      ),
                    ),
                    // Container(
                    //   alignment: AlignmentDirectional.center,
                    //     child: Text(
                    //   LocaleKeys.no_reports.tr(),
                    //   style: cairoMedium.copyWith(fontSize: 20),
                    // ))
                  ],
                )
                // Center(
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(
                //                 LocaleKeys.no_service_provider.tr(),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ),
                //           )
                        : Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 10.h, start: 8.w, end: 8.w),
                          child: ListView.builder(
                              itemCount: guidesCubit
                                  .getProvidersModel.providers!.length,
                              itemBuilder: (context, index) {
                                return itemContainerOfGuidesAndEscorts(
                                  isGuides: true,
                                    language: guidesCubit.getProvidersModel.providers![index].preferredLanguage=="1"?'العربية':"الإنجليزية",
                                    context: context,
                                    image: 'assets/images/profile.png',
                                    name: guidesCubit.getProvidersModel
                                        .providers![index].name!,
                                    phone: guidesCubit.getProvidersModel
                                        .providers![index].phoneNumber!,

                                    contactColumn: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        circleAvtarWidget(
                                            svgImage:
                                                'assets/svg/end call.svg',
                                            fct: () async {
                                              makePhoneCall(guidesCubit
                                                  .getProvidersModel
                                                  .providers![index]
                                                  .phoneNumber!);
                                            }),
                                        circleAvtarWidget(
                                            svgImage: 'assets/svg/msg.svg',
                                            fct: () {
                                              //  showToast(text:LocaleKeys.service_under_development.tr(), state: ToastState.WARNING);
                                              navigateForward(
                                                  ChatWithGuidesScreen(
                                                    name: guidesCubit
                                                        .getProvidersModel
                                                        .providers![index]
                                                        .name
                                                        .toString(),
                                                channelName: guidesCubit
                                                    .getProvidersModel
                                                    .providers![index]
                                                    .id!,
                                              ));
                                            })
                                      ],
                                    ));
                              }),
                        )
                    : Center(
                        child: CircularProgressIndicator.adaptive(
                        backgroundColor: orangeColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          darkMainColor, //<-- SEE HERE
                        ),
                      )),
              ),
            ),
          );
        });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
