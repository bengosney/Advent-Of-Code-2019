import 'dart:io';
import 'dart:convert';
import 'dart:math';

Map getLines(List ins) {
  Map DX = {'L': -1, 'R': 1, 'U': 0, 'D': 0};
  Map DY = {'L': 0, 'R': 0, 'U': 1, 'D': -1};
  Map ans = {};

  int x = 0;
  int y = 0;
  int l = 0;
  ins.forEach((d) {
    int dis = int.parse(d.substring(1));
    String cmd = d[0];

    for (int i = 0; i < dis; i++) {
      x += DX[cmd];
      y += DY[cmd];
      l += 1;
      ans["$x|$y"] = l;
    }
  });

  return ans;
}

void main() async {
  var wires = List<List<String>>();

  await File('day3.input')
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .forEach((String l) {
    List cmds = List<String>();
    l.split(",").forEach((String c) {
      cmds.add(c);
    });
    wires.add(cmds);
  });

  Map a = getLines(wires[0]);
  Map b = getLines(wires[1]);

  var mh_dists = List<int>();
  var sh_dists = List<int>();

  a.forEach((k, v) {
    if (b.containsKey(k)) {
      List parts = k.split('|').map((String s) => int.parse(s).abs()).toList();

      mh_dists.add(parts[0] + parts[1]);
      sh_dists.add(a[k] + b[k]);
    }
  });

  int mh_dist = mh_dists.reduce(min);
  int sh_dist = sh_dists.reduce(min);

  print("Part 1: ${mh_dist}");
  print("Part 2: ${sh_dist}");
}
