import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int maxDigits;

  static strToDouble(String value) {
    String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
    double _doubleValue = double.parse(_onlyDigits) / 100;
    return _doubleValue;
  }

  static doubleToStr(double value) {
    return "R\$ " + doubleToStrNoCurrency(value);
  }

  static doubleToStrNoCurrency(double value) {
    if (value == null) return "0.00";
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = formatter.format(value);
    return newText;
  }

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
