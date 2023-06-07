import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Lowerback_Screen extends StatefulWidget {
  const Lowerback_Screen({Key? key}) : super(key: key);

  @override
  State<Lowerback_Screen> createState() => _Lowerback_ScreenState();
}

class _Lowerback_ScreenState extends State<Lowerback_Screen> {
  Future getbicepdata() async {
    const String baseUrl = 'https://api.api-ninjas.com/v1/exercises?muscle=lower_back';

    final response = await http.get(Uri.parse(baseUrl),
        headers:{
          'X-Api-Key' : 'mfrQtjxqpeGJ89zSI3tcXg==lSgfNiDZd5qFymCb'
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lowerback Exercises"),
          backgroundColor: Colors.green[300],),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: '750nkDg9XPI',
                    // Place your video ID here
                    flags: YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                      isLive: false,
                      showLiveFullscreenButton: false,
                      hideControls: false,
                      controlsVisibleAtStart: true,

                    ),

                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.green,
                  progressColors: ProgressBarColors(backgroundColor: Colors.green),

                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder(
                  future: getbicepdata(),
                  builder: (BuildContext context,snapshot) {
                    final data = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8,),
                                  Center(child: Text("Exercise ${index+1}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.green[400]),)),
                                  Text(
                                    'Name :',
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ,color: Colors.green[400]),
                                  ),
                                  Text(
                                    '${data[index]['name']}',
                                    style: TextStyle(fontSize: 18, ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Type :',
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[400]),
                                  ),
                                  Text(
                                    '${data[index]['type']}',
                                    style: TextStyle(fontSize: 18, ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Muscle :',
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[400]),
                                  ),
                                  Text(
                                    '${data[index]['muscle']}',
                                    style: TextStyle(fontSize: 18, ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Difficulty :',
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[400]),
                                  ),
                                  Text(
                                    '${data[index]['difficulty']}',
                                    style: TextStyle(fontSize: 18, ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Instructions :',
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[400]),
                                  ),
                                  Text(
                                    '${data[index]['instructions']}',
                                    style: TextStyle(fontSize: 18, ),
                                  ),

                                ],
                              ),
                            );
                          });
                    }
                  }
              ),
            ),
          ],
        )
    );
  }
}
