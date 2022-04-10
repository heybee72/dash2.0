import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier {
  double _totalAmount = 0.00;

  double get tAmount => _totalAmount;
  
  displayTotalAmount(double number) async {
    _totalAmount = number;
    
    await Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}