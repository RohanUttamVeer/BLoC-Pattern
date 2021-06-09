//TODO: imports
//TODO: list of employes
//TODO: stream controller
//TODO: stream sink getter
//TODO: constructor - add data; listem to changes
//TODO: core functions
//TODO: dispose

//TODO: imports
import 'dart:async';
import 'employee.dart';

class employeeBloc {
  //TODO: list of employes
  List<employee> _employeeList = [
    // sink to add in i.e sink in
    // stream to get data from i.e stream out
    // input / output is data flow

    employee(1, "Rohan Veer", 100),
    employee(2, "Vidya Veer", 200),
    employee(3, "Uttam Veer", 300),
    employee(4, "Raj Veer", 400)
  ];
//TODO: stream controller

  final _employeeListStreamController = StreamController<List<employee>>();
  // for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<employee>();
  final _employeeSalaryDecrementStreamController = StreamController<employee>();

//TODO: stream sink getter

  // getters
  Stream<List<employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

//TODO: constructor - add data; listem to changes

  employeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

//TODO: core functions

  _incrementSalary(employee emp) {
    double salary = emp.salary;

    double incrementedSalary = salary * 20 / 100;
    _employeeList[emp.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(employee emp) {
    double salary = emp.salary;

    double decrementedSalary = salary * 20 / 100;
    _employeeList[emp.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

//TODO: dispose

  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }
}
