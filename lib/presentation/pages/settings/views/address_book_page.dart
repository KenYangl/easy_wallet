import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressBookPage extends StatelessWidget {
  const AddressBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("address_book".tr),
      ),
      body: const Center(
        child: Text('address book'),
      ),
    );
  }
}