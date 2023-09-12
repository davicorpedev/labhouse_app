import 'package:labhouse_app/domain/error/failures.dart';

const String serverFailureMessage = 'Server Failure';
const String networkFailureMessage = 'Network Failure';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case NetworkFailure:
      return networkFailureMessage;
    default:
      return 'Unexpected Error';
  }
}
