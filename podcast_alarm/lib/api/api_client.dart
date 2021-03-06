import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podcast_alarm/data_layer/curated_list.dart';
import 'package:podcast_alarm/data_layer/genre.dart';
import 'package:podcast_alarm/data_layer/podcast.dart';

import 'api_error.dart';

abstract class Codable {
  Map<String, dynamic> toJson();

  Codable fromJson(Map<String, dynamic> json);
}

// the `jsonDecode` function in `convert` package does not support null or empty input
dynamic decodeJson(String jsonStr) {
  if (jsonStr == null || jsonStr.isEmpty) {
    return null;
  }
  return json.decode(jsonStr);
}

class ApiClient {
  //TODO: remove from here
  final _apiKey = "5ea579388b68424986c218c9b1e10872";
  final _baseUrl = "listen-api.listennotes.com";
  final _apiVersion = "/api/v2";
  Client _client;

  static ApiClient _instance;

  /// Get shared instance of ApiProvider with the default http client
  static ApiClient get sharedInstance {
    if (_instance == null) {
      _instance = ApiClient._internal();
    }
    return _instance;
  }

  /// Get shared instance of ApiProvider with the default http client
  factory ApiClient() {
    return sharedInstance;
  }

  ApiClient._internal();

  void dispose() {
    _client.close();
    _instance = null;
  }

  Future<ApiClient> setupApiClient({String proxy}) async {
    print("setting up ApiProvider...");
    if (ApiClient.sharedInstance._client != null) {
      print("api client is already setup");
      return ApiClient.sharedInstance;
    }

    ApiClient.sharedInstance._client = _createClient(proxy);
    return ApiClient.sharedInstance;
  }

  IOClient _createClient(String proxy) {
    if (proxy == null) {
      return Client();
    }
    HttpClient httpClient = HttpClient();
    httpClient.connectionTimeout = Duration(seconds: 30);
    httpClient.findProxy = (uri) {
      return "PROXY $proxy";
    };
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => Platform.isAndroid;
    IOClient client = IOClient(httpClient);
    return client;
  }

  Map<String, String> get _headers => {
        "Accept": "application/json",
        "X-ListenAPI-Key": _apiKey,
        "Content-Type": "application/json"
      };

  Map<String, String> get _baseQueryParameters => {
    "sort_by_date": "1",
    "len_min": "10",
    "len_max": "60",
    "safe_mode": "0"
  };

  Future<dynamic> _post(String path, Codable body,
      {Map<String, String> queryParameters}) async {
    print("POST $path");
    final String json = await compute(jsonEncode, body.toJson());
    final Response response =
        await _client.post("$_baseUrl$path", body: json, headers: _headers);
    return _processResponse(response);
  }

  Future<dynamic> _get(String path,
      {Map<String, String> queryParameters, String filename}) async {

    if (filename != null) {
      print(filename);
      try {
        Directory _dir = await getApplicationSupportDirectory();
        File _file = File("${_dir.path}/$filename");
        if (_file != null) {
          final String _response = await _file.readAsStringSync();
          return await compute(decodeJson, _response);
        }
      } catch (ex) {
        print("failed to read file $filename $ex");
      }
    }
    var uri = Uri.https(_baseUrl, "$_apiVersion$path", queryParameters);
    print("GET $uri");
    final Response response = await _client.get(uri, headers: _headers);
    return _processResponse(response, filename: filename);
  }

  Future<StreamedResponse> downloadFileToPath(String fileUrl, String id) async {
    final request = Request('GET', Uri.parse(fileUrl));
    return Client().send(request);
  }

  Future<dynamic> _processResponse(Response response, {String filename}) async {
    if (response.statusCode < 200 || response.statusCode >= 400) {
      ApiError apiError;
      try {
        final decodedObj = await compute(decodeJson, response.body);
        apiError = ApiError.fromJson(decodedObj);
      } catch (e) {
        print("[network_layer] cannot decode body. $e");
        apiError = ApiError.fromDescription("Oops! Something is wrong.");
      }
      apiError.httpStatusCode = response.statusCode;
      throw apiError;
    }

    if (filename != null) {
      try {
        Directory dir = await getApplicationSupportDirectory();
        File file = File("${dir.path}/$filename");
        await file.writeAsString(response.body);
      } catch (ex) {
        print("failed to write file $filename $ex");
      }
    }
    return await compute(decodeJson, response.body);
  }

  // Fetch pocasts
  Future<List<Podcast>> fetchPodcasts(String query, bool fromCache) async {
    final parameters = _baseQueryParameters;
    parameters.addAll({"q": query, "type": "podcast"});
    final resultArray = await _get("/search", queryParameters: parameters, filename: fromCache ? Podcast.cacheFilename : null);
    final podcastResults = resultArray["results"];
    List<Podcast> podcastList = List<Podcast>();
    podcastResults.map((result) {
       podcastList.add(Podcast.fromJson(result));
    }).toList();
    return podcastList;
  }

  //Fetch just listen
  Future<Podcast> fetchRandomPodcast() async {
    final json = await _get("/just_listen");
    return Podcast.fromJson(json);
  }

  //Fetch just listen
  Future<List<CuratedList>> fetchCuratedPodcasts() async {
    final resultArray = await _get("/curated_podcasts", filename: CuratedList.cacheFilename);
    final curatedResults = resultArray["curated_lists"];
    List<CuratedList> curatedLists = List<CuratedList>();
    curatedResults.map((result) {
      curatedLists.add(CuratedList.fromJson(result));
    }).toList();
    return curatedLists;
  }

  //Fetch genres
  Future<List<Genre>> fetchAllGenres() async {
    final resultArray = await _get("/genres", filename: Genre.cacheFilename);
    final genreArray = resultArray["genres"];
    List<Genre> genreList = List<Genre>();
    genreArray.map((json) {
      genreList.add(Genre.fromJson(json));
    }).toList();
    return genreList;
  }

  //Fetch genres
  Future<Podcast> podcastDetails(String podcastId) async {
    final json = await _get("/podcasts/$podcastId", queryParameters: {"sort": "recent_first"}, filename: "$podcastId-details.json");
    return Podcast.fromJson(json);
  }
}
