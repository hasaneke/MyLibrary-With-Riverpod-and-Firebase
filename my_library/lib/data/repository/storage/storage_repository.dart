import 'dart:io';

import 'package:storage_service/network/storage_service.dart';

abstract class IStorageService {
  void initService(String userId) {}
  Future<List<String>> uploadFilesAndGetTheUrls({required List<File> files});
  Future<void> deleteFile({required String url});
  Future<void> downloadFile({required String url});
}

class StorageRepository extends IStorageService {
  StorageService storageService;
  StorageRepository({required this.storageService});
  @override
  Future<void> deleteFile({required String url}) async {
    await storageService.deleteFile(url: url);
  }

  @override
  Future<void> downloadFile({required String url}) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<List<String>> uploadFilesAndGetTheUrls(
      {required List<File> files}) async {
    List<String> fileUrls = [];
    for (var file in files) {
      fileUrls = [
        ...fileUrls,
        await storageService.uploadFileAndGetTheUrl(file: file)
      ];
    }
    return fileUrls;
  }
}
