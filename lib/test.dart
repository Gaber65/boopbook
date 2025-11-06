// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageUploadScreen extends StatefulWidget {
//   @override
//   _ImageUploadScreenState createState() => _ImageUploadScreenState();
// }
//
// class _ImageUploadScreenState extends State<ImageUploadScreen> {
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _selectedImage;
//
//   Future<void> _pickImage() async {
//     final pickedFile =
//         await _imagePicker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _selectedImage = File(pickedFile.path);
//       }
//     });
//   }
//
//   Future<String?> _uploadImageToFirebaseStorage(
//       File imageFile, String imageName) async {
//     final String storageUrl =
//         'https://firebasestorage.googleapis.com/v0/b/YOUR_PROJECT_ID/o/$imageName';
//
//     try {
//       final dio = Dio();
//       final response = await dio.put(
//         storageUrl,
//         data: await imageFile.readAsBytes(),
//         options: Options(
//           contentType: 'image/jpeg',
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         final String downloadUrl = json.decode(response.data)['downloadTokens'];
//         return downloadUrl;
//       } else {
//         print(
//             'Failed to upload image to Firebase Storage. Status code: ${response.statusCode}');
//         print('Response data: ${response.data}');
//         return null;
//       }
//     } catch (e) {
//       print('Error uploading image to Firebase Storage: $e');
//       return null;
//     }
//   }
//
//   Future<void> _sendImageUrlToApi(String imageUrl) async {
//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         'YOUR_API_ENDPOINT', // Replace with your API endpoint
//         data: {'image_url': imageUrl},
//       );
//
//       if (response.statusCode == 200) {
//         print('Image URL sent to API successfully');
//       } else {
//         print(
//             'Failed to send image URL to API. Status code: ${response.statusCode}');
//         print('Response data: ${response.data}');
//       }
//     } catch (e) {
//       print('Error sending image URL to API: $e');
//     }
//   }
//
//   Future<void> _uploadAndSendToApi() async {
//     if (_selectedImage == null) {
//       // Handle no image selected
//       return;
//     }
//
//     // Upload image to Firebase Storage
//     final downloadUrl = await _uploadImageToFirebaseStorage(
//         _selectedImage!, DateTime.now().millisecondsSinceEpoch.toString());
//
//     if (downloadUrl != null) {
//       // Send the image URL to your API
//       await _sendImageUrlToApi(downloadUrl);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: DefaultTabController(
//         length: 2,
//         child: Column(
//           children: [
//             TabBar(
//               isScrollable: true,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white30,
//               tabs: [
//                 Text('For You'),
//                 Text('New Reals'),
//               ],
//             ),
//             TabBarView(
//               children: [
//                 PageView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   itemBuilder: (context, index) {
//                     return BodyReals(model: model[index]);
//                   },
//                   itemCount: model.length,
//                 ),
//                 PageView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   itemBuilder: (context, index) {
//                     return BodyReals(model: model[index]);
//                   },
//                   itemCount: model.length,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
