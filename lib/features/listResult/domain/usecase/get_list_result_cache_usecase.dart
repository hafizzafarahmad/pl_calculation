import 'package:dartz/dartz.dart';
import 'package:pl_calculation/features/listResult/domain/entities/list_result_entity.dart';
import 'package:pl_calculation/features/listResult/domain/repositories/list_result_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetListResultCacheUsecase extends UseCase<List<ListResultEntity>, NoParams>{
  final ListResultRepository listResultRepository;

  GetListResultCacheUsecase(this.listResultRepository);

  @override
  Future<Either<Failure, List<ListResultEntity>>> call(NoParams params) async {
    return await listResultRepository.getListResultCache();
  }
}