import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/education_status_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_status_service.g.dart';

@riverpod
EducationStatusService educationStatusService(Ref ref) {
  return EducationStatusService(ref: ref);
}

enum StudentStatus {
  highSchoolGraduate,
  universityStudent,
  universityGraduate23,
  universityGraduate4,
  jobSeeker,
  employee,
}

enum StudentStatusApi {
  HIGH_SCHOOL_GRADUATE,
  UNIVERSITY_STUDENT,
  UNIVERSITY_GRADUATE_2_3,
  UNIVERSITY_GRADUATE_4,
  JOB_SEEKER,
  EMPLOYEE,
}

class EducationStatusService {
  final Ref ref;

  EducationStatusService({
    required this.ref,
  });

  /// 재학상태 업데이트
  Future<Either<Failure, bool>> updateStudentStatus(StudentStatus? studentStatus) async {
    // 유효성 검증
    if (studentStatus == null) {
      return const Left(Failure.serverFailure(message: '재학상태를 선택해주세요.'));
    }

    // UI enum을 API enum으로 변환
    final apiStatus = _toApiEnum(studentStatus);
    final apiStatusString = apiStatus.name;

    final repository = ref.read(educationStatusRepositoryProvider);
    return await repository.updateStudentStatus(apiStatusString);
  }

  /// StudentStatus를 StudentStatusApi로 변환
  StudentStatusApi _toApiEnum(StudentStatus status) {
    switch (status) {
      case StudentStatus.highSchoolGraduate:
        return StudentStatusApi.HIGH_SCHOOL_GRADUATE;
      case StudentStatus.universityStudent:
        return StudentStatusApi.UNIVERSITY_STUDENT;
      case StudentStatus.universityGraduate23:
        return StudentStatusApi.UNIVERSITY_GRADUATE_2_3;
      case StudentStatus.universityGraduate4:
        return StudentStatusApi.UNIVERSITY_GRADUATE_4;
      case StudentStatus.jobSeeker:
        return StudentStatusApi.JOB_SEEKER;
      case StudentStatus.employee:
        return StudentStatusApi.EMPLOYEE;
    }
  }
}