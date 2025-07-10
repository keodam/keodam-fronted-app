import 'package:flutter/widgets.dart';

import '../presentation/widgets/app__how_to_use_widget.dart';
import '../presentation/widgets/app_start_prompt_widget.dart';
import '../presentation/widgets/app_use_cases_widget.dart';

final List<Widget> onboardingPages = const [
  AppUseCasesWidget(),
  AppHowToUseWidget(),
  AppStartPromptWidget(),
];