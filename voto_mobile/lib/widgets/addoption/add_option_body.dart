// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:voto_mobile/widgets/addoption/add_option_items.dart';
// import 'package:voto_mobile/utils/color.dart';

// class AddOptionBody extends StatefulWidget {
//   const AddOptionBody({Key? key}) : super(key: key);

//   @override
//   State<AddOptionBody> createState() => _AddOptionBodyState();
// }

// class _AddOptionBodyState extends State<AddOptionBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 42.5),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//           border: Border(
//             top: BorderSide(
//               width: 1,
//               color: Color(0xFFF2F4F8),
//             ),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AddOptionItems(name: 'Salad'),
//             AddOptionItems(name: 'Pizza'),
//             AddOptionItems(name: 'Bonchon'),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 65, top: 15),
//             //   child: Text(
//             //     'Salad',
//             //     style: GoogleFonts.inter(fontSize: 14),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 65, top: 15),
//             //   child: Text(
//             //     'Pizza',
//             //     style: GoogleFonts.inter(fontSize: 14),
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 65, top: 15),
//             //   child: Text(
//             //     'Bonchon',
//             //     style: GoogleFonts.inter(fontSize: 14),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget addOptionButton() {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.zero,
//         primary: VotoColors.magenta,
//         fixedSize: const Size(140, 36),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       onPressed: () {},
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 8.0),
//             child: Icon(
//               Icons.add_circle,
//               color: VotoColors.white,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               'Add option',
//               style: GoogleFonts.inter(
//                   color: VotoColors.white, fontWeight: FontWeight.normal),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
