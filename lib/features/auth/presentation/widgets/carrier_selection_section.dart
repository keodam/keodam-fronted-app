import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/enums/carrier_type.dart';
import 'package:keodam/features/auth/providers/auth_provider.dart';

class CarrierSelectionSection extends ConsumerWidget {
  final FocusNode phoneFocusNode;
  const CarrierSelectionSection({super.key, required this.phoneFocusNode});

  Future<void> _showCarrierBottomSheet(BuildContext outerContext, WidgetRef ref) async {
    final selected = await showModalBottomSheet<CarrierType>(
      context: outerContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: CarrierType.values.map((carrier) {
              return ListTile(
                title: Text(carrier.toLabel),
                onTap: () => Navigator.pop(sheetContext, carrier),
              );
            }).toList(),
          ),
        );
      },
    );

    if (selected != null && outerContext.mounted) {
      ref.read(authNotifierProvider.notifier).setSelectedCarrier(selected.toLabel);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (phoneFocusNode.canRequestFocus) {
          FocusScope.of(outerContext).requestFocus(phoneFocusNode);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('통신사', style: AppTextStyle.medium16),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showCarrierBottomSheet(context, ref),
          child: Container(
            width: 131,
            height: 37,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(authState.selectedCarrier, style: AppTextStyle.regular12.copyWith(color: Colors.black)),
                const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
