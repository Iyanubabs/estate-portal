// import 'dart:html';

// import 'package:estate_portal/services/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageWidget extends StatelessWidget {
//   final File image;
//   final ValueChanged<ImageSource> onClicked;

//   const ImageWidget({Key? key, required this.image, required this.onClicked})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: [
//           buildImage(context),
//           Positioned(
//             child: buildEditIcon(Constants.mainColor),
//             bottom: 0,
//             right: 4,
//           )
//         ],
//       ),
//     );
//   } 

//   Widget buildImage(BuildContext context) {
//     final imagePath = this.image.path;
//     final image = imagePath.contains("https://")
//         ? NetworkImage(imagePath)
//         : FileImage(File(imagePath));

//     return ClipOval(
//       child: Material(
//         color: Colors.transparent,
//         child: Ink.image(
//           image: image as ImageProvider,
//           fit: BoxFit.cover,
//           width: 160,
//           height: 160,
//           child: InkWell(
//             onTap: () async {
//               final source = await showImageSource(context);
//               if (source == null) return;
//               onClicked(source);
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildEditIcon(Color color) => buildCircle(
//         color: Colors.white,
//         all: 3,
//         child: buildCircle(
//           color: color,
//           all: 8,
//           child: Icon(
//             Icons.edit,
//             size: 26,
//             color: Colors.white,
//           ),
//         ),
//       );

//   Widget buildCircle({
//     required Widget child,
//     required double all,
//     required Color color,
//   }) =>
//       ClipOval(
//         child: Container(
//           padding: EdgeInsets.all(all),
//           color: color,
//           child: child,
//         ),
//       );
// }
