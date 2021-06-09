import 'package:flutter/material.dart';
import 'employee.dart';
import 'employeeBloc.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  //create object
  final employeeBloc _employeeBloc = employeeBloc();
  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC App"),
      ),
      body: Container(
        child: StreamBuilder<List<employee>>(
          stream: _employeeBloc.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data![index].id}.",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${snapshot.data![index].name}",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              "₹ ${snapshot.data![index].salary}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: IconButton(
                        icon: Icon(Icons.thumb_up),
                        color: Colors.blueAccent,
                        onPressed: () {
                          _employeeBloc.employeeSalaryIncrement
                              .add(snapshot.data![index]);
                        },
                      )),
                      Container(
                          child: IconButton(
                        icon: Icon(Icons.thumb_down),
                        color: Colors.deepPurpleAccent,
                        onPressed: () {
                          _employeeBloc.employeeSalaryDecrement
                              .add(snapshot.data![index]);
                        },
                      )),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
