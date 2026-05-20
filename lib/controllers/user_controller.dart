import 'package:get/get.dart';
import 'package:getx_api_crud_6sic3/models/user_model.dart';
import 'package:getx_api_crud_6sic3/services/api_service.dart';

class UserController extends GetxController {
  // Ngapain?
  final service = ApiService();
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  // Mengampil semua data user - GET
  void fetchUsers() async {
    isLoading(true);
    final data = await service.getUsers();
    users.assignAll(data);
    isLoading(false);
  }

  // Menambah data baru user - POST
  void addUser(String name, String email) async {
    final data = await service.createUser(name, email);
    if (data != null) {
      users.add(data);
      Get.back();
      Get.snackbar('Tambah User', 'Berhasil tambah User Baru.');
    } else {
      Get.snackbar('Tambah User', 'Gagal tambah user baru');
    }
  }

  // Mengubah data user - PUT/PATCH
  void updateUser(int id, String name, String email) async {
    final isSuccess = await service.updateUser(id, name, email);
    if (isSuccess || id > 10) {
      int index = users.indexWhere((element) => element.id == id);
      users[index] = UserModel(id: id, name: name, email: email);
      users.refresh();
      Get.back();
      Get.snackbar('Edit User', 'Berhasil ubah data user.');
    } else {
      Get.snackbar('Edit User', 'Gagal mengubah data user.');
    }
  }

  // Menghapus data user - DELETE
  void deleteUser(int id) async {
    final isSucces = await service.deleteUser(id);
    if (isSucces) {
      users.removeWhere((element) => element.id == id);
      Get.back();
      Get.snackbar('Hapus User', 'Berhasil hapus data user.');
    } else {
      Get.snackbar('Hapus User', 'Gagal hapus data user.');
    }
  }
}
