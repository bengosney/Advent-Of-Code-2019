import 'dart:io';
import 'dart:convert';


void main() async {
  var input = List<int>();

  var objects = {};

  int sumLinks(String of, int level) {
    int total = level;

    if (objects.containsKey(of)) {
      objects[of].forEach((i) => total += sumLinks(i, level + 1));
    }

    return total;
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
  });

  int total = sumLinks('COM', 0);
  print("Part 1: ${total}");
}
