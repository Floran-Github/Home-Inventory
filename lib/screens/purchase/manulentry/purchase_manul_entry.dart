import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class ManualEntryPage extends StatefulWidget {
  const ManualEntryPage({super.key});

  @override
  State<ManualEntryPage> createState() => _ManualEntryPageState();
}

class _ManualEntryPageState extends State<ManualEntryPage> {
  final _formKey = GlobalKey<FormState>();

  List<dynamic> data = [];
  String? unit;
  TextEditingController name = TextEditingController();
  TextEditingController amt = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController weight = TextEditingController();
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NestedAppBar(title: "Billing"),
      bottomNavigationBar: bottomContainer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
        },
        shape: CircleBorder(),
        backgroundColor: AppColors.greenShade,
        child: Icon(
          Icons.arrow_right_alt_rounded,
          color: AppColors.white,
          size: 24,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Item",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return createForm();
                    });
              },
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      size: 27,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add new item",
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return listItem(index);
              },
            )
          ],
        ),
      )),
    );
  }

  Container bottomContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.greenShade, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Text(
        "Total Amount : $totalAmount",
        style: TextStyle(color: AppColors.white, fontSize: 22),
      ),
    );
  }

  // Funtions

  addItem() {
    if (_formKey.currentState!.validate() && unit != null) {
      var temp = {
        'name': name.text,
        'qty': qty.text,
        'amt': amt.text,
        'weight': weight.text,
        'unit': unit,
      };
      var tp = data;
      tp.add(temp);

      setState(() {
        data = tp;
        unit = 'kg';
        totalAmount =
            totalAmount + (double.parse(amt.text) * int.parse(qty.text));
      });

      Navigator.pop(context);
      name.clear();
      qty.clear();
      amt.clear();
      weight.clear();
    }
  }

  // widgets
  StatefulBuilder createForm() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        // contentPadding: const EdgeInsets.symmetric(
        //     vertical: 15, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppColors.greenShade,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formLabel("Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Product Name';
                      }
                      return null;
                    },
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        hintStyle:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "Name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            formLabel("Quantity"),
                            const SizedBox(
                              height: 5,
                            ),
                            numberInput(qty, "Quantity"),
                            const SizedBox(
                              height: 10,
                            ),
                            formLabel("Weight"),
                            const SizedBox(
                              height: 5,
                            ),
                            numberInput(weight, "Weight"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            formLabel("Price"),
                            const SizedBox(
                              height: 5,
                            ),
                            numberInput(amt, "Price"),
                            const SizedBox(
                              height: 10,
                            ),
                            formLabel("Unit"),
                            const SizedBox(
                              height: 5,
                            ),
                            dropdown(setState)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () => addItem(),
                          elevation: 0,
                          color: AppColors.yellow,
                          // minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () => Navigator.pop(context),
                          elevation: 0,
                          color: Colors.redAccent,
                          // minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Container dropdown(StateSetter setState) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(5.0),
      child: DropdownButton(
        isExpanded: true,
        hint: Text("Unit"),
        underline: const SizedBox(
          height: 0,
        ),
        value: unit,
        style: const TextStyle(color: Colors.black, fontSize: 15.0),
        items: ['kg', 'grams', 'litre', 'ml', 'pieces']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black, fontSize: 15.0),
              ));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            unit = value;
          });
        },
      ),
    );
  }

  TextFormField numberInput(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: AppColors.black),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Item $label';
        }
        return null;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: label),
    );
  }

  Text formLabel(String label) {
    return Text(
      "$label :",
      style: const TextStyle(
          fontSize: 23, color: AppColors.black, fontWeight: FontWeight.w700),
    );
  }

  Container listItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.yellow, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data[index]['name'],
                style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
              Row(
                children: [
                  MaterialButton(
                      minWidth: 0,
                      color: Colors.blueAccent,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      elevation: 0,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                  MaterialButton(
                      minWidth: 0,
                      color: Colors.redAccent,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      elevation: 0,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              containerText("Qty", data[index]['qty'].toString()),
              containerText("Amount", data[index]['amt'].toString()),
              containerText(
                  "Weight", "${data[index]['weight']} ${data[index]['unit']}"),
            ],
          )
        ],
      ),
    );
  }

  Flexible containerText(String label, String data) => Flexible(
        child: Text(
          "$label: $data",
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      );
}
