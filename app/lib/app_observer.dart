import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver({this.onLog});

  final void Function(String log)? onLog;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    onLog?.call('BLOC EVENT: ${bloc.runtimeType} $event');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    onLog?.call('BLOC CREATED: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    onLog?.call('BLOC CHANGE: ${bloc.runtimeType}, from: ${change.currentState}, to: ${change.nextState}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    onLog?.call('BLOC ERROR: ${bloc.runtimeType}, error: $error');
    onLog?.call('BLOC ERROR STACKTRACE: \n$stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    onLog?.call('BLOC CLOSED: ${bloc.runtimeType}');
  }
}
