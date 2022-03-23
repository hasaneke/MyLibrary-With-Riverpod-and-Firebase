import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

abstract class IStorageService {
  void initService(String userId) {}
  Future<String> uploadFileAndGetTheUrl({required File file});
  Future<void> deleteFile({required String url});
  Future<void> downloadFile({required String url});
}

class StorageService extends IStorageService {
  String _pathToUpload = '';

  @override
  void initService(String userId) {
    _pathToUpload = 'users/' + userId + '/images/';
  }

  @override
  Future<void> deleteFile({required String url}) async {
    await firebase_storage.FirebaseStorage.instance.refFromURL(url).delete();
  }

  @override
  Future<void> downloadFile({required String url}) {
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFileAndGetTheUrl({required File file}) async {
    String fileName = file.path.split('/').last;
    await firebase_storage.FirebaseStorage.instance
        .ref(_pathToUpload + fileName)
        .putFile(file);
    return await firebase_storage.FirebaseStorage.instance
        .ref(_pathToUpload + fileName)
        .getDownloadURL();
  }
}
