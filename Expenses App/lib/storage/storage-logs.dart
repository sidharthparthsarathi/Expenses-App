import 'dart:io';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
  
  Future<String> get localPath async {//Local Path For Storing Data
  final foldername='Spending-Logs-Tracker-Expenses';
  final subFolder='Data';
    final directory = Directory("storage/emulated/0/$foldername");//Changed This From Final To Var
    var status = await Permission.storage.status;
    if (!status.isGranted) {
    await Permission.storage.request();
    }
     if (!await directory.exists()){
        print("Creating Path");
        directory.create();
      }
    final subDirect=Directory('${directory.path}/$subFolder');
    if(!await subDirect.exists())
    {
      print('Creating Sub');
      subDirect.create();
    }
    print('The Path Of This'+subDirect.path);
    return subDirect.path;
  }
  Future<File> get localFile async {//Local File
    final path= await localPath;
    print('Control In localfile Line 74');
    return File('$path/Logs.txt');
  }


  Future<String> readContent() async {//ReadContent
    try {
      var file = await localFile;
      // Read the file
      String contents = await file.readAsString();
      print('The Control Is In ReadContent'+contents+'Line 85');//For Debugging
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  Future<File> writeContent(String data) async {//Write Content
    var file = await localFile;
    // Write the file
    return file.writeAsString(data);
  }

  Future<File> deleteContent(String data) async {//Write Content
    var file = await localFile;
    // Write the file
    return file.writeAsString(data);
  }