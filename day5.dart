import 'dart:async';
import 'dart:io';
import 'dart:convert';

List<int> run(ins, int input) {
  int opcode = 0;
  int pos = 0;

  List<int> output = [];

  var getPos = (o, p) {
    switch (p[o]) {
      case 0: {
        print("getPos Mode0 ${pos+o} ${ins[pos + o]}");
        return ins[pos + o];
      }
      case 1: {
        print("getPos Mode1 ${pos + o}");
        return pos + o;
      }
    }

    throw new Exception("Unsupported param mode ${p}");
  };
  var getVal = (o, p) {
    print("getVal ${p} - ${ins[getPos(o, p)]}");
    return ins[getPos(o, p)];
  };
  var setVal = (o, v, p) {
    int pos = getPos(o, p);
    print("setVal ${v} into ${pos}");
    ins[getPos(o, p)] = v;
  };
  var parseOpcode = (o) {
    String os = "${o}".padLeft(5, '0');
    int opcode = int.parse(os.substring(os.length - 2));
    List<String> params = "${os}".substring(0, os.length - 2).split('').reversed.toList();

    List<int> ret = [opcode];
    params.forEach((p) {
        ret.add(int.parse(p));
    });

    return ret;
  };

  while (opcode != 99) {
    List<int> args = parseOpcode(ins[pos]);
    opcode = args[0];

    print("\nOpcode ${ins[pos]} p:${pos} op:${opcode} ${args}");
    switch (opcode) {
      case 1: {      
        setVal(3, getVal(1, args) + getVal(2, args), args);
        pos += 4;
        break;
      }
      case 2: {
        setVal(3, getVal(1, args) * getVal(2, args), args);
        pos += 4;
        break;
      }
      case 3: {
        setVal(1, 1, args);
        pos += 2;
        break;
      }
      case 4: {
        output.add(getVal(1, args));
        pos += 2;
        break;
      }
    };

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

  List<int> p1 = run(List.from(ins), 1);

  print("Part 1: $p1");
}
