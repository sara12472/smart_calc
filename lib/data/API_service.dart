import 'dart:ffi';

import 'package:smart_calc/Networking/API_network.dart';

class ApiService {
  Future<dynamic> getCurrencyData(String from, String to, double amount) async {
    NetworkHelper networkHelper = NetworkHelper(
      'https://api.frankfurter.app/latest?amount=$amount&from=$from&to=$to',
      null,
    );

    var currencyData = await networkHelper.getData();
    print("Conversion Data: $currencyData");
    return currencyData;
  }

  // List of currencies (for dropdown)
  Future<dynamic> getCurrencies() async {
    NetworkHelper networkHelper = NetworkHelper(
      'https://api.frankfurter.app/currencies',
      null,
    );

    var currencies = await networkHelper.getData();
    print("Currencies: $currencies");
    return currencies;
  }

  Future<dynamic> getUnitData(String from, String to, double value) async {
    NetworkHelper unitNetworkHelper = NetworkHelper(
      'https://converter.pluginapi.xyz/convert?value=$value&from=$from&to=$to',
      null,
    );

    var unitData = unitNetworkHelper.getData();
    print(unitData);
    return unitData;
  }

  Future<dynamic> getCalenderData(String from, String to, String date) async {
    String endpoint = "";
    if (from == "Gregorian" && to == "Hijri") {
      endpoint = "gToH";
    } else if (from == "Hijri" && to == "Gregorian") {
      endpoint = "hToG";
    }
    NetworkHelper calenderNetworkHelper = NetworkHelper(
      'https://api.aladhan.com/v1/$endpoint/$date',
    );

    var calenderData = await calenderNetworkHelper.getData();
    print(calenderData);
    return calenderData;
  }
}
