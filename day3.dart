import 'dart:async';
import 'dart:io';
import 'dart:convert';


void main() async {
  var wires = new List<List<String>>();
  
  await File('day3.input')
  .openRead()
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .forEach((String l) {
      var cmds = new List<String>();
      l.split(",").forEach((String c) {
          cmds.add(c);
      });
      wires.add(cmds);
  });

  var grid = new List<List<String>>();
  
  wires.forEach((w) {
      print("Wire: ${w}");
  });
}
