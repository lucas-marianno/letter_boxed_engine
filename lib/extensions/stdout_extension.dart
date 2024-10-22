import 'dart:io';
export 'dart:io';

extension StdoutExtension on Stdout {
  void clear() => stdout.write('\x1B[2J\x1B[0;0H');
  void clearLine() => stdout.write('\x1B[2K\r');
  void clearLineAndWrite(object) {
    stdout.write('\x1B[2K\r$object');
  }
}
