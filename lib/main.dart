import 'package:flutter/material.dart';
import 'package:yoga_app/domain/entities/yoga_videos.dart';
import 'package:yoga_app/data/api/service.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Lulu'z Yoga"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<YogaVideo>> futureYogaVideos;

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://youtube.com')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://player.vimeo.com/video/846252187?h=677c94156a'));

  @override
  void initState() {
    super.initState();
    futureYogaVideos = YogaService().fetchYogaVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<YogaVideo>>(
          future: futureYogaVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // print(snapshot.data![index].link);
                    return Center(
                      child: Column(
                        children: [
                          Text(snapshot.data![index].name),
                          Container(
                            height: 300, // Ajustez la hauteur selon vos besoins
                            width: double.infinity,
                            child: WebViewWidget(controller: controller),
                          ),
                          Text(snapshot.data![index].duration.toString()),
                        ],
                      ),
                    );
                  }); // Use the data to build your UI
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
