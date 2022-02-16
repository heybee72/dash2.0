import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:io';

class HelperMethods {
  static getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    print("symbol: ${format.currencySymbol}");
    return format.currencySymbol.toString();
  }

    static  converAmt(double amt) {
      return intl.NumberFormat.decimalPattern().format(amt);
    }
}
