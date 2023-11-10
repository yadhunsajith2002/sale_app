import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_app/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final addresController = TextEditingController();
  final phone_numberController = TextEditingController();
  final emailController = TextEditingController();
  final countrycontroller = TextEditingController();
  final data = HomeController().items;
  @override
  void initState() {
    Provider.of<HomeController>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerWatch = context.watch<HomeController>();
    var providerRead = context.read<HomeController>();
    final data = providerWatch.items;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Sale App"),
      ),
      body: providerWatch.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : providerWatch.items.isEmpty
              ? Center(
                  child: Text("Data to be added"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  userData(
                                    index: index,
                                    text: "Name : ",
                                    category: "${data[index].name}",
                                  ),
                                  userData(
                                    index: index,
                                    text: "Address : ",
                                    category: " ${data[index].address}",
                                  ),
                                  userData(
                                    index: index,
                                    text: "Phone : ",
                                    category: " ${data[index].phoneNumber}",
                                  ),
                                  userData(
                                    index: index,
                                    text: "email : ",
                                    category: " ${data[index].email}",
                                  ),
                                  userData(
                                    index: index,
                                    text: "Country : ",
                                    category: " ${data[index].country}",
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            nameController.text =
                                                data[index].name.toString();
                                            addresController.text =
                                                data[index].address.toString();
                                            phone_numberController.text =
                                                data[index]
                                                    .phoneNumber
                                                    .toString();
                                            emailController.text =
                                                data[index].email.toString();
                                            countrycontroller.text =
                                                data[index].country.toString();
                                            addBottomSheet(
                                                index: index,
                                                ctx: context,
                                                isEdit: true);
                                          },
                                          icon: Icon(Icons.edit)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            providerRead.deleteEmployee(
                                                id: providerWatch
                                                    .items[index].id
                                                    .toString(),
                                                context: context);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          nameController.clear();
          addresController.clear();
          phone_numberController.clear();
          emailController.clear();
          countrycontroller.clear();
          addBottomSheet(
            ctx: context,
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget userData(
      {required int index, required String text, required String category}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      TextSpan(
          text: category,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
    ]));
  }

  addBottomSheet(
      {required BuildContext ctx, bool isEdit = false, int index = 0}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 25,
              left: 25,
              right: 25,
            ),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: addresController,
                    decoration: InputDecoration(
                        labelText: "Adress",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: phone_numberController,
                    decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: countrycontroller,
                    decoration: InputDecoration(
                      labelText: "Country",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () async {
                          final phonNumber =
                              int.tryParse(phone_numberController.text);

                          if (isEdit == false) {
                            await Provider.of<HomeController>(context,
                                    listen: false)
                                .addData(
                              name: nameController.text,
                              address: addresController.text,
                              phone: phonNumber,
                              email: emailController.text,
                              country: countrycontroller.text,
                            );

                            setState(() {});
                            Navigator.pop(context);
                          } else {
                            await Provider.of<HomeController>(context,
                                    listen: false)
                                .updateEmployee(
                              id: data[index].id,
                              name: nameController.text,
                              address: addresController.text,
                              phone: phonNumber,
                              email: emailController.text,
                              country: countrycontroller.text,
                            );

                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: Text(isEdit ? "Update" : "Save"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.white),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
