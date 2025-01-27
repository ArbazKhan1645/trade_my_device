// import 'package:flutter/material.dart';
// import 'package:food_ecommerce/constants/constants_colors.dart';
// import 'package:food_ecommerce/providers/authentication_repository.dart';
// import 'package:food_ecommerce/providers/dashboard_provider.dart';
// import 'package:food_ecommerce/screens/authentication/widgets/textfield_widget.dart';
// import 'package:provider/provider.dart';

// class ForgetPassword extends StatefulWidget {
//   const ForgetPassword({super.key});

//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }

// class _ForgetPasswordState extends State<ForgetPassword> {
//   TextEditingController emailController = TextEditingController();
//   String passwordSent = '';

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<FoodEcommerceProvider>(context);
//     return Column(
//       children: [
//         Image.asset(
//           'images/logo.png',
//           color: AppColors.primaryColor,
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           'Reset your HSE Techno Password',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         const Padding(
//           padding: EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 10),
//           child: Text(
//             'Submit your email address and well send you a link to reset your password',
//             textAlign: TextAlign.center,
//           ),
//         ),
//         TextFieldWidget(hintText: 'Email', controller: emailController),
//         controller.authenticationError.isNotEmpty
//             ? Padding(
//                 padding: const EdgeInsets.only(
//                     left: 100, right: 100, top: 20, bottom: 10),
//                 child: Text(
//                   controller.authenticationError,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               )
//             : passwordSent.isEmpty
//                 ? Container()
//                 : Padding(
//                     padding: const EdgeInsets.only(
//                         left: 100, right: 100, top: 20, bottom: 10),
//                     child: Text(
//                       passwordSent,
//                       style: const TextStyle(color: Colors.green),
//                     ),
//                   ),
//         Padding(
//           padding:
//               const EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 10),
//           child: MaterialButton(
//             padding: const EdgeInsets.all(0),
//             onPressed: () async {
//               passwordSent = '';
//               if (emailController.text.isEmpty) {
//                 controller.setAuthenticationError('Please enter Email');
//               } else {
//                 controller.setAuthenticationError('');
//                 controller.setAuthenticationLoading(true);

//                 await AuthenticationRepository.updatePassword(
//                   context: context,
//                   email: emailController.text,
//                 ).then((value) {
//                   passwordSent = 'reset Link Successfully sent to your email';
//                 });

//                 controller.setAuthenticationLoading(false);
//               }
//             },
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(6),
//                   color: AppColors.primaryColor),
//               child: const Center(
//                 child: Text(
//                   'Submit',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 22),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         TextButton(
//             onPressed: () {
//               controller.setselectedShowDialog('Login');
//             },
//             child: Text(
//               'Back To Sign in',
//               style: TextStyle(
//                   color: AppColors.headingTextColor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 17),
//             )),
//       ],
//     );
//   }
// }
