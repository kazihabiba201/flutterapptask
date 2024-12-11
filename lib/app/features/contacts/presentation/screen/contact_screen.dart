import 'package:flutter/material.dart';
import 'package:flutterapptask/app/config/themes/app_color.dart';
import 'package:flutterapptask/app/config/themes/app_style.dart';
import 'package:flutterapptask/app/config/themes/button_style.dart';
import 'package:flutterapptask/app/core/localization/language_constant.dart';
import 'package:flutterapptask/app/core/utils/validation/validation.dart';
import 'package:flutterapptask/app/features/contacts/data/data_sources/local/database_helper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _contacts = [];

  bool _isLoading = true;

  void _autoRefreshContacts() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      _contacts = data;
      _isLoading = false;
    });
  }

  Future<void> _addItem() async {
    await DatabaseHelper.createItem(nameController.text, phoneController.text);
    _autoRefreshContacts();
  }

  void _deletItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    Get.snackbar(
      "Delete Successfully!",
      "You have been deleted Item successfully ",
      snackPosition: SnackPosition.BOTTOM,
    );
    _autoRefreshContacts();
  }

  @override
  void initState() {
    super.initState();
    _autoRefreshContacts();
    print("number for contacts ${_contacts.length}");
  }

  void _showAlertForm(int? id) async {
    if (id != null) {
      final existingContacts =
          _contacts.firstWhere((element) => element['id'] == id);
      nameController.text = existingContacts['name'];
      phoneController.text = existingContacts['phone'];
    }
    Get.dialog(
      Form(
        key: _formKey,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            translation(context).addNewContact,
            style: const TextStyle(fontWeight: FontWeight.w500),
          )),
          content: Text(
            translation(context).pleaseEnterTheContactDetailsBelow,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextFormField(
              controller: nameController,
              validator: NameValidator.validate,
              decoration: appInputDecoration(
                translation(context).name,
                suffixIcon: false,
              ),
            ),
            // Gap(5),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: phoneController,
              validator: PhoneFieldValidator.validate,
              keyboardType: TextInputType.phone,
              decoration: appInputDecoration(
                translation(context).number,
                suffixIcon: false,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      nameController.text = '';
                      phoneController.text = '';
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    child: Text(
                      translation(context).cancel,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (id == null) {
                          await _addItem();
                        }
                        Get.back();
                        nameController.text = '';
                        phoneController.text = '';
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            Pallets.colorBlue // Green color for "Yes"
                        ),
                    child: Text(
                      translation(context).add,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.surfaceColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                      style: appButtonStyle(Pallets.colorBlue,BorderRadius.circular(6)),
                      onPressed: () {
                        Get.back();
                      },
                      // },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                ),
                const Gap(10),
                Text(
                  translation(context).contacts,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Pallets.onSurfaceColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_contacts.isEmpty)
                    Center(
                        child: Text(
                      translation(context).noContactsFound +
                          '\n' +
                          translation(context).pleaseAddANewContact,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ))
                  else
                    Expanded(
                      child: ListView.builder(
                          itemCount: _contacts.length,
                          itemBuilder: (context, index) => Card(
                                color: Pallets.colorBlue,
                                margin: const EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: 250,
                                              child: Text(
                                                'Name:  ${_contacts[index]['name']}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          const Gap(5),
                                          Text(
                                            'Number:  ${_contacts[index]['phone']}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            _deletItem(_contacts[index]['id']);
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                ),
                              )),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            _showAlertForm(null);
          },
          backgroundColor: Pallets.colorBlue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
