import 'package:my_notes/utils/encrypt_util.dart';

String _data = '';

String get data => decrypt(_data);

void setData(String data) => _data = encrypt(data);
