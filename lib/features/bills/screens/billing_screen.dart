// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BillingScreen extends StatelessWidget {
//   const BillingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 1),
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: listpaymodels.length,
//           itemBuilder: (context, index) {
//             return SentMoney(listpaymodels[index]);
//           }),
//     );
//   }
// }

// List<Listpaymodel> listpaymodels = [
//   Listpaymodel(
//     _imagepath,
//     '',
//     _color,
//   ),
// ];

// class SentMoney extends StatelessWidget {
//   Listpaymodel listpaymodel;

//   SentMoney(this.listpaymodel, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Image.asset(
//           listpaymodel.imagepath,
//           color: listpaymodel.color,
//           width: 46,
//           height: 46,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 4),
//           child: Text(
//             listpaymodel.title,
//             textAlign: TextAlign.start,
//             style: const TextStyle(fontSize: 11),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Listpaymodel {
//   String _imagepath;
//   String _title;
//   Color _color;

//   Listpaymodel(this._imagepath, this._title, this._color);

//   Color get color => _color;

//   set color(Color value) {
//     _color = value;
//   }

//   String get title => _title;

//   set title(String value) {
//     _title = value;
//   }

//   String get imagepath => _imagepath;

//   set imagepath(String value) {
//     _imagepath = value;
//   }
// }
