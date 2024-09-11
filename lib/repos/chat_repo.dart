import 'dart:math';

import 'package:dio/dio.dart';
import 'package:space_pod/models/chat_message_model.dart';
import 'package:space_pod/utils/constants.dart';

class ChatRepo {

  static chatTextGenerationRepo( List<ChatMessageModel> previousMessages ) async {
    
   try{ 
     Dio dio = Dio();
    final response = dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=${API_KEY}",
    
    data:  {
            "content": previousMessages.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature" : 0.9,
              "topK" : 1,
              "topP" : 1,
              "maxOutputTokens": 2048,
              "stopSequence" :
            },
            "safetyRatings": [
                {
                    "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                    "probability": "NEGLIGIBLE"
                },
                {
                    "category": "HARM_CATEGORY_HATE_SPEECH",
                    "probability": "NEGLIGIBLE"
                },
                {
                    "category": "HARM_CATEGORY_HARASSMENT",
                    "probability": "NEGLIGIBLE"
                },
                {
                    "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                    "probability": "NEGLIGIBLE"
                }
            ]
        }
    );
    log(response.toString() as num);
   } catch(e) {
    log(e.toString() as num);
   }
  }
}