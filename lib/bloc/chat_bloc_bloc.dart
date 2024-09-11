import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_pod/models/chat_message_model.dart';
import 'package:space_pod/repos/chat_repo.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);

    
  }
  List <ChatMessageModel> messages = [];
  
  FutureOr<void> chatGenerateNewTextMessageEvent
  (ChatGenerateNewTextMessageEvent event, Emitter<ChatBlocState> emit) async {
    messages.add(ChatMessageModel(role: "user", parts: [
      ChatPartModel(text: event.inputMessage)
    ]));
    emit(ChatSuccessState(messages:  messages));
    await ChatRepo.chatTextGenerationRepo(messages);
  }
}
