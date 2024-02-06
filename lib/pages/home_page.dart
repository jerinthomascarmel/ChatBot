import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/bloc/chat_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorText)));
          }
        },
        builder: (context, state) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.4,
                    image: AssetImage(
                      "assets/images/space.jpg",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 90,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "GEMINI POD",
                        style: TextStyle(
                            fontFamily: 'Sixtyfour',
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.image_search))
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: state is ChatInitial
                        ? 0
                        : (state is ChatSuccess)
                            ? state.messages.length
                            : (state as ChatFailure).messages.length,
                    itemBuilder: (context, index) {
                      final message = (state is ChatSuccess)
                          ? state.messages[index]
                          : (state as ChatFailure).messages[index];
                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 12, right: 16, left: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 147, 237, 2)
                                .withOpacity(0.2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.role == "user" ? "User" : "Bot",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: message.role == "user"
                                      ? Colors.amber
                                      : Colors.purple.shade200),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              message.parts.first.text,
                              style: const TextStyle(height: 1.2),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (state is ChatSuccess && state.isGenerating)
                  Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Lottie.asset('assets/images/loader.json'),
                      ),
                      const Text("Loading....")
                    ],
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  height: 80,
                  child: Row(children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                          hintText: "Ask me something",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 25),
                          fillColor: const Color.fromARGB(255, 85, 87, 88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor))),
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.text.isNotEmpty) {
                          context.read<ChatBloc>().add(
                              OnChatEventSendButtonClicked(
                                  inputMessage: controller.text.trim()));
                          controller.clear();
                        }
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
