import 'dart:async';
import 'dart:io';
import 'dart:convert';

void printd(String p) {
  //print(p);
}

int run(ins, int input) {
  int opcode = 0;
  int pos = 0;

  int output;
  List<int> args;

  var getPos = (o) {
    switch (args[o]) {
      case 0:
        {
          printd("getPos Mode0 ${pos + o} ${ins[pos + o]}");
          return ins[pos + o];
        }
      case 1:
        {
          printd("getPos Mode1 ${pos + o}");
          return pos + o;
        }
    }

    throw new Exception("Unsupported param mode ${args[o]}");
  };
  var getVal = (o) {
    printd("getVal ${ins[getPos(o)]}");
    return ins[getPos(o)];
  };
  var setVal = (o, v) {
    int pos = getPos(o);
    printd("setVal ${v} into ${pos}");
    ins[getPos(o)] = v;
  };
  var parseOpcode = (o) {
    String os = "${o}".padLeft(5, '0');
    int l = os.length - 2;
    int opcode = int.parse(os.substring(l));
    List<String> params = os.substring(0, l).split('').reversed.toList();

    List<int> ret = [opcode];
    params.forEach((p) {
      ret.add(int.parse(p));
    });

    return ret;
  };

  while (opcode != 99) {
    args = parseOpcode(ins[pos]);
    opcode = args[0];

    printd("\nOpcode ${ins[pos]} p:${pos} op:${opcode} ${args}");
    switch (opcode) {
      case 1:
        {
          setVal(3, getVal(1) + getVal(2));
          pos += 4;
          break;
        }
      case 2:
        {
          setVal(3, getVal(1) * getVal(2));
          pos += 4;
          break;
        }
      case 3:
        {
          setVal(1, input);
          pos += 2;
          break;
        }
      case 4:
        {
          output = getVal(1);
          pos += 2;
          break;
        }
      case 5:
        {
          if (getVal(1) > 0) {
            pos = getVal(2);
          } else {
            pos += 3;
          }
          break;
        }
      case 6:
        {
          if (getVal(1) == 0) {
            pos = getVal(2);
          } else {
            pos += 3;
          }
          break;
        }
      case 7:
        {
          int v = 0;
          if (getVal(1) < getVal(2)) {
            v = 1;
          }
          setVal(3, v);
          pos += 4;
          break;
        }
      case 8:
        {
          int v = 0;
          if (getVal(1) == getVal(2)) {
            v = 1;
          }
          setVal(3, v);
          pos += 4;
          break;
        }
      default:
        {
          throw new Exception("Unknown opcode: ${opcode}");
        }
    }
    ;

    if (pos > ins.length) {
      throw new Exception('Position over length');
    }

    opcode = ins[pos];
  }

  return output;
}

void main() async {
  var ins = new List<int>();

  String raw = await File('day5.input').readAsString();

  raw.split(",").forEach((String l) {
    ins.add(int.parse(l));
  });

  int p1 = run(List.from(ins), 1);
  print("Part 1: $p1");

  int p2 = run(List.from(ins), 5);
  print("Part 2: $p2");
}
