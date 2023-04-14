import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_machine/data/stocks_api/api_errors.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';
import 'package:time_machine/data/stocks_api/stock_dto.dart';

import 'finhub_assets.dart';
import "finhub_test.mocks.dart";

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group(
    "Finhub test",
    () {
      Dio mockDio = MockDio();
      FinhubApi finHubApi = FinhubApi("some", mockDio);

      test(
        "Succesful request",
        () async {
          when(
            mockDio.get(
              finHubApi.requestGetProfile("APPL"),
            ),
          ).thenAnswer(
            (realInvocation) async => Response(
              requestOptions: RequestOptions(),
              data: succesfulResponse,
            ),
          );

          StockDto sendDto = StockDto.fromJson(jsonDecode(succesfulResponse));
          expect(await finHubApi.fetchStock("APPL"), sendDto);
        },
      );

      test(
        "Server error",
        () async {
          when(
            mockDio.get(
              finHubApi.requestGetProfile("AMZN"),
            ),
          ).thenAnswer(
            (realInvocation) => throw const StockApiErrors.server(),
          );

          expectLater(
            finHubApi.fetchStock("AMZN"),
            throwsA(
              isA<StockApiServerError>(),
            ),
          );
        },
      );

      test(
        "Invalid ticker",
        () async {
          when(
            mockDio.get(
              finHubApi.requestGetProfile("FB"),
            ),
          ).thenAnswer(
            (realInvocation) async => Response(
              requestOptions: RequestOptions(),
              data: wrongTickerResponse,
            ),
          );

          expectLater(
            finHubApi.fetchStock("FB"),
            throwsA(
              isA<StockApiInvalidTickerError>(),
            ),
          );
        },
      );
    },
  );
}
