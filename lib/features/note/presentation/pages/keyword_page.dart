import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_notes/features/note/presentation/pages/home_page.dart';
import 'package:my_notes/utils/encrypt_util.dart';

class KeywordPage extends StatefulWidget {
  const KeywordPage({super.key});

  @override
  State<KeywordPage> createState() => _KeywordPageState();
}

class _KeywordPageState extends State<KeywordPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: LottieBuilder.asset(
              'assets/lotties/corner.json',
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Input Your Keyword',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(controller: _controller),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () {
                        try {
                          changeKey(_controller.text);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (_) => false,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
