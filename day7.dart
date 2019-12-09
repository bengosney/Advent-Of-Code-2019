import 'dart:io';

void printd(String p) {
  //print(p);
}

int run(ins, int input) {
  int opcode = 0;
  int pos = 0;

  //List<int> output = List<int>();
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

    throw Exception("Unsupported param mode ${args[o]}");
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
        setVal(1, input);
        pos += 2;
        break;
      case 4:
        {
          //output.add(getVal(1));
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
          throw Exception("Unknown opcode: ${opcode}");
        }
    }
    ;

    if (pos > ins.length) {
      throw Exception('Position over length');
    }

    opcode = ins[pos];
  }

  return output;
}

void main() async {
  var ins = List<int>();

  String raw = await File('day7.test').readAsString();

  raw.split(",").forEach((String l) {
    ins.add(int.parse(l));
  });

  int max = 0;
  
  for (int i = 0; i < 99999; i++) {
    var inp = "${i}".padLeft(5, '0').split("").map(int.parse).toList();
    int c = 0;
    print(inp);
    inp.forEach((k) {
        c += run(List.from(ins), k);
    });
    if (c > max) {
      max = c;
    }
  }

  print("Part 1: $max");
}
