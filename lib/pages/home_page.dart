import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
              image: DecorationImage(opacity: 0.1, image: AssetImage("assets/space_bg2.jpeg"), fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 100,
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
                Expanded(child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber.withOpacity(0.1)
                    ),
                    child: Column(crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [
                        Text(messages[index].role =="user" 
                        ? "User"
                        : "Space Pod",
                        style: TextStyle(
                          fontSize: 14, 
                          color: 
                            messages[index].role =="user" 
                        ? Colors.amber
                        : Colors.purple.shade200
                        ),),
                        Text(messages[index].parts.first.text, style: TextStyle(height: 1.2),),
                      ],
                    ));
                })),
                if(chatBloc.genereating)                 Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Lottie.asset("assets/loaders.json")),
                      SizedBox(width: 20,),
                      Text('Loading...')
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  height: 120,
                 // color: Colors.blue,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: textEditingController ,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            fillColor: Colors.white,
                            hintText: 'Ask Something to Ai',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
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
                          if(textEditingController.text.isNotEmpty){
                            String text = textEditingController.text;
                            textEditingController.clear();
                            chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                          }
                        },
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Center(
                                child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ))),
                      )
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
