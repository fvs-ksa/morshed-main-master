// import 'dart:core';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import '../../constant/const_color.dart';
//
// class RegisterModel {
//   String? nameAr;
//   String? nameEn;
//   String? phoneNumber;
//
//   //  String birthDate,
//   //   String nationality,
//   String? email;
//   String? visaNo;
//   String? passportNo;
//   String? borderNo;
//   String? maccaHotelName;
//   String? madinahHotelName;
//   String? dateOfBirth;
//   String? dateOfArrival;
//   String? dateOfDeparture;
//   String? password;
//   String? confirmPassword;
//   File? imageFile;
//
//   RegisterModel(
//       {this.maccaHotelName,
//       this.phoneNumber,
//       this.borderNo,
//       this.confirmPassword,
//       this.dateOfArrival,
//       this.dateOfBirth,
//       this.dateOfDeparture,
//       this.email,
//       this.imageFile,
//       this.madinahHotelName,
//       this.nameAr,
//       this.nameEn,
//       this.passportNo,
//       this.password,
//       this.visaNo});
//   Map<String,dynamic>toJson(){
//     return {
//     'name_ar':nameAr,
//     'name_en':nameEn,
//     'phone_number': phoneNumber,
//     'nationality': chooseNationality,
//     'birthdate': dateOfBirth,
//     'email': email,
//     'visa_number': visaNo,
//     'passport_number': passportNo,
//     'border_number': borderNo,
//     'arrival_date': dateOfArrival,
//     'departure_date': dateOfDeparture,
//     'latitude_mina': latMinna,
//     'longitude_mina': lngMinna,
//     'location_mina': meenaLoc,
//     'latitude_mozdalifa': latMozdalifa,
//     'longitude__mozdalifa': lngMozdalifa,
//     'location_mozdalifa': mozdalifaLoc,
//     'latitude_arfat': latArafa,
//     'longitude__arfat': lngArafa,
//     'location_arfat': arafaLoc,
//     'type_of_disability': isDisability ? chooseDisability : 'لاشيئ',
//     'agent_name': 'chooseCompany',
//     'password': password,
//     'disability':isDisability?1:0,
//     'password_confirmation': confirmPassword,
//     'image': isPickImage
//     ? await MultipartFile.fromFile(imageFile.path,
//     filename: 'image.jpg')
//     : null,
//     'company_id': chooseCompany,
//     'location_makkah_hotel':maccaHotelLocation,
//     'location_madinah_hotel':madinaHotelLocation,
//     'hotel_madinah':madinahHotelName,
//     'hotel_makkah':maccaHotelName,
//     'latitude_makkah':latMaccaHotel,
//     'longitude__makkah':lngMaccaHotel,
//     'latitude_madinah':latMadinaHotel,
//     'longitude__madinah':lngMadinaHotel,
//     };
//   }
// }
