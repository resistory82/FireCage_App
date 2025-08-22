import 'dart:math';

String generateRandomUUID() {
  final random = Random();
  
  String generateHex(int length) {
    const chars = '0123456789abcdef';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
  
  // UUID Version 4 Format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
  return '${generateHex(8)}-${generateHex(4)}-4${generateHex(3)}-${generateHex(1)}${generateHex(3)}-${generateHex(12)}';
}