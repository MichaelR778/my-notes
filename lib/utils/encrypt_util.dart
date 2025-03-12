import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';

// placeholder values
enc.IV _iv = enc.IV(Uint8List.fromList([177, 013]));
enc.Key _key = enc.Key.fromUtf8('my 32 length key................');
enc.Encrypter _encrypter = enc.Encrypter(enc.AES(_key));

// set key
void changeKey(String newKey) {
  if (newKey.isEmpty) throw Exception('Keyword can\'t be empty');

  final len = newKey.length;
  if (len > 32) throw Exception('Max keyword length is 32');

  _iv = enc.IV(Uint8List.fromList(utf8.encode(newKey)));
  _key = enc.Key.fromUtf8(newKey.padRight(32, '.'));
  _encrypter = enc.Encrypter(enc.AES(_key));
}

String encrypt(String plainText) {
  return _encrypter.encrypt(plainText, iv: _iv).base64;
}

String decrypt(String encrypted) {
  try {
    final decrypted = _encrypter.decrypt64(encrypted, iv: _iv);
    return decrypted;
  } catch (e) {
    return 'Decryption failed';
  }
}
