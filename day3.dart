import 'dart:async';
import 'dart:io';
import 'dart:convert';

Map getLines(List ins) {
  var DX = {'L': -1, 'R': 1, 'U': 0, 'D': 0};
  var DY = {'L': 0, 'R': 0, 'U': 1, 'D': -1};
  var ans = {};
  

  ins.forEach((d) {
      int x = 0;
      int y = 0;
      int l = 0;
      int dis = int.parse(d.substring(1));
      String cmd = d[0];
      
      for (int i = 0; i < dis ; i++) {
        x += DX[cmd];
        y += DY[cmd];
        l += 1;
        ans["$x|$y"] = l;
      }
  });

  return ans;
}

void main() async {
  var wires = new List<List<String>>();
  
  await File('day3.test')
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

  var a = getLines(wires[0]);
  var b = getLines(wires[1]);

  var i = [];

  print(a);
  print("");
  print(b);
  print("");
  
  a.forEach((k, v) {
      print(k);
      if (b.containsKey(k)) {
        
      }
  });

  print(i);
}
