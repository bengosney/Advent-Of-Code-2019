import 'dart:async';
import 'dart:io';
import 'dart:convert';

int run(p1, p2, input) {
  int opcode = 0;
  int pos = 0;

  input[1] = p1;
  input[2] = p2;

  while (opcode != 99) {
    opcode = input[pos];

    int a = input[pos + 1];
    int b = input[pos + 2];
    int o = input[pos + 3];

    if (opcode == 1) {
      input[o] = input[a] + input[b];
    }

    if (opcode == 2) {
      input[o] = input[a] * input[b];
    }

    pos += 4;

    if (pos > input.length) {
      return -1;
    }

    opcode = input[pos];
  }

  return input[0];
}

void main() async {
  var input = new List<int>();

  String raw = await File('day2.input').readAsString();

  raw.split(",").forEach((String l) {
    input.add(int.parse(l));
  });

  int p1 = run(12, 2, List.from(input));

  print("Part 1: $p1");

  for (int x = 0; x < 100; x++) {
    for (int y = 0; y < 100; y++) {
      int p2 = run(x, y, List.from(input));
      if (p2 == 19690720) {
        int ans = 100 * x + y;
        print("Part 2: $ans");
        break;
      }
    }
  }
}
