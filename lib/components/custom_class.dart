import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormContainer extends StatelessWidget {
  final String formName;
  final String formImage;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const FormContainer(
      {super.key,
      required this.formName,
      required this.formImage,
      required this.onTap,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width * 0.2,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    formImage,
                    fit: BoxFit.cover,
                  ),
                ),
                // Optional gradient overlay for a more professional look
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
                // Text overlay
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    formName,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoticeContainer extends StatelessWidget {
  final String noticeText;
  final Color backgroundColor;
  final Color textColor;

  const NoticeContainer(
      {super.key,
      required this.noticeText,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        alignment: Alignment.centerLeft,
        height: size.height * 0.05,
        width: size.width * 0.9,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            noticeText,
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ListFormContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  const ListFormContainer(
      {super.key, required this.backgroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                child: Icon(Icons.edit_document),
                backgroundColor: Colors.black,
                radius: 30,
              ),
              Text(
                "Re-Assesment form",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              Icon(Icons.touch_app)
            ],
          ),
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  final bool first;
  final bool last;
  final TextEditingController controller;

  const OtpField(
      {super.key,
      required this.first,
      required this.last,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        autofocus: first,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabled: true,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.grey.shade900),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && !last) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}

class AnimatedUserContainer extends StatefulWidget {
  final Map<String, String> user;
  final int containerNumber;

  const AnimatedUserContainer(
      {Key? key, required this.user, required this.containerNumber})
      : super(key: key);

  @override
  _AnimatedUserContainerState createState() => _AnimatedUserContainerState();
}

class _AnimatedUserContainerState extends State<AnimatedUserContainer> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: _isPressed
                ? MediaQuery.of(context).size.height * 0.15
                : MediaQuery.of(context).size.height * 0.17,
            width: _isPressed
                ? MediaQuery.of(context).size.width * 0.85
                : MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.symmetric(
                horizontal: _isPressed ? 2.0 : 4.0,
                vertical: _isPressed ? 4.0 : 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient:
                  LinearGradient(colors: [Colors.purple.shade100, Colors.grey]),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(5, 5), color: Colors.black, blurRadius: 5)
              ],
              border: Border.all(
                  color: Colors.black, width: 3, style: BorderStyle.solid),
            ),
            child: Transform.scale(
              scale: _isPressed ? 0.95 : 1.0,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Username: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: TextField(
                                controller: TextEditingController(
                                    text: widget.user['username']!),
                                readOnly: true,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Password: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: TextField(
                                controller: TextEditingController(
                                    text: widget.user['password']!),
                                readOnly: true,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, size: 20),
                              onPressed: () {
                                // Share username logic
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 25,
                    child: IconButton(
                      icon: const Icon(Icons.copy, size: 20),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text:
                                'Username: ${widget.user['username']} \nPassword: ${widget.user['password']}'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard!'),
                          ),
                        );
                      },
                    ),
                  ),
                  // Positioned(
                  //   bottom: 35,
                  //   right: 25,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.share, size: 20),
                  //     onPressed: () {
                  //       // Share username logic
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
