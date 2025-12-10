import 'package:web/web.dart' as web;

/// Downloads a file from the given URL with the specified filename (Web only)
void downloadFileWeb(String url, String fileName) {
  final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
  anchor.href = url;
  anchor.download = fileName;
  anchor.click();
}
