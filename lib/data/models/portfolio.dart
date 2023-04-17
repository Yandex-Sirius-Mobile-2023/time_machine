import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio.freezed.dart';

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    required int id,
    required DateTime createdAt,
    required List<Step> steps,
    required DateTime nowDate,
    required double balance,
  }) = _Portfolio;
}

