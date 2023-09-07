import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/location_cubit/cubit.dart';
import 'package:morshed/bloc/location_cubit/state.dart';
import 'package:morshed/bloc/show_office_provider_info/cubit.dart';
import 'package:morshed/bloc/show_office_provider_info/state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/constant/text_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/animation_component.dart';
import '../../component/navigation_functions.dart';
import '../../tranlations/locale_keys.g.dart';

class OfficesLocationScreen extends StatefulWidget {
  const OfficesLocationScreen({super.key});

  @override
  State<OfficesLocationScreen> createState() => _OfficesLocationScreenState();
}

class _OfficesLocationScreenState extends State<OfficesLocationScreen> {
  GoogleMapController? mapController;

  CameraPosition? cameraPositions;

  // var icon;
  // @override
  // void initState() {
  //   ShowOfficesAndProviderInfoCubit.get(context).addMarker();
  //   super.initState();
  // }
  // @override
  // void initState() {
  //   ShowOfficesAndProviderInfoCubit.get(context).getAllOfficesData();
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var locationCubit = LocationCubit.get(context);
    var showDataCubit = ShowOfficesAndProviderInfoCubit.get(context);
    return BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) async {},
        builder: (context, state) {
          return BlocConsumer<ShowOfficesAndProviderInfoCubit,
                  ShowOfficesAndProviderInfoState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  body: showDataCubit.isGetOfficesData == false ||
                          locationCubit.position?.latitude == null
                      ? Center(child:CircularProgressIndicator.adaptive(
                    backgroundColor: orangeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      darkMainColor, //<-- SEE HERE
                    ),
                  )): showDataCubit.getAllOffices.offices!.isEmpty
                      ? Center(
                    child: Text(
                        LocaleKeys.no_office_found.tr(),
                        textAlign: TextAlign.center,
                        style: cairoMedium.copyWith(
                          fontSize: 20,
                        )),
                  )
                      : Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.satellite,
                              gestureRecognizers: Set()
                                ..add(Factory<PanGestureRecognizer>(
                                    () => PanGestureRecognizer())),
                              onCameraMove: (CameraPosition cameraPosition) {
                                cameraPositions = cameraPosition;
                              },
                              onTap: (l) {
                                setState(() {
                                  showDataCubit.tabbed = 00;
                                });
                              },
                              initialCameraPosition: CameraPosition(
                                  zoom: 12,
                                  target: LatLng(
                                      locationCubit.position!.latitude,
                                      locationCubit.position!.longitude)),
                              onMapCreated: (GoogleMapController controller) {
                                mapController = controller;
                              },
                              myLocationEnabled: true,
                              // myLocationButtonEnabled: true,
                              // buildingsEnabled: true,
                              // compassEnabled: true,
                              markers:
                                  Set<Marker>.of(showDataCubit.officeMarkers),
                            ),
                            Visibility(
                              visible: showDataCubit.tabbed != 00,
                              child: Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Container(
                                    height: 200,
                                    padding: EdgeInsetsDirectional.all(18),
                                    margin: const EdgeInsetsDirectional.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              bottom: 18.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              'assets/images/officesName.png',
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomStart,
                                              child: Container(
                                                padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 8),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      showDataCubit
                                                          .getAllOffices
                                                          .offices![showDataCubit
                                                                  .officeId ??
                                                              0]
                                                          .name??'',
                                                      maxLines: 1,
                                                      style: cairoBold.copyWith(fontSize: 17),
                                                      //textAlign: TextAlign.center,
                                                    ),
                                                    Text(
                                                      showDataCubit
                                                          .getAllOffices
                                                          .offices![showDataCubit
                                                                  .officeId ??
                                                              0]
                                                          .address??'',
                                                      style:cairoRegular.copyWith(fontSize: 12,color: greyColor),
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                ),
                                                height: 60.h,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            CircleAvatar(
                                                backgroundColor: whiteColor,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      if (showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].latitude==null) {
                                                        showToast(
                                                            text: 'لا يوجد موقع لهذا المكتب',
                                                            state: ToastState.ERROR);
                                                      } else {
                                                        if (Platform.isIOS) {
                                                          await launchUrl(Uri.parse(
                                                              "comgooglemaps://?q=${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].latitude},"
                                                                  "${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].longitude}&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is"));
                                                        } else {
                                                          await launchUrl(Uri.parse(
                                                              'google.navigation:q='
                                                                  '${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].latitude}, '
                                                                  '${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].longitude}'
                                                                  '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                                        }
                                                      }
                                                      // await launchUrl(Uri.parse(
                                                      //     'google.navigation:q='
                                                      //     '${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].latitude??'0'}, '
                                                      //     '${showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].longitude??'0'}'
                                                      //     '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                                                    },
                                                    icon: SvgPicture.asset(
                                                        'assets/svg/Group 204376.svg'))),
                                            SizedBox(width: 10.w,),
                                            CircleAvatar(
                                                backgroundColor: whiteColor,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      launchCall(context: context, phoneNumber: showDataCubit.getAllOffices.offices![showDataCubit.officeId ?? 0].phoneNumber??'');
                                                    },
                                                    icon: SvgPicture.asset(
                                                        'assets/svg/end call.svg')))
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                );
              });
        });
  }
}
