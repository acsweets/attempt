import 'package:flutter/widgets.dart';

typedef MultipleValueNotifierRemovedItemBuilder<T> = Widget Function(
    BuildContext context,
    T option,
    Animation<double> animation,
    );

class MultipleValueNotifier<T> extends ValueNotifier<Set<T>?>
    with MultipleValueNotifierMixin<T> {
  MultipleValueNotifier(super.value);
}

mixin MultipleValueNotifierMixin<T> on ValueNotifier<Set<T>?> {
  GlobalKey<AnimatedListState>? _animatedListSlot;
  MultipleValueNotifierRemovedItemBuilder<T>? _removedItemBuilder;

  void attachToAnimatedList(
      GlobalKey<AnimatedListState>? listKey,
      MultipleValueNotifierRemovedItemBuilder<T> removedItemBuilder,
      ) {
    _animatedListSlot = listKey;
    _removedItemBuilder = removedItemBuilder;
  }

  void detachFromAnimatedList() {
    _animatedListSlot = null;
    _removedItemBuilder = null;
  }

  Set<T> get finalValue => super.value ??= {};
  @override
  Set<T> get value => super.value ?? {};
  @override
  set value(Set<T>? value) => super.value = value ?? {};

  @mustCallSuper
  bool add(T e) {
    _animatedListSlot?.currentState?.insertItem(0);
    final temp = value.add(e);
    if (temp) {
      notifyListeners();
    }
    return temp;
  }

  @mustCallSuper
  void addAll(Iterable<T> elements) {
    _animatedListSlot?.currentState?.insertAllItems(0, elements.length);
    value.addAll(elements);
    notifyListeners();
  }

  @mustCallSuper
  bool remove(T e) {
    final index = value.length - 1 - value.toList().indexOf(e);
    _animatedListSlot?.currentState?.removeItem(
      index,
          (context, animation) => _removedItemBuilder!(context, e, animation),
    );
    final temp = value.remove(e);
    if (temp) {
      notifyListeners();
    }
    return temp;
  }

  @mustCallSuper
  void removeAll(Iterable<T> elements) {
    final state = _animatedListSlot?.currentState;
    if (state != null) {
      for (final e in elements) {
        final index = value.length - 1 - value.toList().indexOf(e);
        state.removeItem(
          index,
              (context, animation) => _removedItemBuilder!(context, e, animation),
        );
      }
    }
    value.removeAll(elements);
    notifyListeners();
  }

  @mustCallSuper
  bool clearSet() {
    _animatedListSlot?.currentState
        ?.removeAllItems((context, animation) => const SizedBox.shrink());
    final temp = value.isNotEmpty;
    if (temp) {
      value.clear();
      notifyListeners();
    }
    return temp;
  }

  @override
  void dispose() {
    detachFromAnimatedList();
    super.dispose();
  }
}
