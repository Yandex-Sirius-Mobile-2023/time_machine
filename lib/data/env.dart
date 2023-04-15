import 'package:envied/envied.dart';

part '../core/utils/env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'FINHUB_KEY')
  static const finhubKey = _Env.finhubKey;
}
