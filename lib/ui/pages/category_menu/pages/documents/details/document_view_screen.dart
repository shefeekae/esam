// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:nectar_assets/core/services/file_services.dart';

// class DocumentViewScreen extends StatefulWidget {
//   final File file;
//   // final bool isImage;
//   final String title;
//   final String fileType;

//   const DocumentViewScreen({
//     super.key,
//     required this.file,
//     // required this.isImage,
//     required this.title,
//     required this.fileType,
//   });

//   @override
//   State<DocumentViewScreen> createState() => _DocumentViewScreenState();
// }

// class _DocumentViewScreenState extends State<DocumentViewScreen> {
//   @override
//   void initState() {
//     // FileReader.instance.engineLoadStatus((value) {
//     //   print("File reader $value");
//     // });
//     // FlutterFileView.init(canDownloadWithoutWifi: false, canOpenDex2Oat: false);
//     // fileViewController = FileViewController.file(widget.file);
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Navigator.of(context).pop();
//               FileServices().shareImage(
//                 imagePath: widget.file.path,
//               );
//             },
//             icon: const Icon(
//               Icons.share,
//             ),
//           ),
//           Visibility(
//             visible: widget.fileType != "PDF",
//             child: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 if (widget.fileType == "PDF") {
//                   // requestDownload(widget.file.uri.path, widget.file.path);
//                   return;
//                 }

//                 FileServices().downloadImagesToGallery(
//                   imagePath: widget.file.path,
//                   context: context,
//                 );
//               },
//               icon: const Icon(
//                 Icons.file_download_outlined,
//               ),
//             ),
//           ),
//           // IconButton(
//           //   onPressed: () {
//           //     // print(widget.file.path);

//           //     Share.shareFiles([
//           //       widget.file.path,
//           //     ]);
//           //   },
//           //   icon: const Icon(
//           //     Icons.share,
//           //   ),
//           // ),
//         ],
//       ),
//       body: Builder(builder: (context) {
//         if (widget.fileType == "JPEG" || widget.fileType == "PNG") {
//           return Center(
//             child: Image.file(widget.file),
//           );
//         } else if (widget.fileType == "PDF") {
//           return PDFView(
//             filePath: widget.file.path,
//           );
//         }

//         return const Center(
//           child: Text("Unsupported file"),
//         );

//       }),
      
//     );
//   }

// }