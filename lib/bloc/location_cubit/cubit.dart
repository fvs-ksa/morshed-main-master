import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/location_cubit/state.dart';

import '../../constant/const_color.dart';

class LocationCubit extends Cubit<LocationState>{
  LocationCubit():super(InitialLocationState());
  static LocationCubit get(context)=>BlocProvider.of(context);
  Future<Position> determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      AppSettings.openAppSettings(type: AppSettingsType.location);
     // AppSettings.openLocationSettings();

      return Future.error(
          'Location Service are denied/////////////////////////');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Service are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permision are denied permanently, we cannot request permission');
    }
    return Geolocator.getCurrentPosition();
  }

  String cityName = '';
  bool isLoading = false;
  String address='';

  void getPlace(Position pos, BuildContext context) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
      localeIdentifier: context.locale.languageCode,
    );
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String street = placeMark.street.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    address = subLocality +
        ',' +
        street +
        ',' +
        locality +
        ',' +
        postalCode +
        ',' +
        administrativeArea +
        ',' +
        country +
        ',' +
        name;
    isLoading = true;
    cityName = placeMark.locality.toString();
    print('address $address');
    print(placeMark.locality.toString());
    emit(GetPlacesSuccessState());
    print(pos.longitude);
  }



  Future<dynamic> getUserCurrentLocation(BuildContext context) async {
    emit(GetUserCurrentLocation());
    await determinePosition().then((value) => getPlace(value, context));

  }
  LatLng? latLn;
  String addressFromMap = '';
  getLocationFromMap(cameraPositions) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(
        cameraPositions.target.latitude, cameraPositions.target.longitude,
        localeIdentifier: myLocale.toString());
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String street = placeMark.street.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String address =
        name + ',' + street + ',' + locality + ',' + postalCode + ',' + country;
    print(address);
    addressFromMap = address;
    latLn = LatLng(
        cameraPositions.target.latitude, cameraPositions.target.longitude);
    print('${latLn?.latitude}latLn?.latitude');
    lat=latLn?.latitude;
    lng=latLn?.longitude;
    print('$lat ////// $lng');
    // address='';
    emit(ConvertLocationFromMapSuccessState());
    print('///////////////////////// $addressFromMap');
  }
  Position? position;

  void getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    try {
      position = await GeolocatorPlatform.instance.getCurrentPosition();
      print('location:${position!.longitude}');
      lat=position!.latitude;
      lng=position!.longitude;
      print('Lat :$lat');
      print('Lat :$lng');
      final coordinate = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      // currentLocation=await Location().getLocation();
      var first = coordinate.first;
      print("${first.name} : ${first..administrativeArea}");
      print(position!.longitude.toString());
      emit(GetCurrentLocationSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetCurrentLocationErrorState(
        error: e.toString(),
      ));
    }
  }
  // getStringAddress(int i){
  //
  //   if(i == 3) {
  //     reportLocation = addressFromMap;
  //     emit(ChangeAddressState());
  //     addressFromMap = '';
  //   }
  // }

  getStringAddress({required int i, required TextEditingController controller}) {
    if (i == 0) {
      controller.clear();
      meenaLoc = addressFromMap;
      controller.text=addressFromMap;
      latMinna = lat;
      lngMinna = lng;
      emit(ChangeAddressState());
      print('controller ${controller.text}');
      addressFromMap = '';
    } else if (i == 1) {
      controller.clear();
      arafaLoc = addressFromMap;
      controller.text=addressFromMap;
      latArafa = lat;
      lngArafa = lng;
      emit(ChangeAddressState());
      print('controller ${controller.text}');
      addressFromMap = '';
    } else if (i == 3) {
      controller.clear();
      reportLocation = addressFromMap;
      controller.text=addressFromMap;
      print('controller ${controller.text}');
      emit(ChangeAddressState());
      addressFromMap = '';
    } else if (i == 4) {
      controller.clear();
      maccaHotelLocation = addressFromMap;
      controller.text=addressFromMap;
      latMaccaHotel = lat;
      lngMaccaHotel = lng;
      print('controller ${controller.text}');
      emit(ChangeAddressState());
      addressFromMap = '';
    } else if (i == 5) {
      controller.clear();
      madinaHotelLocation = addressFromMap;
      controller.text=addressFromMap;
      latMadinaHotel = lat;
      lngMadinaHotel = lng;
      print('controller ${controller.text}');
      emit(ChangeAddressState());
      addressFromMap = '';
    } else {
      controller.clear();
      mozdalifaLoc = addressFromMap;
      controller.text=addressFromMap;
      latMozdalifa = lat;
      lngMozdalifa = lng;
      emit(ChangeAddressState());
      print('controller ${controller.text}');
      addressFromMap = '';

    }
  }
}