import 'package:cook_book/ReceiptSteps.dart';

class Receipt{
  String _title;
  String _descriptions;
  ReceiptSteps _steps;
  String _ingredients;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get descriptions => _descriptions;

  set descriptions(String value) {
    _descriptions = value;
  }

  String get ingredients => _ingredients;

  set ingredients(String value) {
    _ingredients = value;
  }

  ReceiptSteps get steps => _steps;

  set steps(ReceiptSteps value) {
    _steps = value;
  }


}