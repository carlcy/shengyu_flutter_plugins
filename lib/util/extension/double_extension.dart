
import 'package:decimal/decimal.dart';

extension DoubleExtension on double? {
  double get nullSafe => this ?? 0;

  /// 如果小于等于零返回零，否则返回本身
  double get gtz {
    if(this==null || this!<=0){
      return 0;
    }else{
      return this!;
    }
  }
}

extension DoubleDecimalExtension on double {
  Decimal toDecimal() {
    return Decimal.parse(toString());
  }
}

extension DecimalOperationExtension on Decimal {
  double toDoubleAsFixed(int fractionDigits) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}