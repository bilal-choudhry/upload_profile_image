
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhoto extends StatefulWidget {
 UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File? pickedImage;
  String base64Image = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IMAGE PICKER', ),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.sp,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                Container(
                width: 30.h,
                height: 30.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink, width: 2.sp),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.sp),
                  ),
                ),
                child: ClipOval(
                  child: (pickedImage!= null)? Image.file(pickedImage!, fit: BoxFit.cover,):Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                  Positioned(
                    bottom: 4.sp,
                    right: 5.sp,
                    child: IconButton(
                      onPressed: (){
                        imagePickerOption();
                      },
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.pinkAccent,
                        size: 30.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
             SizedBox(
              height: 20.sp,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: ElevatedButton.icon(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                  onPressed: (){
                        imagePickerOption();
                  },
                  icon:  Icon(Icons.add_a_photo_sharp),
                  label:  Text('UPLOAD IMAGE')),
            )
          ],
        ),
      ),
    );
  }

 void imagePickerOption() {
   Get.bottomSheet(
     SingleChildScrollView(
       child: ClipRRect(
         borderRadius:  BorderRadius.only(
           topLeft: Radius.circular(10.0.sp),
           topRight: Radius.circular(10.0.sp),
         ),
         child: Container(
           color: Colors.white,
           height: 40.h,
           child: Padding(
             padding: EdgeInsets.all(8.0.sp),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                  Text(
                   "Pic Image From",
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
                   textAlign: TextAlign.center,
                 ),
                  SizedBox(
                   height: 5.h,
                 ),
                 ElevatedButton.icon(
                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                   onPressed: () {
                     pickImage(ImageSource.camera);
                   },
                   icon:  Icon(Icons.camera),
                   label:  Text("CAMERA"),
                 ),
                 ElevatedButton.icon(
                   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                   onPressed: () {
                     pickImage(ImageSource.gallery);

                   },
                   icon:  Icon(Icons.image),
                   label:  Text("GALLERY"),
                 ),
                 ElevatedButton.icon(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink)),
                   onPressed: () {
                     Get.back();
                   },
                   icon:  Icon(Icons.close),
                   label: Text("CANCEL"),
                 ),
               ],
             ),
           ),
         ),
       ),
     ),
   );
 }

pickImage(var imageType) async {
   try {
     var photo = await ImagePicker().pickImage(source: imageType);
     if (photo == null){ Get.snackbar("No Photo Selected,", "");}
     final tempImage = File(photo!.path);
     setState(() {
       pickedImage = tempImage;
     });

     Get.back();
   } catch (error) {
     debugPrint(error.toString());
   }
 }
}
