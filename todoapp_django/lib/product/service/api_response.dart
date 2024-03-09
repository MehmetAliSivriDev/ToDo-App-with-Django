enum ApiResponse { deleteSuccess, errorTitle }

extension ApiResponseExtension on ApiResponse {
  String getRepsonse() {
    switch (this) {
      case ApiResponse.deleteSuccess:
        return "Note was deleted!";
      case ApiResponse.errorTitle:
        return "Error";
    }
  }
}
