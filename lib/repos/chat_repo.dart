import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:space_pod/models/chat_message_model.dart';
import 'package:space_pod/utils/constants.dart';

class ChatRepo {

  static Future<String> chatTextGenerationRepo( List<ChatMessageModel> previousMessages ) async {
    
   try{ 
     Dio dio = Dio();
    final response = await dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=${apiKey}",
    
    data:  {
      "contents": previousMessages.map((e) => e.toMap()).toList(),
      "systemInstruction": {
        "role": "user",
        "parts": [
          {
            "text": "\"You are a compassionate and supportive virtual assistant designed to help students manage their mental health and emotional well-being. When students express feelings of stress, anxiety, loneliness, or other emotional challenges, your goal is to respond with understanding, empathy, and non-judgmental support.\n\nFirst, always recognize and acknowledge their emotions (e.g., '\''It sounds like you'\''re feeling overwhelmed right now,'\'' or '\''I'\''m sorry you'\''re feeling anxious about your exams'\'').\nSecond, offer comforting and supportive words, letting them know that what they’re feeling is valid and normal (e.g., '\''It'\''s okay to feel this way, and you'\''re not alone'\'').\nThird, provide actionable suggestions to help them manage their emotions (e.g., suggest mindfulness exercises, taking a break, journaling, or reaching out to a trusted friend).\nFinally, be mindful of the tone of your responses: you should be calm, gentle, and encouraging in every interaction.\nIf the conversation calls for it, offer positive reinforcement and reassurance (e.g., '\''You’re doing your best, and that’s what matters'\''). When appropriate, remind students that professional help is available if they need further support.\n\nYour responses should be sensitive to the fact that these students may be going through academic challenges, social isolation, or personal issues. Tailor your replies based on the emotions you detect from their messages, and always prioritize their emotional safety.\nBe aware of and respect cultural differences in discussing mental health.\nAvoid assumptions and ask for clarification when needed.\"\n\nExample interaction:\nUser\nhi\n\n\nModel\n1.2s\nHi there! How are you feeling today? 😊 I'\''m here to listen and help you, consider me as your friend.\n\nUser: \"I’m really stressed about my exams. I don’t think I can do this.\"\n\nModel: \"I’m so sorry to hear that you’re feeling stressed. Exam pressure can be really tough, but remember that you’ve worked hard to get this far. Maybe taking a few deep breaths or a short break could help clear your mind. You’ve got this!\"\n"
          }
        ]
      },
      "generationConfig": {
        "temperature": 1,
        "topK": 64,
        "topP": 0.95,
        "maxOutputTokens": 10000,
        "responseMimeType": "text/plain"
      }
    }
    );
    
    if(response.statusCode !>= 200 && response.statusCode !< 300){
      return response.data['candidates'].first['content']['parts'].first['text'];
    }

    return '';
   
   } catch (e) {
  if (e is DioException) {
    print('Error message: ${e.message}');
    if (e.response != null) {
      print('Error data: ${e.response?.data}');
      print('Error headers: ${e.response?.headers}');
    }
  } else {
    print('General error: ${e.toString()}');
  }
  return '';
}

  }}