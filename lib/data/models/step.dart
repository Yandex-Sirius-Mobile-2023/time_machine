import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:intl/intl.dart';


part 'step.freezed.dart';

@freezed

class Step with _$Step {
  const factory Step({
    Map<Stock, int>? stocks,
  }) = _Step;
}
