bool hasConsec(String code) {
  RegExp regExp = RegExp(r"(\d)\1");

  return regExp.hasMatch(code);
}

bool hasConsec2(String code) {
  RegExp regExp = RegExp(r"(\d)\1+");

  return regExp
      .allMatches(code)
      .map((m) => m[0].length == 2)
      .reduce((curr, next) => curr || next);
}

bool doesIncrease(String code) {
  int prev = 0;

  for (int i = 0; i < code.length; i++) {
    int cur = int.parse(code[i]);

    if (cur < prev) {
      return false;
    }
    prev = cur;
  }

  return true;
}

void main() async {
  int l = 387638;
  int u = 919123;

  int poss1 = 0;
  int poss2 = 0;
  String code;

  for (int i = l; i <= u; i++) {
    code = "${i}";
    if (hasConsec(code) && doesIncrease(code)) {
      poss1 += 1;
      if (hasConsec2(code)) {
        poss2 += 1;
      }
    }
  }

  print("Part 1: $poss1");
  print("Part 2: $poss2");
}
