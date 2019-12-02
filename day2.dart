import 'dart:async';
import 'dart:io';
import 'dart:convert';

int fuelReq(int weight) {
  int req = (weight / 3).floor() - 2;

  if (req > 0) {
    return req + fuelReq(req);
  } else {
    return 0;
  }
}

void main() async {
  var input = new List<int>();

  String raw = await File('day2.test').readAsString();

  raw.split(",").forEach((String l) {
      input.add(int.parse(l));
  });

  int opcode = 0;
  int pos = 0;

  while(opcode != 99) {
    opcode = input[pos];
    print("opcode: $opcode, pos: $pos");

    if (opcode == 1) {
      input[pos + 3] = input[pos + 1] + input[pos + 2];
      var o = pos + 3;
      var a = input[pos + 1];
      var b = input[pos + 2];
      print("$o = $a + $b");
    }
    if (opcode == 2) {
      input[pos + 3] = input[pos + 1] * input[pos + 2];
      var o = pos + 3;
      var a = input[pos + 1];
      var b = input[pos + 2];
      print("$o = $a * $b");
    }
    print(input);

    pos += 4;
    if (pos >= input.length) {
      pos -= (input.length - 1);
    }
    opcode = input[pos];  
  }

  print(input[0]);
}
