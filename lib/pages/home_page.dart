import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_pod/bloc/chat_bloc_bloc.dart';
import 'package:space_pod/models/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBlocBloc chatBloc = ChatBlocBloc();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          switch(state.runtimeType) {
            case ChatSuccessState:
            List<ChatMessageModel> messages = (state as ChatSuccessState).messages;
            return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/space_bg.jpeg")),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 120,
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Space Pod',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                      Icon(
                        Icons.image_search,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Expanded(child: ListView()),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  height: 120,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor))),
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Center(
                              child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )))
                    ],
                  ),
                ),
              ],
            ),
          );

          default: 
          return SizedBox();
          }
        },
      ),
    );
  }
}
