import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'newsinfo.dart';

enum NewsAction { Fetch, Delete }

class NewsBloc {
  // ignore: non_constant_identifier_names
  final _StateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get newssink => _StateStreamController.sink;
  Stream<List<Article>> get newsstream => _StateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventsink => _eventStreamController.sink;
  Stream<NewsAction> get eventstream => _eventStreamController.stream;

  NewsBloc() {
    eventstream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await getNews();
          if (news != null) {
            newssink.add(news.articles);
          } else {
            newssink.addError("Something Went Wrong!!");
          }
        } on Exception catch (e) {
          newssink.addError("something went wrong");
        }
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      var response = await http.get(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=3fb3cf0b9246413eaced2c2b3c2fae03');
      print(response.body);
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxx2");
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
