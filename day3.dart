import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

Map getLines(List ins) {
  var DX = {'L': -1, 'R': 1, 'U': 0, 'D': 0};
  var DY = {'L': 0, 'R': 0, 'U': 1, 'D': -1};
  var ans = {};
  
  int x = 0;
  int y = 0;
  int l = 0;
  ins.forEach((d) {
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

  var a = getLines(wires[0]);
  var b = getLines(wires[1]);

  var i = [];

  var mh_dist = 99999999;
  var sh_dist = 99999999;
  
  a.forEach((k, v) {      
      if (b.containsKey(k)) {
        var parts = k.split('|');
        
        int x = int.parse(parts[0]).abs();
        int y = int.parse(parts[1]).abs();
        int mh = x + y;

        if (mh_dist > mh) {
          mh_dist = mh;
        }

        int dist = a[k] + b[k];
        if (sh_dist > dist) {
          sh_dist = dist;
        }
      }
  });

  print("Part 1: ${mh_dist}");
  print("Part 2: ${sh_dist}");
}
