// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Stock _$StockFromJson(Map<String, dynamic> json) {
  return _Stock.fromJson(json);
}

/// @nodoc
mixin _$Stock {
  StockTicker get ticker => throw _privateConstructorUsedError;
  Map<DateTime, double> get quotesHistory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StockCopyWith<Stock> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockCopyWith<$Res> {
  factory $StockCopyWith(Stock value, $Res Function(Stock) then) =
      _$StockCopyWithImpl<$Res, Stock>;
  @useResult
  $Res call({StockTicker ticker, Map<DateTime, double> quotesHistory});
}

/// @nodoc
class _$StockCopyWithImpl<$Res, $Val extends Stock>
    implements $StockCopyWith<$Res> {
  _$StockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticker = null,
    Object? quotesHistory = null,
  }) {
    return _then(_value.copyWith(
      ticker: null == ticker
          ? _value.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as StockTicker,
      quotesHistory: null == quotesHistory
          ? _value.quotesHistory
          : quotesHistory // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StockCopyWith<$Res> implements $StockCopyWith<$Res> {
  factory _$$_StockCopyWith(_$_Stock value, $Res Function(_$_Stock) then) =
      __$$_StockCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StockTicker ticker, Map<DateTime, double> quotesHistory});
}

/// @nodoc
class __$$_StockCopyWithImpl<$Res> extends _$StockCopyWithImpl<$Res, _$_Stock>
    implements _$$_StockCopyWith<$Res> {
  __$$_StockCopyWithImpl(_$_Stock _value, $Res Function(_$_Stock) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticker = null,
    Object? quotesHistory = null,
  }) {
    return _then(_$_Stock(
      ticker: null == ticker
          ? _value.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as StockTicker,
      quotesHistory: null == quotesHistory
          ? _value._quotesHistory
          : quotesHistory // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Stock implements _Stock {
  const _$_Stock(
      {required this.ticker,
      required final Map<DateTime, double> quotesHistory})
      : _quotesHistory = quotesHistory;

  factory _$_Stock.fromJson(Map<String, dynamic> json) =>
      _$$_StockFromJson(json);

  @override
  final StockTicker ticker;
  final Map<DateTime, double> _quotesHistory;
  @override
  Map<DateTime, double> get quotesHistory {
    if (_quotesHistory is EqualUnmodifiableMapView) return _quotesHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_quotesHistory);
  }

  @override
  String toString() {
    return 'Stock(ticker: $ticker, quotesHistory: $quotesHistory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Stock &&
            (identical(other.ticker, ticker) || other.ticker == ticker) &&
            const DeepCollectionEquality()
                .equals(other._quotesHistory, _quotesHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, ticker, const DeepCollectionEquality().hash(_quotesHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StockCopyWith<_$_Stock> get copyWith =>
      __$$_StockCopyWithImpl<_$_Stock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StockToJson(
      this,
    );
  }
}

abstract class _Stock implements Stock {
  const factory _Stock(
      {required final StockTicker ticker,
      required final Map<DateTime, double> quotesHistory}) = _$_Stock;

  factory _Stock.fromJson(Map<String, dynamic> json) = _$_Stock.fromJson;

  @override
  StockTicker get ticker;
  @override
  Map<DateTime, double> get quotesHistory;
  @override
  @JsonKey(ignore: true)
  _$$_StockCopyWith<_$_Stock> get copyWith =>
      throw _privateConstructorUsedError;
}
