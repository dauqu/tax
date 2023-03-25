import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tax/pages/print.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  List<Employee> employees = <Employee>[];

  // late EmployeeDataSource employeeDataSource;

  //List view controller
  final ScrollController _scrollController = ScrollController();

  //Text controller
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _updateItemController = TextEditingController();
  final TextEditingController _updatePriceController = TextEditingController();
  final TextEditingController _updateQuantityController =
      TextEditingController();

  AudioPlayer player = AudioPlayer();

  final FocusNode _itmFNode = FocusNode();
  final FocusNode _updateitmFNode = FocusNode();

  Future addList() async {
    setState(() {
      employees.add(Employee(
          employees.length + 1,
          _itemController.text,
          int.parse(_priceController.text),
          int.parse(_quantityController.text)));
    });

    setState(() {
      //Clear text field
      _itemController.clear();
      _priceController.clear();
      _quantityController.clear();
    });

    //Scroll to bottom
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  initState() {
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
                      color: Colors.black,
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
                            child: const Text('S.No',
                                style: TextStyle(color: Colors.white)),
                          ),
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
                                color: Colors.black,
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
                              child: Text((i + 1).toString()),
                            ),
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
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
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
                                IconButton(
                                  splashRadius: 10,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    setState(() {
                                      _updateItemController.text =
                                          employees[i].items;
                                      _updatePriceController.text =
                                          employees[i].price.toString();
                                      _updateQuantityController.text =
                                          employees[i].quantity.toString();
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Edit'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      _updateItemController,
                                                  focusNode: _updateitmFNode,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Item Name'),
                                                ),
                                                TextField(
                                                  controller:
                                                      _updatePriceController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Price'),
                                                ),
                                                TextField(
                                                  controller:
                                                      _updateQuantityController,
                                                  onSubmitted: (value) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      employees[i].items =
                                                          _updateItemController
                                                              .text;
                                                      employees[i].price =
                                                          int.parse(
                                                              _updatePriceController
                                                                  .text);
                                                      employees[i].quantity =
                                                          int.parse(
                                                              _updateQuantityController
                                                                  .text);
                                                    });
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            _updateitmFNode);
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Quantity'),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    employees[i].items =
                                                        _updateItemController
                                                            .text;
                                                    employees[i].price =
                                                        int.parse(
                                                            _updatePriceController
                                                                .text);
                                                    employees[i].quantity =
                                                        int.parse(
                                                            _updateQuantityController
                                                                .text);
                                                  });
                                                },
                                                child: const Text('Update'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.edit,
                                      size: 20, color: Colors.blue),
                                ),
                              ],
                            )),
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
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PrintData(items: employees)),
                                );
                              },
                              icon: const Icon(Icons.print),
                              label: const Text('Print Bill'),
                            ),
                            title: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.save),
                              label: const Text('Save Bill'),
                            ),
                            trailing: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.red,
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
                              // on press enter move to next
                              controller: _itemController,
                              focusNode: _itmFNode,
                              textInputAction: TextInputAction.next,
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
                              textInputAction: TextInputAction.next,
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
                              onSubmitted: (value) {
                                addList();
                                FocusScope.of(context).requestFocus(_itmFNode);
                              },
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
                                onPressed: () {
                                  addList();
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
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.items, this.price, this.quantity);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  late String items;

  /// Designation of an employee.
  late int price;

  /// Salary of an employee.
  late int quantity;
}
