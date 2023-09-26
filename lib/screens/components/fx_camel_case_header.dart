// import 'package:flutter/material.dart';
// import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
// import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
// import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';


// class FxCamelCaseHeader extends StatelessWidget {
//   final String title;
//   final Widget? information;
//   final bool isBold;

//   const FxCamelCaseHeader({
//     Key? key,
//     required this.title,
//     this.information,
//     this.isBold = false,
//   }) : super(key: key);

  

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         FxText(
//           convertToCamelCase(title),
//           tag: Tag.h5,
//           color: InitialStyle.textColor,
//           size: 10,
//           decoration: TextDecoration.none,
//           overFlowTag: true,
//           maxLine: 1,
//           isBold: isBold,
//         ),
//         SizedBox(height: InitialDims.space2),
//         if (information != null) information!,
//       ],
//     );
//   }

//     String convertToCamelCase(String input) {
//     // Split the input string into words
//     final words = input.split(' ');

//     // Capitalize the first letter of each word except the first one
//     final capitalizedWords = words.map((word) {
//       if (word.isEmpty) {
//         return ' '; // Skip empty words
//       }
//       return word[0].toUpperCase() + word.substring(1).toLowerCase();
//     }).toList();

//     // Join the words back together to form camel case
//     final camelCaseString = capitalizedWords.join(' ');

//     // Make sure the first letter is in lowercase
//     return camelCaseString[0].toLowerCase() + camelCaseString.substring(1);
//   }
// }
