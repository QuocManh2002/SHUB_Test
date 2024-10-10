import 'package:form_field_validator/form_field_validator.dart';

class DoubleValidator extends TextFieldValidator {  
  DoubleValidator({String errorText = '"Invalid number"'}) : super(errorText);
  
  @override
  bool isValid(String? value) {
    try{
        double.parse(value!);
        return true;
      } catch(error){
        return false;
      }
  } 
}