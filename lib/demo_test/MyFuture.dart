import 'dart:io';

/**
 * 这里我们一定会调用runApp方法，这个方法可以说是Flutter程序的入口：
 */
void main() async {
  print('hello2');
  var t1 = DateTime.now().millisecondsSinceEpoch;
  // replace callFuns() with callFuns2()
  await callFuns2();
  var t2 = DateTime.now().millisecondsSinceEpoch;
  print('cost ${t2 - t1}');
}

void toExect() async {
  var future = await Future(() {
    print("哈哈哈");
  });
  print("111");
}

void future1() async {
  int value = 0;
  print('执行future1');
  sleep(Duration(seconds: 1));
  Future<int> future = getValue as Future<int>;
  print('执行完成');
  future.then((value) => {print('结果${value}')});
}

Future<int> getValue() async {
  print('执行Future');
  return Future(() => 1);
}

void future2() async {
  print('执行future1');
  sleep(Duration(seconds: 2));
  print('执行完成');
}

// cost 5015
Future callFuns() async {
  var r = await fun1();
  var r2 = await fun2();
  print('r = $r');
  print('r2 = $r2');
}

// cost 3008
Future callFuns2() async {
  //var r = await fun1();
  //var r2 = await fun2();
  await Future.wait([fun1(), fun2()]).then((value) {
    var r = value[0];
    var r2 = value[1];
    print('r = $r');
    print('r2 = $r2');
  });
}

Future<String> fun1() {
  return Future.delayed(Duration(seconds: 2), () {
    return "future 1";
  });
}

Future<String> fun2() {
  return Future.delayed(Duration(seconds: 3), () {
    return "future 2";
  });
}
