import 'dart:io';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:podcast_alarm/api/api_client.dart';
import 'package:podcast_alarm/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class DownloadBloc implements Bloc {
  BehaviorSubject<double> progressStream = BehaviorSubject<double>();
  BehaviorSubject<bool> fileExistsStream = BehaviorSubject<bool>();
  BehaviorSubject<dynamic> completionStream = BehaviorSubject<dynamic>();
  final _client = ApiClient();

  Future<Directory> _downloadsDirectory() async {
    Directory dir = await getApplicationSupportDirectory();
    return Directory("${dir.path}/downloads/");
  }

  void fileExistsForEpisode(String episodeId) async {
    Directory downloadsDir = await _downloadsDirectory();
    bool exists = await File("${downloadsDir.path}$episodeId.mp3").exists();
    fileExistsStream.sink.add(exists);
  }

  void downloadEpisode(String url, String id) async {
    List<int> fileBytes = [];
    double _progress = 0;
    final StreamedResponse responseStream =
        await _client.downloadFileToPath(url, id);

    responseStream.stream.listen(
      (List<int> newBytes) {
        fileBytes.addAll(newBytes);
        final downloadedLength = fileBytes.length;
        _progress = (downloadedLength / responseStream.contentLength);
        progressStream.sink.add(_progress);
      },
      onDone: () async {
        Directory downloadsDir = await _downloadsDirectory();
        final directoryExists = await downloadsDir.exists();
        if (!directoryExists) {
          downloadsDir.create(recursive: true);
        }
        File file = File("${downloadsDir.path}$id.mp3");
        file.writeAsBytes(fileBytes, flush: true);
        completionStream.sink.add(file.path);
      },
      onError: (Object e) {
        completionStream.sink.add(e);
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    progressStream.close();
    fileExistsStream.close();
    completionStream.close();
  }
}
