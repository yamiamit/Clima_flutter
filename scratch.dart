void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String tasktwodata = await task2() ;
  task3(tasktwodata);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
  Duration threeSeconds = Duration(seconds: 3);
  // sleep(threeSeconds);
  // sync sleep;
  String result = 'null';
  await Future.delayed(threeSeconds, () {
    // Future is async method
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String tasktwodata) {
  String result = 'task 3 data';
  print('Task 3 complete with $tasktwodata');
}