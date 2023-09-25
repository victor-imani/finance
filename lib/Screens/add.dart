import 'package:finance/data/model/add_date.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final box = Hive.box<Add_data>('data');
  DateTime date = DateTime.now();
  final TextEditingController explainController = TextEditingController();
  FocusNode explainFNode = FocusNode();
  final TextEditingController amountController = TextEditingController();
  FocusNode amountFNode = FocusNode();
  String? selectedItem;
  String? selectedItem2;
  final List<String> _item = [
    'Food',
    'Transfer',
    'Transportation',
    'Education'
  ];

  final List<String> _item2 = [
    'Income',
    'Expense',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    explainFNode.addListener(() {
      setState(() {});
    });

    amountFNode.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backgroundContainer(context),
            Positioned(
              top: 120,
              child: mainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          name(),
          const SizedBox(
            height: 30,
          ),
          explainBorder(),
          const SizedBox(
            height: 30,
          ),
          amountBorder(),
          const SizedBox(
            height: 30,
          ),
          howBorder(),
          const SizedBox(
            height: 30,
          ),
          dateTimeContainer(),
          const Spacer(),
          saveButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  GestureDetector saveButton() {
    return GestureDetector(
      onTap: () {
        var add = Add_data(selectedItem2!, selectedItem!,
            explainController.text, amountController.text, date);
        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF368983),
        ),
        width: 120,
        height: 50,
        child: const Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Container dateTimeContainer() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: const Color(0xFFC5C5C5),
        ),
      ),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));

          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: Text(
          'Date : ${date.year} / ${date.day} / ${date.month}',
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }

  Padding howBorder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xFFC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem2,
          items: _item2
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item2
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(e, style: const TextStyle(fontSize: 18)),
                    ],
                  ))
              .toList(),
          hint: const Text(
            'How',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: ((value) {
            setState(() {
              selectedItem2 = value!;
            });
          }),
        ),
      ),
    );
  }

  Padding amountBorder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amountFNode,
        controller: amountController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFFC5C5C5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFF368983),
            ),
          ),
        ),
      ),
    );
  }

  Padding explainBorder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        focusNode: explainFNode,
        controller: explainController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Explain',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFFC5C5C5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Color(0xFF368983),
            ),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xFFC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Image.asset('images/$e.png'),
                          ),
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        width: 42,
                        child: Image.asset('images/$e.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(e, style: const TextStyle(fontSize: 18)),
                    ],
                  ))
              .toList(),
          hint: const Text(
            'Name',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: ((value) {
            setState(() {
              selectedItem = value!;
            });
          }),
        ),
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Color(0xFF368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Adding',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Icon(Icons.attach_file_outlined, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
