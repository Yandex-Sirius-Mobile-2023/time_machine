import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'FINHUB_KEY')
  static const finhubKey = _Env.finhubKey;
}
