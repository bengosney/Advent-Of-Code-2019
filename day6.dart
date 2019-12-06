import 'dart:io';
import 'dart:convert';

void main() async {
  List<int> input = List<int>();

  Map objects = {};
  Map objects2 = {};

  int sumLinks(String of, int level) {
    int total = level;

    if (objects.containsKey(of)) {
      objects[of].forEach((i) => total += sumLinks(i, level + 1));
    }

    return total;
  }

  List<String> walkParents(String start) {
    List<String> o = List<String>();
    String c = objects2[start];

    do {
      o.add(c);
      c = objects2[c];
    } while(c != 'COM');

    return o;
  }
  

  await File('day6.input')
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .forEach((String l) {
    List<String> parts = l.split(')');
    if (!objects.containsKey(parts[0])) {
      objects[parts[0]] = [];
    }
    objects[parts[0]].add(parts[1]);
    objects2[parts[1]] = parts[0];
  });

  int total = sumLinks('COM', 0);
  print("Part 1: ${total}");
  List<String> you = walkParents('YOU');
  List<String> san = walkParents('SAN');

  int you_c = 0;
  you.forEach((i) {
      if (!san.contains(i)) {
        you_c++;
      }
  });

  int san_c = 0;
  san.forEach((i) {
      if (!you.contains(i)) {
        san_c++;
      }
  });

  int hops = you_c + san_c;
  
  print("Part 2: $hops");
}
