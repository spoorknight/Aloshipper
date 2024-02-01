import 'dart:io';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  double calculateFeeOrderAndBooking(
      {required double firstFee,
      required double distance,
      required double feeForOneKilometer}) {
    if (firstFee < 1) {
      firstFee = feeForOneKilometer;
    }
    if (distance <= 1) {
      return firstFee;
    }
    return firstFee + ((distance - 1) * feeForOneKilometer);
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  launchPhone(String? phone) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phone ?? '',
    );
    await launchUrlString(launchUri.toString());
  }

  launchZalo(String? phoneNumber) async {
    // String url = 'https://chat.zalo.me/?phone=$phoneNumber';
    String url = 'https://zalo.me/$phoneNumber';

    if (Platform.isAndroid) {
      url = 'tel:$phoneNumber';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở ứng dụng Zalo';
    }
  }

  launchMessenger(String? facebookId) async {
    final url = 'https://www.messenger.com/t/$facebookId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Không thể mở ứng dụng mesenger';
    }
  }

  List<String> generateSuggestAmountList(
      {required int n, int min = 1000, int max = 100000000}) {
    List<String> result = [];
    String inputString = n.toString();

    int goiYNumber = int.parse(inputString);
    int count = 0;

    while (goiYNumber <= max && count < 3) {
      if (goiYNumber >= min) {
        String goiYValue = goiYNumber.toString();
        // String formattedValue = goiYValue.replaceAllMapped(
        //   RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        //   (Match match) => '${match.group(1)},',
        // );
        result.add(goiYValue);
        count++;
      }
      goiYNumber *= 10;
    }

    return result;
  }

  convertToString(dynamic data) {
    if (data == null) return null;
    if (data is String) return data;
    return data.toString();
  }

  calculatorTimeResetTime({required int resetTime, String? updateAt}) {
    final currentTime = DateTime.now();
    final createdAtDateTime =
        updateAt == null ? currentTime : DateTime.parse(updateAt);
    final resetDateTime = createdAtDateTime.add(Duration(seconds: resetTime));
    final differenceInSeconds = resetDateTime.difference(currentTime).inSeconds;
    return differenceInSeconds > 0 ? differenceInSeconds : 0;
  }
}
