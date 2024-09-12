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
            "generationConfig": {
              "temperature" : 0.9,
              "topK" : 1,
              "topP" : 1,
              "maxOutputTokens": 2048,
              
            },
            // "safetyRatings": [
            //     {
            //         "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            //         "probability": "NEGLIGIBLE"
            //     },
            //     {
            //         "category": "HARM_CATEGORY_HATE_SPEECH",
            //         "probability": "NEGLIGIBLE"
            //     },
            //     {
            //         "category": "HARM_CATEGORY_HARASSMENT",
            //         "probability": "NEGLIGIBLE"
            //     },
            //     {
            //         "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            //         "probability": "NEGLIGIBLE"
            //     }
            // ]
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