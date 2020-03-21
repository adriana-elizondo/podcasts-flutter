/*
  401 wrong api key or your account is suspended
  404 endpoint not exist, or podcast / episode not exist
  429 you are using FREE plan and you exceed the quota limit
  500 something wrong on our end
 */

class ApiError implements Exception {
  int httpStatusCode;
  String _description;

  ApiError(this.httpStatusCode);

  ApiError.fromJson(Map<String, dynamic> json) {
    httpStatusCode = json['statusCode'];
    _description = "No description available";
  }

  ApiError.fromDescription(String description) {
    this._description = description;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = this.httpStatusCode;
    data.keys.where((k) => data[k] == null).toList().forEach(data.remove);
    return data;
  }

  String get errorDescription {
    switch (errorType) {
      case ApiErrorType.backendError:
        return "Backend error";
      case ApiErrorType.wrongApiKeyOrSuspendedAccount:
        return "You are using a wrong API key or your account was suspended";
      case ApiErrorType.endpointDoesntExist:
        return "The endpoint doesn't exist";
      case ApiErrorType.exceededQuotaLimit:
        return "Quota limit for Listen API was exceeded";
      case ApiErrorType.unknown:
        return _description;
    }
  }
  ApiErrorType get errorType {
    switch (httpStatusCode) {
      case 401:
        return ApiErrorType.wrongApiKeyOrSuspendedAccount;
      case 404:
        return ApiErrorType.endpointDoesntExist;
      case 429:
        return ApiErrorType.exceededQuotaLimit;
      case 500:
        return ApiErrorType.backendError;
      default:
        return ApiErrorType.unknown;
    }
  }
}

enum ApiErrorType{
  wrongApiKeyOrSuspendedAccount,
  endpointDoesntExist,
  exceededQuotaLimit,
  backendError,
  unknown
}