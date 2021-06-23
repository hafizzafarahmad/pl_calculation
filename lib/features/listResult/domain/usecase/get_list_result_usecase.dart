import 'package:dartz/dartz.dart';
import 'package:pl_calculation/core/error/failures.dart';
import 'package:pl_calculation/core/usecase/usecase.dart';
import 'package:pl_calculation/features/listResult/data/models/list_pengajuan_model.dart';
import 'package:pl_calculation/features/listResult/domain/repositories/list_result_repository.dart';


class GetListResultUsecase extends UseCase<ListResultModel, NoParams>{
  final ListResultRepository listResultRepository;

  GetListResultUsecase(this.listResultRepository);

  Future<Either<Failure, ListResultModel>> call(NoParams params) async {
    return await listResultRepository.getListResult();
  }
}