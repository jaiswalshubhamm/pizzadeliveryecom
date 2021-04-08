// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:transparent_image/transparent_image.dart';
// import '../config/palette.dart';
// import '../helpers/screenNavigation.dart';
// import '../models/category.dart';
// import '../providers/product.dart';
// import '../widgets/loading.dart';
// import '../widgets/product.dart';
// import '../screens/details.dart';

// class CategoryScreen extends StatelessWidget {
//   final CategoryModel categoryModel;

//   const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Loading(),
//                   ),
//                 ),
//                 ClipRRect(
//                   child: FadeInImage.memoryNetwork(
//                     placeholder: kTransparentImage,
//                     image: categoryModel.image,
//                     height: 160,
//                     fit: BoxFit.fill,
//                     width: double.infinity,
//                   ),
//                 ),
//                 Container(
//                   height: 160,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.6),
//                         Colors.black.withOpacity(0.6),
//                         Colors.black.withOpacity(0.6),
//                         Colors.black.withOpacity(0.4),
//                         Colors.black.withOpacity(0.1),
//                         Colors.black.withOpacity(0.05),
//                         Colors.black.withOpacity(0.025),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   bottom: 40,
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Text(
//                       categoryModel.name,
//                       style: TextStyle(
//                         color: Palette.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   top: 5,
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.all(4),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Palette.black.withOpacity(0.2),
//                           ),
//                           child: Icon(Icons.close, color: Palette.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Column(
//               children: productProvider.productsByCategory
//                   .map(
//                     (item) => GestureDetector(
//                       onTap: () {
//                         changeScreen(
//                           context,
//                           Details(product: item),
//                         );
//                       },
//                       child: ProductWidget(
//                         product: item,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
