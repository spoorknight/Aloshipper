// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'logger.dart';

class GeolocatorHelper {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Logger.d('LOCATION ERROR', 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Logger.d('LOCATION ERROR', 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Logger.d('LOCATION ERROR',
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Future<MyCurrentAddress?> getCurrentPosition() async {
    try {
      final Position position = await determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final placeMark = placemarks.first;

      final MyCurrentAddress myCurrentAddress = MyCurrentAddress(
        latitude: position.latitude,
        longitude: position.longitude,
        country: placeMark.country,
        province: placeMark.administrativeArea,
        district: placeMark.subAdministrativeArea,
        commune: placeMark.locality,
        street: placeMark.thoroughfare,
        detailAddress: placeMark.subThoroughfare,
        fullAddress: getFullAddress(
          detailAddr: placeMark.subThoroughfare,
          street: placeMark.thoroughfare,
          commune: placeMark.subLocality,
          district: placeMark.subAdministrativeArea,
          province: placeMark.administrativeArea,
        ),
      );
      Logger.d('PLACEMARKS', placemarks);
      Logger.d('POSITION', myCurrentAddress);

      return myCurrentAddress;
    } catch (e) {
      Logger.d('ERROR', e);

      return null;
    }
  }

  String getFullAddress({
    String? detailAddr,
    String? street,
    String? commune,
    String? district,
    String? province,
  }) {
    try {
      final List<String> fullAddress = [
        detailAddr ?? '',
        street ?? '',
        commune?.split('.').last.trim() ?? '',
        district?.split('.').last.trim() ?? '',
        province ?? '',
      ];
      fullAddress.removeWhere((e) => e.isEmpty);
      return fullAddress.join(', ');
    } catch (e) {
      return '';
    }
  }
}

class MyCurrentAddress {
  double? latitude;
  double? longitude;
  String? country;
  String? province;
  String? district;
  String? commune;
  String? street;
  String? detailAddress;
  String? fullAddress;
  MyCurrentAddress({
    this.latitude,
    this.longitude,
    this.country,
    this.province,
    this.district,
    this.commune,
    this.street,
    this.detailAddress,
    this.fullAddress,
  });

  @override
  String toString() {
    return '''MyCurrentAddress(
     latitude: $latitude,
     longitude: $longitude,
     country: $country,
     province: $province,
     district: $district,
     commune: $commune,
     street: $street,
     detailAddress: $detailAddress,
     fullAddress: $fullAddress)''';
  }
}
