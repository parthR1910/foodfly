
import 'package:easy_localization/easy_localization.dart';

extension DateTimeFormateExtention on DateTime{
  String format(String format){
    return DateFormat(format).format(this);
  }
}