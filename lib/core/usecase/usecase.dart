import 'package:fpdart/fpdart.dart';
import 'package:lendingmobile/core/error/index.dart';

abstract interface class UseCase<SuccessType, Params> {
  // call function can has n amount of parameters, so we use Params type for call function.
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
