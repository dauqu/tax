import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tax/pages/print.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  //List view controller
  final ScrollController _scrollController = ScrollController();

  //Text controller
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  late AudioPlayer player;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
    player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              // child: SfDataGrid(
              //   allowPullToRefresh: true,
              //   source: employeeDataSource,
              //   allowSwiping: true,
              //   checkboxShape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(5)),
              //   ),
              //   columns: <GridColumn>[
              //     GridColumn(
              //       columnName: 'id',
              //       label: const Text('Item ID'),
              //       width: 100,
              //     ),
              //     GridColumn(
              //       columnName: 'name',
              //       label: const Text('Item Name'),
              //       //40%
              //       width: MediaQuery.of(context).size.width * 0.4,
              //     ),
              //     GridColumn(
              //       columnName: 'price',
              //       label: const Text('Price'),
              //       width: 100,
              //     ),
              //     GridColumn(
              //       columnName: 'quantity',
              //       label: const Text('Quantity'),
              //       width: 100,
              //     ),
              //   ],
              // ),
              //Table View
              // child: ListView.builder(
              //   //Scroll to bottom
              //   controller: _scrollController,
              //   itemCount: employees.length,
              //   itemBuilder: (context, index) {
              //     return Dismissible(
              //       background: Container(
              //         color: Colors.red,
              //         child: const Icon(Icons.delete),
              //       ),
              //       key: Key(employees[index].id.toString()),
              //       onDismissed: (direction) {
              //         setState(() {
              //           employees.removeAt(index);
              //         });
              //       },
              //       child: ListTile(
              //         dense: true,
              //         tileColor: Colors.grey[200],
              //         leading: const Icon(Icons.inventory_sharp),
              //         title: Text(employees[index].items),
              //         subtitle: Text(employees[index].price.toString()),
              //         trailing: Text(employees[index].quantity.toString()),
              //       ),
              //     );
              //   },
              // ),
              //Table
              child: Container(
                //Full screen
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  //Always scroll to bottom
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(5),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade500,
                              width: 1,
                            ),
                          ),
                        ),
                        children: [
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(5),
                            color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: const Text('Item Name',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(5),
                            color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: const Text('Price',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(5),
                            color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: const Text('Quantity',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(5),
                            color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: const Text('Total',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(5),
                            color: Colors.blue,
                            alignment: Alignment.centerLeft,
                            child: const Text('Action',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      for (var i = 0; i < employees.length; i++)
                        TableRow(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          children: [
                            Container(
                              width: 200,
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: Text(employees[i].items),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: Text(employees[i].price.toString()),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: Text(employees[i].quantity.toString()),
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(5),
                              // color: Colors.grey[200],
                              child: Text(
                                  (employees[i].price * employees[i].quantity)
                                      .toString()),
                            ),
                            Container(
                              // color: Colors.grey[200],
                              child: IconButton(
                                splashRadius: 10,
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    employees.removeAt(i);
                                  });
                                },
                                icon: const Icon(Icons.delete,
                                    size: 20, color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            //Divider
            const VerticalDivider(
              width: 10,
              thickness: 1,
            ),
            Expanded(
              flex: 2,
              child: Form(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ListTile(
                            tileColor: Colors.grey[200],
                            //if length is 0 then 0 else sum of all price
                            title: Text(employees.isEmpty
                                ? '0'
                                : employees
                                    .map((e) => e.price * e.quantity)
                                    .reduce((value, element) => value + element)
                                    .toString()),

                            subtitle: const Text('Total Amount'),
                            leading: const Icon(Icons.currency_rupee_outlined),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Text(employees.length.toString()),
                            subtitle: const Text('Total Items'),
                            leading: const Icon(Icons.inventory_sharp),
                          ),

                          //Divider
                          const SizedBox(
                            height: 5,
                          ),

                          ListTile(
                            tileColor: Colors.grey[200],
                            leading: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const PrintData()),
                                );
                              },
                              icon: const Icon(Icons.print),
                              label: const Text('Print Bill'),
                            ),
                            title: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.blue,
                              ),
                              onPressed: () {
                                //Download bill txt file
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Save Bill'),
                            ),
                            trailing: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                //Clear all items
                                setState(() {
                                  employees.clear();
                                });
                              },
                              icon: const Icon(Icons.clear_all),
                              label: const Text('Clear Bill'),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            child: TextField(
                              controller: _itemController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Item Name',
                                //Hide border
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          //Divider
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            child: TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              //Filder string allow only numbers
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Price',
                                //Hide border
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          //Divider
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            child: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              //Filder string allow only numbers
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Quantity',
                                //Hide border
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                              //Full width
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  //Add new item to list
                                  setState(() {
                                    employees.add(Employee(
                                        employees.length + 1,
                                        _itemController.text,
                                        int.parse(_priceController.text),
                                        int.parse(_quantityController.text)));
                                  });

                                  //Scroll to bottom
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeOut,
                                  );

                                  await player
                                      .setAsset('assets/music/stop-13692.mp3');
                                  player.play();
                                },
                                child: const Text('Submit'),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List<Employee> getEmployeeData() {
  //   return [
  //     Employee(
  //         1,
  //         'Lorem Ipsum is simply dummy text of the printing and typesetting',
  //         556,
  //         1),
  //     Employee(2, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 3),
  //     Employee(3, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 5654, 4),
  //     Employee(4, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 6),
  //     Employee(5, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 2),
  //     Employee(6, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 45654, 5),
  //     Employee(7, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 2),
  //     Employee(8, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 1),
  //     Employee(9, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 1),
  //     Employee(10, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 1),
  //     Employee(11, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 6),
  //     Employee(12, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 33),
  //     Employee(13, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 24),
  //     Employee(14, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 13),
  //     Employee(15, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 2),
  //     Employee(16, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 3),
  //     Employee(17, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 546, 4),
  //     Employee(18, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 2),
  //     Employee(19, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 3),
  //     Employee(20, 'Lorem Ipsum is simply dummy text of the printing and typesetting', 456, 2)
  //   ];
  // }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.items, this.price, this.quantity);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String items;

  /// Designation of an employee.
  final int price;

  /// Salary of an employee.
  final int quantity;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'Item', value: e.items),
              DataGridCell<int>(columnName: 'Price', value: e.price),
              DataGridCell<int>(columnName: 'Quantity', value: e.quantity),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        //Left align
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(5),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
