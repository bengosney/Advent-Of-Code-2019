import 'dart:async';
import 'dart:io';
import 'dart:convert';


void main() async {
  var input = new List<int>();

  String raw = await File('day2.input').readAsString();

  raw.split(",").forEach((String l) {
      input.add(int.parse(l));
  });

  int opcode = 0;
  int pos = 0;

  input[1] = 12;
  input[2] = 2;

  while(opcode != 99) {
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
    
    opcode = input[pos];
  }

  print("Part 1: ${input[0]}");
}
