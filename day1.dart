import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() async {
  var input = new List<int>();

  await File('day1.input')
  .openRead()
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .forEach((String l) {
      input.add(int.parse(l));
  });

  int total = 0;
  input.forEach((int n) {      
      total += (n/3).floor() - 2;
  });

  print("Part 1: $total");  
}
