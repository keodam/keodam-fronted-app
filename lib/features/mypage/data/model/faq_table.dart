import 'package:keodam/features/mypage/data/model/faq_item_data.dart';

const List<FaqItemData> faqList = [
  FaqItemData(
    question: '상대방에게 커피챗 신청을 했는데 다시 신청하고싶어요',
    answer:
        '이미 커피챗 신청한 경우, 같은 사용자에게 24시간 내에 다시 신청할 수 없어요. 하지만 다른 사용자에게는 커피챗 신청이 가능해요.',
  ),
  FaqItemData(
    question: '커피챗 매칭 약속을 취소하고 싶어요',
    answer:
        '커피챗이 성사된 이후 약속을 취소하고싶다면, 상호간의 동의가 이루어진 후 채팅방에서 오른쪽 상단 ...을 클릭 후 [약속 취소]를 통해 취소할 수 있어요.',
  ),
  FaqItemData(
    question: '구매한 원두를 환불받고 싶어요',
    answer:
        '구매한 원두에 대한 환불은 [상점]-[구매내역]-[환불]을 통해 가능해요. [환불] 상태가 아닌, [환불 불가] 상태의 경우는 구매한 원두를 일부라도 사용하였으므로 전체 환불이 불가하며, 커담은 구매시 이용약관에 따라 부분환불은 제공하고있지 않은 점 양해부탁드립니다.',
  ),
];
