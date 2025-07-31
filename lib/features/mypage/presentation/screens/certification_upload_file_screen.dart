import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keodam/core/presentation/widgets/basic_lg_button.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';

class CertificationUploadFileScreen extends ConsumerStatefulWidget {
  const CertificationUploadFileScreen({super.key});

  @override
  ConsumerState<CertificationUploadFileScreen> createState() =>
      _CertificationUploadFileScreenState();
}

class _CertificationUploadFileScreenState
    extends ConsumerState<CertificationUploadFileScreen> {
  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  void resetImage() {
    setState(() {
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: '인증하기'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 38),
            ImagePreview(selectedImage: selectedImage, onTap: pickImage),
            SizedBox(height: 8),
            Center(child: ResetButton(onPressed: resetImage)),
            SizedBox(height: 50),
            NoticeField(),
            Spacer(),
            BasicLgButton(
              text: '전송',
              onPressed: () {
                //TODO: API 연동 (POST), 서버로 전송
                if (selectedImage != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleButtonDialog(
                        title: '업로드가 성공적으로 완료되었습니다.',
                        message: '업로드 한 파일은 운영자 확인 후, \n24시간 내로 뱃지가 반영됩니다.',
                        onPressed: () {
                          context.pop();
                          resetImage();
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreview extends ConsumerWidget {
  final File? selectedImage;
  final VoidCallback onTap;

  const ImagePreview({
    super.key,
    required this.selectedImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 285,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child:
              selectedImage == null
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4D9EFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '파일 첨부 (.jpg, .png)',
                        style: AppTextStyle.regular12.copyWith(color: textGray),
                      ),
                    ],
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 280,
                    ),
                  ),
        ),
      ),
    );
  }
}

class ResetButton extends ConsumerWidget {
  final VoidCallback onPressed;
  const ResetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 21),
        child: Text(
          '다시선택',
          style: AppTextStyle.medium12.copyWith(color: textBlack),
        ),
      ),
    );
  }
}

class NoticeField extends ConsumerWidget {
  const NoticeField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyle.regular12.copyWith(color: textGray),
            children: [
              const TextSpan(
                text: '첨부 파일에 포함된 개인정보는 개인정보처리방침에 따라 보호됩니다.\n자세한 내용은 ',
              ),
              TextSpan(
                text: '개인정보 수집 및 이용약관',
                style: AppTextStyle.regular12.copyWith(
                  color: textBlack,
                  decoration: TextDecoration.underline,
                ),
              ),
              const TextSpan(text: '을 참조해주세요.\n\n'),
              const TextSpan(text: '사문서 위조로 인한 사용자 불이익에 대해서는 커담은 책임을 지지 않습니다.'),
            ],
          ),
        ),
      ],
    );
  }
}
