// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Step {
  Map<Stock, int>? get stocks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StepCopyWith<Step> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepCopyWith<$Res> {
  factory $StepCopyWith(Step value, $Res Function(Step) then) =
      _$StepCopyWithImpl<$Res, Step>;
  @useResult
  $Res call({Map<Stock, int>? stocks});
}

/// @nodoc
class _$StepCopyWithImpl<$Res, $Val extends Step>
    implements $StepCopyWith<$Res> {
  _$StepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = freezed,
  }) {
    return _then(_value.copyWith(
      stocks: freezed == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as Map<Stock, int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StepCopyWith<$Res> implements $StepCopyWith<$Res> {
  factory _$$_StepCopyWith(_$_Step value, $Res Function(_$_Step) then) =
      __$$_StepCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<Stock, int>? stocks});
}

/// @nodoc
class __$$_StepCopyWithImpl<$Res> extends _$StepCopyWithImpl<$Res, _$_Step>
    implements _$$_StepCopyWith<$Res> {
  __$$_StepCopyWithImpl(_$_Step _value, $Res Function(_$_Step) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stocks = freezed,
  }) {
    return _then(_$_Step(
      stocks: freezed == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as Map<Stock, int>?,
    ));
  }
}

/// @nodoc

class _$_Step implements _Step {
  const _$_Step({final Map<Stock, int>? stocks}) : _stocks = stocks;

  final Map<Stock, int>? _stocks;
  @override
  Map<Stock, int>? get stocks {
    final value = _stocks;
    if (value == null) return null;
    if (_stocks is EqualUnmodifiableMapView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Step(stocks: $stocks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Step &&
            const DeepCollectionEquality().equals(other._stocks, _stocks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stocks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StepCopyWith<_$_Step> get copyWith =>
      __$$_StepCopyWithImpl<_$_Step>(this, _$identity);
}

abstract class _Step implements Step {
  const factory _Step({final Map<Stock, int>? stocks}) = _$_Step;

  @override
  Map<Stock, int>? get stocks;
  @override
  @JsonKey(ignore: true)
  _$$_StepCopyWith<_$_Step> get copyWith => throw _privateConstructorUsedError;
}
