// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Portfolio {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<Map<Stock, int>> get stocks => throw _privateConstructorUsedError;
  DateTime get nowDate => throw _privateConstructorUsedError;
  double? get balance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PortfolioCopyWith<Portfolio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioCopyWith<$Res> {
  factory $PortfolioCopyWith(Portfolio value, $Res Function(Portfolio) then) =
      _$PortfolioCopyWithImpl<$Res, Portfolio>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      List<Map<Stock, int>> stocks,
      DateTime nowDate,
      double? balance});
}

/// @nodoc
class _$PortfolioCopyWithImpl<$Res, $Val extends Portfolio>
    implements $PortfolioCopyWith<$Res> {
  _$PortfolioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? stocks = null,
    Object? nowDate = null,
    Object? balance = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stocks: null == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Map<Stock, int>>,
      nowDate: null == nowDate
          ? _value.nowDate
          : nowDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PortfolioCopyWith<$Res> implements $PortfolioCopyWith<$Res> {
  factory _$$_PortfolioCopyWith(
          _$_Portfolio value, $Res Function(_$_Portfolio) then) =
      __$$_PortfolioCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      List<Map<Stock, int>> stocks,
      DateTime nowDate,
      double? balance});
}

/// @nodoc
class __$$_PortfolioCopyWithImpl<$Res>
    extends _$PortfolioCopyWithImpl<$Res, _$_Portfolio>
    implements _$$_PortfolioCopyWith<$Res> {
  __$$_PortfolioCopyWithImpl(
      _$_Portfolio _value, $Res Function(_$_Portfolio) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? stocks = null,
    Object? nowDate = null,
    Object? balance = freezed,
  }) {
    return _then(_$_Portfolio(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stocks: null == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Map<Stock, int>>,
      nowDate: null == nowDate
          ? _value.nowDate
          : nowDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_Portfolio implements _Portfolio {
  const _$_Portfolio(
      {required this.id,
      required this.createdAt,
      required final List<Map<Stock, int>> stocks,
      required this.nowDate,
      this.balance})
      : _stocks = stocks;

  @override
  final int id;
  @override
  final DateTime createdAt;
  final List<Map<Stock, int>> _stocks;
  @override
  List<Map<Stock, int>> get stocks {
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stocks);
  }

  @override
  final DateTime nowDate;
  @override
  final double? balance;

  @override
  String toString() {
    return 'Portfolio(id: $id, createdAt: $createdAt, stocks: $stocks, nowDate: $nowDate, balance: $balance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Portfolio &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._stocks, _stocks) &&
            (identical(other.nowDate, nowDate) || other.nowDate == nowDate) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt,
      const DeepCollectionEquality().hash(_stocks), nowDate, balance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PortfolioCopyWith<_$_Portfolio> get copyWith =>
      __$$_PortfolioCopyWithImpl<_$_Portfolio>(this, _$identity);
}

abstract class _Portfolio implements Portfolio {
  const factory _Portfolio(
      {required final int id,
      required final DateTime createdAt,
      required final List<Map<Stock, int>> stocks,
      required final DateTime nowDate,
      final double? balance}) = _$_Portfolio;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  List<Map<Stock, int>> get stocks;
  @override
  DateTime get nowDate;
  @override
  double? get balance;
  @override
  @JsonKey(ignore: true)
  _$$_PortfolioCopyWith<_$_Portfolio> get copyWith =>
      throw _privateConstructorUsedError;
}
