import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController =
      TextEditingController(text: "Write some text");
  FlutterTts flutterTts = FlutterTts();
  double volumeRange = 0.5;
  double pitchrange = 1;
  double spearchange = 0.5;
  bool isSpeaking = false;
  play() async {
    final language = await flutterTts.getLanguages;
    print(language);
    await flutterTts.setLanguage(language[1]);
    final voice = await flutterTts.getVoices;
    print(voice);
    await flutterTts.setVoice({"name": "hi-in-x-hia-local", "locale": "hi-IN"});
    await flutterTts.speak(textEditingController.text);
    isSpeaking = true;
    setState(() {});
  }

  stop() async {
    await flutterTts.stop();
    isSpeaking = false;
    setState(() {});
  }

  pause() async {
    await flutterTts.pause();
    isSpeaking = false;
    setState(() {});
  }

  volume(val) async {
    volumeRange = val;
    await flutterTts.setVolume(volumeRange);
    setState(() {});
  }

  pitch(val) async {
    pitchrange = val;
    await flutterTts.setPitch(pitchrange);
    setState(() {});
  }

  speach(val) async {
    spearchange = val;
    await flutterTts.setSpeechRate(spearchange);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterTts.setCompletionHandler(() {
      isSpeaking = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Spech App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: textEditingController,
                maxLines: null,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintText: "Write some text",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AvatarGlow(
                glowColor: Color.fromARGB(255, 177, 33, 243),
                animate: isSpeaking,
                child: Material(
                  elevation: 10,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 118, 80, 255),
                    child: Icon(
                      Icons.mic_none_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                endRadius: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    splashRadius: 40,
                    color: Colors.teal,
                    iconSize: 60,
                    onPressed: () {
                      play();
                    },
                    icon: Icon(Icons.circle)),
                IconButton(
                    splashRadius: 40,
                    color: Colors.red,
                    iconSize: 60,
                    onPressed: () {
                      stop();
                    },
                    icon: Icon(Icons.stop_circle)),
                IconButton(
                    splashRadius: 40,
                    color: Colors.amber.shade700,
                    iconSize: 60,
                    onPressed: () {},
                    icon: Icon(Icons.pause_circle)),
              ],
            ),
            Slider(
              value: volumeRange,
              divisions: 10,
              max: 1,
              onChanged: (value) {
                volume(value);
              },
              label: "Volume: ${volumeRange}",
              activeColor: Colors.red,
            ),
            Slider(
              value: pitchrange,
              divisions: 10,
              max: 2,
              onChanged: (value) {
                pitch(value);
              },
              label: "Volume: ${pitchrange}",
              activeColor: Colors.red,
            ),
            Slider(
              value: spearchange,
              divisions: 10,
              max: 1,
              onChanged: (value) {
                speach(value);
              },
              label: "Volume: ${spearchange}",
              activeColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
