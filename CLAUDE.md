# 응답 규칙
* 정확한 응답을 위해 최대한 비판적으로 대응합니다.
* 한국어로 응답합니다.
* 빠른 해결 보다는 지침에 따른 올바른 해결을 해야합니다.

# 코드 생성 규칙
* `import '../../domain/entities/health_check_entity.dart';` 이처럼 ...은 사용하지 않습니다.
* entity, dto는 모두 freezed로 생성합니다. freezed는 3버전 이후로 class가 아닌 상황에 맞게 abstract 또는 sealed로 사용 되어야 합니다.
* riverpod 을 사용할 때는 riverpod best practice를 따릅니다.
* riverpod provider 생성시 ref인자가 필요하다면 Ref 형식으로 받아야 합니다. ex: (HealthRepositoryRef ref) -> (Ref ref)
* StatefulWidget이나 ConsumerStatefulWidget을 사용하지 않고, hooks_riverpod을 사용합니다.
* 모든 flutter 명령어는 fvm을 사용해야 합니다 -> flutter pub get -> fvm flutter pub get
* YAGNI 원칙을 절대적으로 지킵니다.
* 모르는 것에 대해서는 모른다고 대답하고 코드를 수정하지 않습니다.
* 코드 작성 전에 반드시 관련 파일(AppColors, AppTextStyles, AppDimensions 등)을 Read로 확인하여 실제 존재하는 변수만 사용합니다. 존재하지 않는 변수나 속성을 추측하여 사용하지 않습니다.

## Widget 구현 규칙
* **Widget 클래스 구현 필수**: UI를 표현하는 모든 Widget은 반드시 클래스(class)로 구현해야 합니다.
* **함수형 Widget 금지**: `Widget _buildSomething() { return ...; }` 형태의 함수형 Widget 구현을 절대 금지합니다.
* **Private Widget 클래스**: 파일 내부에서만 사용되는 Widget은 `class _MyPrivateWidget extends StatelessWidget` 형태로 구현합니다.
* **성능보다 구조 우선**: Widget을 함수로 바꾸는 성능 최적화는 금지하며, 클래스 구조를 유지해야 합니다.
* **예외 사항 없음**: 단순한 UI라도 반드시 클래스로 구현하며, 함수형 Widget 사용은 어떤 경우에도 허용되지 않습니다.

## 성능 최적화

- 불필요한 rebuild를 방지하기 위해 위젯을 적절히 분리합니다
- const 생성자를 최대한 활용합니다
- Heavy computation은 어디에서 처리할지 고민합니다.

# 빌드 규칙
* 빌드는 자동으로 이루어 지므로 절대로 수동으로 빌드하지 않습니다.(Never execute like fvm flutter pub run build_runner build --delete-conflicting-outputs)

# 기능 구현 규칙
* 아키텍쳐는 클린 아키텍쳐를 따르며 Presentation -> Domain -> Data 순으로 의존성을 가집니다.
* [스크랩 목록](lib/features/scrap/presentation/pages/scrapped_jobs_page.dart) 예시를 참고하여 기능을 구현합니다.

## Presentation Layer
### 폴더 구조
* `lib/features/[name]/presentation` 하위에 기능별 폴더를 생성하여 관리합니다.
* constants - 각종 상수, enum, extension 등을 관리합니다.
* pages - 화면 단위의 Widget을 관리합니다. [라우터 관리](lib/app/router/app_router.dart) 에서 호출됩니다.
* providers
  * UI 상태관리만 담당하는 provider를 관리합니다.(비즈니스 로직 X)
  * 순수하게 UI 상태 관리만 담당하고 비즈니스(도메인) 로직은 도메인(서비스) 레이어에서 처리합니다. 
  * Domain Layer의 Service를 호출하여 상태를 관리합니다.
* states - page에서 사용하는 상태(state)를 관리합니다.
* utils - presentation layer에서 사용하는 유틸리티 함수를 관리합니다.
* views - 화면을 구성하는 Widget을 관리합니다.
* widgets - 재사용 가능한 Widget을 관리합니다.

## Domain Layer
### 폴더 구조
* `lib/features/[name]/domain` 하위에 기능별 폴더를 생성하여 관리합니다.
* entities - 기능에서 사용하는 Entity를 관리합니다.
* services
  * 기능에서 도메인(비즈니스)로직을 구현하는 Service를 관리합니다. 
  * Presentation Layer에서 호출되며, Data Layer의 Repository를 호출합니다.
  * Data Layer의 DTO를 Entity로 변환하는 역할도 수행합니다.
  * 응답 및 예외 처리
    * dartz.dart를 사용하여 Either 타입으로 성공과 실패를 명확히 구분합니다.
    * [실패](lib/core/error/failures.dart)에서 정의한 Failure 클래스를 사용합니다.
    * [에러](lib/core/error/exceptions.dart)에서 정의한 Exception 클래스를 사용합니다.

## Data Layer
### 폴더 구조
* `lib/features/[name]/data` 하위에 기능별 폴더를 생성하여 관리합니다.
* dtos - 기능에서 사용하는 DTO를 관리합니다. toEntity 메서드를 포함합니다.
* repositories - 기능에서 사용하는 Repository를 관리합니다. 
  * Domain Layer의 Service에서 호출되며, 외부 API 통신, 로컬 DB 접근 등의 작업을 수행합니다.
  * DTO를 Entity로 변환하는 역할은 Service에 위임합니다.
  * (api)API는 graphql을 사용하여 graphql_codegen을 통해 자동 생성된 코드를 활용합니다.
  * 응답 및 예외 처리
    * dartz.dart를 사용하여 Either 타입으로 성공과 실패를 명확히 구분합니다.
    * [실패](lib/core/error/failures.dart)에서 정의한 Failure 클래스를 사용합니다.
    * [에러](lib/core/error/exceptions.dart)에서 정의한 Exception 클래스를 사용합니다.
* (api)

