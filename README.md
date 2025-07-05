# keodam
2025 멘토-멘티 커피챗 플랫폼, Keodam의 프론트엔드 앱 저장소입니다.

## Git 브랜치 전략 및 커밋 컨벤션
### 브랜치 전략
- main: 실제 배포용 브랜치 (운영 환경 기준)
- develop: 개발용 통합 브랜치 (모든 기능은 여기서 통합)
- feature/기능명: 개별 기능 작업 브랜치

### 작업 흐름
1. Jira에 각자의 파트 및 주차별 작업 항목 할 일 목록(task) 생성
2. github keodam_app 저장소에 issue 생성 
3. 작업 시작 전 develop 브랜치에서 feature/기능명 브랜치 생성
4. 기능 개발 완료 후 본인 확인 → PR 생성 (Pull Request)
5. 최소 **두 명 이상의 코드 리뷰 및 승인** 후 develop 브랜치로 merge
6. 병합 후 feature/기능명 브랜치 삭제

- Jira는 일정 관리용, github issue에 세부 할 일 목록 작성


### 커밋 메시지 컨벤션
- Feat : 새로운 기능 추가
- Modify : 기존 기능 수정
- Fix : 버그 수정
- Chore : 빌드 작업
- Refactor : 파일 및 코드 리팩토링 (기능 변경사항 없음)
- Docs : 문서 수정 이거 바탕으로 생성해줘

### 빌드
- `dart run build_runner watch -d`
- flutter_gen: 빌드 후 `Assets.icons.clock`처럼 사용. `import 'package:keodam/gen/assets.gen.dart';`