import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/domain/services/phone_verification_service.dart';
import 'package:keodam_app/routes/app_router.dart';
import 'package:keodam_app/share/app_flush_bar.dart';
import 'package:keodam_app/share/share_button.dart';
import 'package:keodam_app/share/share_text_field.dart';
import 'package:keodam_app/share/utils/time_formatter.dart';
import 'package:keodam_app/styles/app_colors.dart';

class PhoneVerificationPage extends HookConsumerWidget {
  const PhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final nameController = useTextEditingController();
    final birthController = useTextEditingController();
    final genderController = useTextEditingController();
    final phoneController = useTextEditingController();
    final verificationCodeController = useTextEditingController();

    final selectedCarrier = useState<String>('0');
    final isVerificationSent = useState(false);
    final remainingTime = useState(0);
    final verificationCodeLength = useState(0);

    // 타이머 관리
    useEffect(() {
      Timer? timer;
      if (remainingTime.value > 0) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (remainingTime.value > 0) {
            remainingTime.value--;
          } else {
            timer.cancel();
          }
        });
      }
      return () => timer?.cancel();
    }, [remainingTime.value]);

    // 인증번호 입력 감지
    useEffect(() {
      void listener() {
        verificationCodeLength.value = verificationCodeController.text.length;
      }
      verificationCodeController.addListener(listener);
      return () => verificationCodeController.removeListener(listener);
    }, []);

    String formattedTime() {
      return TimeFormatter.formatSeconds(remainingTime.value);
    }
    return Scaffold(
      appBar: AppBar(title: Text('휴대폰 본인인증')),
      body: SafeArea(
        child:Column(

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // 이름 입력
                  ShareTextField(
                    label: '이름(실명)',
                    hintText: '이름 입력',
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  // 생년월일 입력
                  Text('생년월일'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ShareTextField(
                          hintText: '생년월일 6자리',
                          controller: birthController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                            // BirthDateInputFormatter(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShareTextField(
                        width: 60,
                        hintText: '●',
                        controller: genderController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '●●●●●●',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 통신사 선택
                  Text('통신사'),
                  const SizedBox(height: 8),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: AppColors.inputBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedCarrier.value,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.gray600,
                      ),
                      items: [
                        DropdownMenuItem(value: '0', child: Text('SKT')),
                        DropdownMenuItem(value: '1', child: Text('KT')),
                        DropdownMenuItem(value: '2', child: Text('LGU+')),
                        DropdownMenuItem(value: '3', child: Text('SKT알뜰폰')),
                        DropdownMenuItem(value: '4', child: Text('KT알뜰폰')),
                        DropdownMenuItem(value: '5', child: Text('LGU+알뜰폰')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          selectedCarrier.value = value;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 휴대폰번호 입력
                  const Text('휴대폰번호'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ShareTextField(
                          hintText: '휴대폰번호 입력',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShareButton.smallOutline(
                        text: '인증요청',
                        onPressed: () async {
                          // 유효성 검사
                          if (nameController.text.isEmpty) {
                            AppFlushbar.showWarning(
                              context: context,
                              message: '이름을 확인해주세요. (ex.홍길동)',
                            );
                            return;
                          }

                          if (birthController.text.length != 6 || genderController.text.isEmpty) {
                            AppFlushbar.showWarning(
                              context: context,
                              message: '생년월일을 확인해주세요. (ex.990508 - 2)',
                            );
                            return;
                          }

                          if (phoneController.text.length != 11) {
                            AppFlushbar.showWarning(
                              context: context,
                              message: '휴대폰번호 형식을 확인해주세요. (ex.01012345678)',
                            );
                            return;
                          }

                          // Service 사용
                          final service = ref.read(phoneVerificationServiceProvider);
                          
                          final phoneNumber = phoneController.text.replaceAll('-', '');
                          final userGender = (genderController.text == "1" || genderController.text == "3") ? true : false;
                          final userRealName = nameController.text;
                          final userBirth = birthController.text;

                          final result = await service.sendVerificationCode(
                            phoneNumber: phoneNumber,
                            userRealName: userRealName,
                            userBirth: userBirth,
                            userGender: userGender,
                          );

                          result.fold(
                            (failure) {
                              // 에러 처리
                              String errorMessage = '인증 요청에 실패했습니다.';
                              
                              if (failure is NetworkFailure) {
                                errorMessage = failure.message ?? '네트워크 연결을 확인해주세요.';
                              } else if (failure is ServerFailure) {
                                errorMessage = failure.message ?? '서버 오류가 발생했습니다.';
                              } else if (failure is UnauthorizedFailure) {
                                errorMessage = failure.message ?? '인증이 필요합니다.';
                              } else if (failure is UnknownFailure) {
                                errorMessage = failure.message ?? '알 수 없는 오류가 발생했습니다.';
                              }
                              
                              AppFlushbar.showError(
                                context: context,
                                message: errorMessage,
                              );
                            },
                            (success) {
                              // 성공 처리
                              isVerificationSent.value = true;
                              remainingTime.value = 167; // 2:47
                              AppFlushbar.showSuccess(
                                context: context,
                                message: '인증번호가 발송되었습니다.',
                              );
                            },
                          );

                        },
                      ),
                    ],
                  ),


                  if (isVerificationSent.value) ...[
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text.rich(TextSpan(children: [
                          TextSpan(text: '휴대폰으로 전송된\n',
                            style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.inputBackground,),),
                          TextSpan(text: '인증번호',
                            style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,),),
                          TextSpan(text: '를 입력해주세요',
                            style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.inputBackground,),),
                        ],),),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ShareTextField(
                                hintText: '인증번호 입력',
                                controller: verificationCodeController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                fillColor: Colors.white,
                                suffix: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    formattedTime(),
                                    style: const TextStyle(
                                      color: AppColors.error,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ShareButton.smallOutline(
                              text: '다시요청',
                              disabled: remainingTime.value != 0,
                              onPressed: () async {
                                // Service 사용하여 인증 요청 재전송
                                final service = ref.read(phoneVerificationServiceProvider);
                                
                                final phoneNumber = phoneController.text.replaceAll('-', '');
                                final userGender = (genderController.text == "1" || genderController.text == "3") ? true : false;
                                final userRealName = nameController.text;
                                final userBirth = birthController.text;

                                final result = await service.sendVerificationCode(
                                  phoneNumber: phoneNumber,
                                  userRealName: userRealName,
                                  userBirth: userBirth,
                                  userGender: userGender,
                                );

                                result.fold(
                                  (failure) {
                                    String errorMessage = '인증 요청에 실패했습니다.';
                                    
                                    if (failure is NetworkFailure) {
                                      errorMessage = failure.message ?? '네트워크 연결을 확인해주세요.';
                                    } else if (failure is ServerFailure) {
                                      errorMessage = failure.message ?? '서버 오류가 발생했습니다.';
                                    } else if (failure is UnauthorizedFailure) {
                                      errorMessage = failure.message ?? '인증이 필요합니다.';
                                    } else if (failure is UnknownFailure) {
                                      errorMessage = failure.message ?? '알 수 없는 오류가 발생했습니다.';
                                    }
                                    
                                    AppFlushbar.showError(
                                      context: context,
                                      message: errorMessage,
                                    );
                                  },
                                  (success) {
                                    // 성공 처리
                                    remainingTime.value = 167; // 2:47
                                    verificationCodeController.clear();
                                    AppFlushbar.showSuccess(
                                      context: context,
                                      message: '인증번호가 재발송되었습니다.',
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: ShareButton(
                text: '인증 완료하기',
                onPressed: isVerificationSent.value &&
                    verificationCodeLength.value == 6
                    ? () async {
                  // Service 사용
                  final service = ref.read(phoneVerificationServiceProvider);
                  
                  final phoneNumber = phoneController.text.replaceAll('-', '');
                  final userGender = (genderController.text == "1" || genderController.text == "3") ? true : false;
                  final userRealName = nameController.text;
                  final userBirth = birthController.text;

                  final result = await service.verifyCode(
                    phoneNumber: phoneNumber,
                    code: verificationCodeController.text,
                    userRealName: userRealName,
                    userGender: userGender,
                    userBirth: userBirth,
                  );

                  result.fold(
                    (failure) {
                      // 에러 처리
                      String errorMessage = '인증 확인에 실패했습니다.';
                      
                      if (failure is NetworkFailure) {
                        errorMessage = failure.message ?? '네트워크 연결을 확인해주세요.';
                      } else if (failure is ServerFailure) {
                        errorMessage = failure.message ?? '서버 오류가 발생했습니다.';
                      } else if (failure is UnauthorizedFailure) {
                        errorMessage = failure.message ?? '인증이 필요합니다.';
                      } else if (failure is UnknownFailure) {
                        errorMessage = failure.message ?? '알 수 없는 오류가 발생했습니다.';
                      }
                      
                      AppFlushbar.showError(
                        context: context,
                        message: errorMessage,
                      );
                    },
                    (success) {
                      // 성공 처리
                      AppFlushbar.showSuccess(
                        context: context,
                        message: '인증이 완료되었습니다.',
                      );
                      // 잠시 후 프로필 설정 페이지로 이동
                      Future.delayed(const Duration(milliseconds: 500), () {
                        context.pushNamed(AppRoutes.signUpProfile.name);
                      });
                    },
                  );
                }
                    : null,
                width: double.infinity,
              ),
            ),

          ],
        ),
      ),
    );

  }


}


