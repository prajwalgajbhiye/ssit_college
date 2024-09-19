// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../../components/colors.dart';
// import 'forgot_password_screen.dart';
// import 'student_sign_in.dart';
//
// class NewPasswordScreen extends StatefulWidget {
//   final String email; // Accept email from ForgotPassword screen
//
//   const NewPasswordScreen({super.key, required this.email});
//
//   @override
//   _NewPasswordScreenState createState() => _NewPasswordScreenState();
// }
//
// class _NewPasswordScreenState extends State<NewPasswordScreen> {
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _reEnterPasswordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
//   String _errorMessage = '';
//
//   // Method to change the password
//   Future<void> _changePassword() async {
//     String newPassword = _newPasswordController.text.trim();
//     String reEnterPassword = _reEnterPasswordController.text.trim();
//
//     if (newPassword.isEmpty || reEnterPassword.isEmpty) {
//       setState(() {
//         _errorMessage = "Please fill in both password fields.";
//       });
//       return;
//     }
//
//     if (newPassword != reEnterPassword) {
//       setState(() {
//         _errorMessage = "Passwords do not match.";
//       });
//       return;
//     }
//
//     try {
//       // Ensure the user is logged in using their email (from ForgotPassword)
//       User? user = await _auth.currentUser;
//
//       if (user != null) {
//         // Update the password
//         await user.updatePassword(newPassword);
//
//         // Show success dialog
//         showCupertinoDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return CupertinoAlertDialog(
//               title: const Text('Password Changed Successfully'),
//               content: const Text('Your password has been updated.'),
//               actions: <Widget>[
//                 CupertinoDialogAction(
//                   isDefaultAction: true,
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.pop(context); // Close the popup
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const StudentSignIn()),
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           _errorMessage = "No user is logged in.";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error: Could not change password. ${e.toString()}';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Container(
//         height: MediaQuery.of(context).size.height * 1,
//         width: MediaQuery.of(context).size.width * 1,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             colors: [
//               backgroundColor2,
//               backgroundColor2,
//               backgroundColor4,
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//                 top: 60,
//                 left: 20,
//                 child: Column(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                 const ForgotPassword())); // Navigate back to ForgotPassword
//                       },
//                       icon: const Icon(
//                         Icons.arrow_back,
//                         color: Colors.black,
//                         size: 40,
//                       ),
//                     ),
//                   ],
//                 )),
//             const Positioned(
//                 top: 105,
//                 left: 35,
//                 child: Text(
//                   "BACK",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 )),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     // Funny professional text at the top
//                     Text(
//                       "Let's get serious... time to set a new password!",
//                       style: TextStyle(
//                         color: loginButtonColor,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 40),
//                     // New password field
//                     TextField(
//                       controller: _newPasswordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'New Password',
//                         labelStyle: TextStyle(color: labelColor),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade900),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         suffixIcon: const Icon(Icons.visibility_off),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     // Re-enter password field
//                     TextField(
//                       controller: _reEnterPasswordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Re-enter New Password',
//                         labelStyle: TextStyle(color: labelColor),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey.shade900),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         suffixIcon: const Icon(Icons.visibility_off),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     // Submit button
//                     ElevatedButton(
//                       onPressed: _changePassword, // Call the method to change password
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: loginButtonColor,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16, horizontal: 120),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Submit',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                     if (_errorMessage.isNotEmpty)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Text(
//                           _errorMessage,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     // Funny professional text at the bottom
//                     Text(
//                       "Mission accomplished! Password reset like a pro.",
//                       style: TextStyle(
//                         color: loginButtonColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
