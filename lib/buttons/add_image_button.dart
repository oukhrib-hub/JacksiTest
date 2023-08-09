import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddImageButton extends StatefulWidget {
  final Function(String path) onImagePIcked;
  const AddImageButton({
    super.key,
    required this.onImagePIcked,
  });

  @override
  State<AddImageButton> createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {
  final ImagePicker picker = ImagePicker();
  
  Future<void> pickImageAndSaveToAppDirectory() async {
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      String ext = response.path.split(".").last;
      String dir = (await getApplicationDocumentsDirectory()).path;
      File? fileImage = File("$dir/${DateTime.now().millisecondsSinceEpoch}.$ext");
      Uint8List? imageBytes = await response.readAsBytes();

      fileImage = await fileImage.writeAsBytes(imageBytes);
      fileImage
        ..createSync()
        ..writeAsBytesSync(imageBytes);
      widget.onImagePIcked(fileImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pickImageAndSaveToAppDirectory,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(Icons.add, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 10),
            const Text(
              "اضغط لاضافة الصور",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
