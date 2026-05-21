import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_crud_6sic3/controllers/user_controller.dart';

class UserAddPage extends StatelessWidget {
  UserAddPage({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  final userCtrl = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                userCtrl.addUser(nameCtrl.text, emailCtrl.text);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
