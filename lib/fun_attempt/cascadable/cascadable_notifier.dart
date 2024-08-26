import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

///级联基类，混入了[NotifierGenericHelper]帮助[Filter]读取泛型类型
///
///{@macro NotifierGenericHelper}
abstract class Cascadable<T, V> extends ValueNotifier<V>
    with CascadableMixin<T, V>, NotifierGenericHelper<T, V> {
  Cascadable(super.value, {this.clearValueWhenParentChanged = true});

  @override
  final bool clearValueWhenParentChanged;
}

///级联能力
///
///{@macro NotifierGenericHelper}
mixin CascadableMixin<T, V> on ValueNotifier<V> {
  ///当父级改变时，会同时清空[AsyncOptionsProvider]类型的[dataSource]以及自身的[value]
  ///
  ///如果此值为false，那么只会清空[dataSource]的数据
  bool get clearValueWhenParentChanged => true;

  void clearValue();

  final List<CascadableMixin> _children = [];

  List<CascadableMixin> get children => _children.toList();
  final List<CascadableMixin> _parents = [];

  List<CascadableMixin> get parents => _parents.toList();

  OptionsProvider<T> get dataSource;

  void addChild(CascadableMixin child) {
    _children.add(child);
    child._addParent(this);
  }

  void _addParent(CascadableMixin parent) {
    _parents.add(parent);
  }

  @nonVirtual
  void clearOptionsData() {
    if (clearValueWhenParentChanged) {
      clearValue();
    }
    if (dataSource is AsyncOptionsProvider) {
      (dataSource as AsyncOptionsProvider).clearData();
    }
  }

  void clearChildrenData() {
    for (final item in _children) {
      item.clearOptionsData();
    }
  }

  @override
  set value(V newValue) {
    //绕过了去重步骤
    final oldValue = value;
    clearChildrenData();
    super.value = newValue;
    if (oldValue == newValue) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (final item in _parents) {
      item._children.remove(this);
    }
    _children.clear();
    super.dispose();
  }
}

class CascadableTextEditingController extends TextEditingController
    with CascadableMixin {
  CascadableTextEditingController({
    super.text,
    this.clearValueWhenParentChanged = true,
  });

  @override
  final bool clearValueWhenParentChanged;

  @override
  OptionsProvider get dataSource => EmptyOptionProvider();

  @override
  void clearValue() {
    updateText('');
  }
}

class CascadableValueNotifier<T> extends Cascadable<T, T?> {
  CascadableValueNotifier(
    super._value, {
    required this.dataSource,
    super.clearValueWhenParentChanged = true,
  });

  @override
  final OptionsProvider<T> dataSource;

  @override
  void clearValue() {
    value = null;
  }

  @override
  void clear() {
    value = null;
  }
}

class CascadableMultipleValueNotifier<T extends Object>
    extends Cascadable<T, Set<T>?> with MultipleValueNotifierMixin<T> {
  CascadableMultipleValueNotifier(
    super._value, {
    required this.dataSource,
    super.clearValueWhenParentChanged = true,
  });

  @override
  void clearValue() {
    clearSet();
  }

  @override
  final OptionsProvider<T> dataSource;

  @override
  bool add(T e) {
    final temp = super.add(e);
    if (temp) {
      clearChildrenData();
    }
    return temp;
  }

  @override
  bool remove(T e) {
    final temp = super.remove(e);
    if (temp) {
      clearChildrenData();
    }
    return temp;
  }

  @override
  bool clearSet() {
    final temp = super.clearSet();
    if (temp) {
      clearChildrenData();
    }
    return temp;
  }

  @override
  void clear() {
    clearSet();
  }
}


///{@template NotifierGenericHelper}
///***为什么[T]不同于[V]?***
///
///由于[ValueNotifier]的泛型类型可是[Iterable]\<T>, 但是我们实际需要的是类型[T]
///{@endtemplate}
mixin NotifierGenericHelper<T, V> on ValueNotifier<V> {
  Type get genericType => T;

  List<T?> get genericList => <T?>[];

  bool genericIsSubtypeOf<D>() => genericList is List<D?>;

  void clear();
}

mixin LoadMoreMixin<T> {
  List<T>? get data;

  set data(List<T>? value);

  int _nextPageNum = 1;

  int get nextPageNum => _nextPageNum;

  int get pageSize => 10;

  bool _isEnd = false;

  bool get isEnd => _isEnd;

  Future<void> loadMore({int? loaderIndex}) async {
    if (_isEnd) return;
    if (loaderIndex != null && data != null) {
      if (loaderIndex < data!.length) return;
    }
    return loadMoreData(_nextPageNum, pageSize).then((e) {
      if (e.isFailed) return;
      if (e.pageResult == null || e.pageResult!.length < pageSize) {
        _isEnd = true;
      }
      (data ??= []).addAll(e.pageResult ?? []);
      if (e.total != null) {
        _isEnd = data!.length >= e.total!;
      }
      if (_nextPageNum == 1 && data!.isNotEmpty) {
        onFirstPageLoaded(data!);
      }
      _nextPageNum++;
      onDataUpdated();
    });
  }

  Future<LoadMoreResult<T>> loadMoreData(int pageNum, int pageSize);

  void onDataUpdated();

  void onFirstPageLoaded(List<T> data) {}

  void reset() {
    _nextPageNum = 1;
    _isEnd = false;
    data = null;
    onDataUpdated();
  }
}

typedef LoadMoreBuilder<T> = Future<LoadMoreResult<T>> Function(
  int pageNum,
  int pageSize,
  String? filterString,
);

class AsyncPageOptionsProvider<T> extends OptionsProvider<T>
    with LoadMoreMixin<T> {
  AsyncPageOptionsProvider({required this.dataBuilder});

  final LoadMoreBuilder<T> dataBuilder;
  VoidCallback? onDataRefresh;

  String? _filterString;

  set filterString(String? value) {
    if (_filterString == value) return;
    _filterString = value;
    reset();
  }

  @override
  void onDataUpdated() {
    onDataRefresh?.call();
  }

  String? get filterString => _filterString;

  @override
  List<T>? get data => _data;

  @override
  set data(List<T>? value) {
    _data = value;
  }

  @override
  FutureOr<List<T>> getData() async {
    await loadMore();
    return data ?? [];
  }

  @override
  Future<LoadMoreResult<T>> loadMoreData(int pageNum, int pageSize) =>
      dataBuilder(pageNum, pageSize, filterString);
}

class AsyncOptionsProvider<T> extends OptionsProvider<T> {
  AsyncOptionsProvider({required this.dataBuilder});

  final FutureOr<List<T>?> Function() dataBuilder;

  @override
  FutureOr<List<T>> getData() async {
    if (_data == null) {
      final result = await dataBuilder();
      if (result?.isEmpty == true) {
        // toast(AppGlobals.l10n.noMatchingResult());
      }
      _data = result;
    }
    return _data ?? [];
  }

  void clearData() {
    _data = null;
  }
}

class EmptyOptionProvider<T> extends OptionsProvider<T> {
  @override
  FutureOr<List<T>> getData() => throw UnimplementedError('永远不应该被调用');
}

class StaticOptionsProvider<T> extends OptionsProvider<T> {
  StaticOptionsProvider(List<T> data) : super(data: data);

  @override
  FutureOr<List<T>> getData() => _data!;
}

abstract class OptionsProvider<T> {
  OptionsProvider({List<T>? data}) : _data = data;

  List<T>? _data;

  FutureOr<List<T>> getData();

  List<T>? getDataSync() => _data;
}

extension TextEditingControllerUpdate on TextEditingController {
  ///为了解决直接使用[TextEditingController.text]更新文本时，光标会跑到最前面的问题
  void updateText(String? text) {
    if (text == null || text.isEmpty) {
      clear();
      return;
    }
    value = TextEditingValue(
      selection: TextSelection.collapsed(offset: text.length),
      text: text,
    );
  }
}

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

mixin LoadMoreResult<T> on ApiResultable {
  List<T>? get pageResult;

  int? get total => null;
}

abstract class ApiResultable {
  const ApiResultable();

  bool get isSuccess;

  bool get isFailed => !isSuccess;
}
