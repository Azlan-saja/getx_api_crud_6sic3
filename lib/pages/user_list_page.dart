import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_crud_6sic3/controllers/user_controller.dart';
import 'user_add_page.dart';
import 'user_edit_page.dart';

class UserListPage extends StatelessWidget {
  UserListPage({super.key});

  final userC = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data User (CRUD GetX & API)'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => UserAddPage());
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          if (userC.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: userC.users.length,
            itemBuilder: (context, index) {
              final user = userC.users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => UserEditPage(
                                user: user,
                              ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            buttonColor: Colors.red,
                            title: 'Hapus User',
                            middleText: 'Apakah Anda yakin ingin menghapus user ${user.name}?',
                            textCancel: 'Gak jadi.',
                            textConfirm: 'Iya, hapus!',
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              userC.deleteUser(user.id);
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
