import 'package:get/get.dart';
import 'package:flutterapptask/app/features/contacts/data/data_sources/local/database_helper.dart';

class ContactController extends GetxController {
  RxList<Map<String, dynamic>> contacts = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  void fetchContacts() async {
    isLoading.value = true;
    final data = await DatabaseHelper.getItems();
    contacts.value = data;
    isLoading.value = false;
  }

  Future<void> addContact(String name, String phone) async {
    await DatabaseHelper.createItem(name, phone);
    fetchContacts();
  }

  Future<void> deleteContact(int id) async {
    await DatabaseHelper.deleteItem(id);
    fetchContacts();
  }
}
