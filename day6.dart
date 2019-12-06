import 'dart:io';
import 'dart:convert';

class object {
  var parent;
  List children;
  String name;

  
}

void main() async {
  var input = List<int>();

  var lines = List();
  
  await File('day6.input')
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .forEach((String l) {
          var o = new object();
          List<String> parts = l.split(')');
          o.name = parts[0];
          o.parent = parts[1];

          lines.add(o);
  });


  print(lines);
}
