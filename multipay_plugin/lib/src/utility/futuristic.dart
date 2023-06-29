import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget that makes it easy to execute a [Future] from a StatelessWidget.
class Futuristic<T> extends StatefulWidget {
  /// Function that returns the [Future] to execute. Not the [Future] itself.
  final AsyncValueGetter<T> futureBuilder;

  /// Whether to immediately begin executing the [Future]. If true, [initialBuilder] must be null.
  final bool autoStart;

  /// Widget to display before the [Future] starts executing.
  /// Call [VoidCallback] to start executing the [Future].
  /// If not null, [autoStart] should be false.
  final Widget Function(BuildContext, VoidCallback)? initialBuilder;

  /// Widget to display while the [Future] is executing.
  /// If null, a [CircularProgressIndicator] will be displayed.
  final WidgetBuilder? busyBuilder;

  /// Widget to display when the [Future] has completed with an error.
  /// If null, [initialBuilder] will be displayed again.
  /// The [Object] is the [Error] or [Exception] returned by the [Future].
  /// Call [VoidCallback] to start executing the [Future] again.
  final Widget Function(BuildContext, Object, VoidCallback)? errorBuilder;

  /// Widget to display when the [Future] has completed successfully.
  /// If null, [initialBuilder] will be displayed again.
  final Widget Function(BuildContext, T)? dataBuilder;

  /// Callback to invoke when the [Future] has completed successfully.
  /// Will only be invoked once per [Future] execution.
  final ValueChanged<T>? onData;

  /// Callback to invoke when the [Future] has completed with an error.
  /// Will only be invoked once per [Future] execution.
  /// Call [VoidCallback] to start executing the [Future] again.
  final Function(Object, VoidCallback)? onError;

  final bool forceUpdate;

  const Futuristic({
    Key? key,
    required this.futureBuilder,
    this.autoStart = false,
    this.initialBuilder,
    this.busyBuilder,
    this.errorBuilder,
    this.dataBuilder,
    this.onData,
    this.onError,
    this.forceUpdate = false,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FuturisticState<T> createState() => _FuturisticState<T>();
}

class _FuturisticState<T> extends State<Futuristic<T>> {
  Future<T>? _future;

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      _execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.forceUpdate) {
      _execute();
    }

    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _handleInitial(context);
          case ConnectionState.waiting:
          case ConnectionState.active:
            return _handleBusy(context);
          case ConnectionState.done:
            //return _handleBusy(_context);
            return _handleSnapshot(context, snapshot);
          default:
            return _defaultWidget();
        }
      },
    );
  }

  Widget _handleInitial(BuildContext context) {
    if (widget.initialBuilder != null) {
      return widget.initialBuilder!(context, _execute);
    }
    return _defaultWidget();
    //return widget.initialBuilder(context, _execute);
  }

  Widget _handleSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) {
      return _handleError(context, snapshot.error as Object);
    }
    return _handleData(context, snapshot.data as T);
  }

  Widget _handleError(BuildContext context, Object error) {
    if (widget.errorBuilder != null) {
      //return widget.errorBuilder(context, error, _execute);
      return widget.errorBuilder!(context, error, _execute);
    }
    return _handleInitial(context);
  }

  Widget _handleData(BuildContext context, T data) {
    if (widget.dataBuilder != null) {
      //return widget.dataBuilder(context, data);
      return widget.dataBuilder!(context, data);
    }
    return _handleInitial(context);
  }

  Widget _handleBusy(BuildContext context) {
    if (widget.busyBuilder == null) {
      return _defaultBusyWidget();
    }
    //return widget.busyBuilder(context);
    return widget.busyBuilder!(context);
  }

  void _execute() {
    setState(() {
      _future = widget.futureBuilder();
      //_future.then(_onData).catchError(_onError);
      _future!.then(_onData).catchError(_onError);
    });
  }

  void _onData(T data) async {
    if (widget.onData != null && _isActive()) {
      //widget.onData(data);
      widget.onData!(data);
    }
  }

  void _onError(Object e) async {
    if (widget.onError != null && _isActive()) {
      //widget.onError(e, _execute);
      widget.onError!(e, _execute);
    }
  }

  bool _isActive() => mounted && (ModalRoute.of(context)?.isActive ?? true);

  Widget _defaultBusyWidget() =>
      const Center(child: CircularProgressIndicator());

  Widget _defaultWidget() => const SizedBox.shrink();
}
