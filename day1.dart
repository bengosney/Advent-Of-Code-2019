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
  var input = List<int>();

  await File('day1.input')
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .forEach((String l) {
    input.add(int.parse(l));
  });

  int total1 = 0;
  input.forEach((int n) {
    total1 += (n / 3).floor() - 2;
  });

  print("Part 1: $total1");

  int total2 = 0;
  input.forEach((int n) {
    total2 += fuelReq(n);
  });

  print("Part 2: $total2");
}
