import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';

bool isLength(String code) {
  return code.length == 6;
}

bool hasConsec(String code) {
  RegExp regExp = new RegExp(r"(\d)\1");
  
  return regExp.hasMatch(code);
}

bool doesIncrease(String code) {
  int prev = 0;
  
  for(int i=0; i < code.length; i++) {
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
 
  int pos = 0;
  String code;
  
  for (int i = l ; i <= u ; i++) {
    code = "${i}";
    if (hasConsec(code) && doesIncrease(code)) {
      pos += 1;
    }
  }

  print("Part 1: $pos");
}
