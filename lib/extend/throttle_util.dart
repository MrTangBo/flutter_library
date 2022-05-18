import 'dart:async';
///防抖动
Function() debounces(
     Function func, [
      Duration delay = const Duration(milliseconds: 1000),
    ]) {
  Timer? timer;
  target () {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func();
    });
  }
  return target;


}