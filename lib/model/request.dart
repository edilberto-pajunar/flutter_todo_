enum RequestType { get, post, delete, patch, put, update }

class RequestModel {
  final String url;
  final String endpoint;
  final RequestType type;
  final Map data;

  RequestModel({
    this.url = "672093b8cf285f60d77a5550.mockapi.io",
    required this.endpoint,
    required this.type,
    required this.data,
  });
}
