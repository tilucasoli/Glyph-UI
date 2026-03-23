abstract class WidgetCustomProperty<R, V> {
  const WidgetCustomProperty();

  factory WidgetCustomProperty.resolveWith(R Function(V value) resolve) {
    return _WidgetCustomPropertyWith<R, V>(resolve);
  }

  R resolve(V value);
}

class _WidgetCustomPropertyWith<R, V> extends WidgetCustomProperty<R, V> {
  _WidgetCustomPropertyWith(R Function(V value) resolve) : _resolve = resolve;

  final R Function(V value) _resolve;

  @override
  R resolve(V value) => _resolve(value);
}
