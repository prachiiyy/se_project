import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:path/path.dart';
import 'package:helpmeout/resources/viewresource.dart';

class ResourceList extends StatefulWidget {
  String resourcepath;
  String title;
  ResourceList({Key? key, required this.title, required this.resourcepath})
      : super(key: key);

  @override
  State<ResourceList> createState() => _ResourceListState();
}

class _ResourceListState extends State<ResourceList> {
  List<Reference> filelist = [];

  bool loaded = false;

  Future<UploadTask> uploadFile(File file) async {
    UploadTask uploadTask;
    String filename = basename(file.path);

    // Create a Reference to the file
    final storage = FirebaseStorage.instance
        .ref()
        .child(widget.resourcepath)
        .child(filename);

    final metadata = SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = storage.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }

  Future<void> getFiles() async {
    final reference = await FirebaseStorage.instance
        .ref()
        .child(widget.resourcepath)
        .listAll();

    for (var reference in reference.items) {
      filelist.add(reference);
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF68B1D0),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: loaded
          ? SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 20, left: 5, right: 5), // Add padding around buttons
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filelist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DocumentViewer(documentRef: filelist[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent[200],
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Icon(Icons.file_copy),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          filelist[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ))
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final path = await FlutterDocumentPicker.openDocument();
          print(path);
          File file = File(path!);
          UploadTask task = await uploadFile(file);
          Navigator.pop(context);
        },
      ),
    );
  }
}
