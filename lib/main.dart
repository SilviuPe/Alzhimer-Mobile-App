import 'package:flutter/material.dart';
import 'pages/all_options.dart';
import 'pages/settings.dart';
import 'pages/test.dart';
import 'pages/home.dart';

import 'pages/cognitive_support_and_memory_pages/main.dart';
import 'pages/cognitive_support_and_memory_pages/dashboard.dart';
import 'pages/cognitive_support_and_memory_pages/what_am_i_doing.dart';
import 'pages/cognitive_support_and_memory_pages/ai_check_in.dart';
import 'pages/cognitive_support_and_memory_pages/digital_storybook.dart';
import 'pages/cognitive_support_and_memory_pages/locked_down_mode.dart';

import 'pages/safety_and_communication/main.dart';
import 'pages/safety_and_communication/ai_video_call_suggestions.dart';
import 'pages/safety_and_communication/auto_emergency_calling.dart';
import 'pages/safety_and_communication/caregiver_portal.dart';

import 'pages/therapy_and_recreation/main.dart';
import 'pages/therapy_and_recreation/cognitive_puzzle_coach.dart';
import 'pages/therapy_and_recreation/guided_drawing_app.dart';
import 'pages/therapy_and_recreation/relaxation_breathing_coach.dart';
import 'pages/therapy_and_recreation/smart_garden_app.dart';
import 'pages/therapy_and_recreation/virtual_pet_companion.dart';

import 'pages/accessibility_and_medical/main.dart';
import 'pages/accessibility_and_medical/ai_symptom_reporter.dart';
import 'pages/accessibility_and_medical/hearing_aid_companion.dart';
import 'pages/accessibility_and_medical/live_translation_assistant.dart';
import 'pages/accessibility_and_medical/speech_to_text_notes.dart';
import 'pages/accessibility_and_medical/vitals_tracker.dart';


import 'pages/hardware_addons_and_ergonomics/main.dart';
import 'pages/hardware_addons_and_ergonomics/mount_stand_addon.dart';
import 'pages/hardware_addons_and_ergonomics/popsocket_attachment.dart';
import 'pages/hardware_addons_and_ergonomics/wrist_lanyard.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Android App',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/all-options': (context) => AllOptions(),

        '/cognitive-options-page': (context) => CognitiveHomePage(),
        'cognitive-options-page/settings': (context) => SettingsPage(),
        'cognitive-options-page/dashboard': (context) => DashboardPage(),
        'cognitive-options-page/waid': (context) => WhatAmIDoingPage(),
        'cognitive-options-page/ai-check-in': (context) => AICheckInPage(),
        'cognitive-options-page/digital-storybook': (context) => DigitalStorybookPage(),
        'cognitive-options-page/locked-down-mode': (context) => LockedDownModePage(),

        '/safety-and-communication-options-page': (context) => SafetyAndSupportRoutes(),
        'safety-and-communication-options-page/ai-video-call-suggestions': (context) => AIVideoCallSuggestionsPage(),
        'safety-and-communication-options-page/auto-emergency-calling': (context) => AutoEmergencyCallingPage(),
        'safety-and-communication-options-page/caregiver-portal': (context) => CaregiverPortalPage(),

        '/therapy-and-recreation-options-page' : (context) => TherapyAndRecreationRoutes(),
        'therapy-and-recreation-options-page/cognitive-puzzle-coach': (context) => NumberSequencePuzzle(),
        'therapy-and-recreation-options-page/guided-drawing-app' : (context) => SimpleDrawingTool(),
        'therapy-and-recreation-options-page/relaxation-breathing-coach' : (context) => BreathingExercisePage(),
        'therapy-and-recreation-options-page/smart-garden-app' : (context) => SmartGardenAppPage(),
        'therapy-and-recreation-options-page/virtual-pet-companion': (BuildContext context) => VirtualPetCompanionPage(),

        '/accessibility-and-medical': (context) => AccessibilityAndMedicalRoutes(),
        'accessibility-and-medical/ai-symptom-reporter': (context) => AISymptomReporterPage(),
        'accessibility-and-medical/hearing-aid-companion': (context) => HearingAidCompanionPage(),
        'accessibility-and-medical/live-translation-assistant': (context) => LiveTranslationScreen(),
        'accessibility-and-medical/speech-to-text-notes': (context) => SpeechToTextNotesPage(),
        'accessibility-and-medical/vitals-tracker': (context) => VitalsTrackerPage(),

        '/hardware-addons-options-page' : (context) => HardwareAddonsRoutes(),
        'hardware-addons-options-page/mount-stand-addon': (context) => MountStandAddOnPage(),
        'hardware-addons-options-page/popsocket_attachment': (context) => PopsocketAttachmentPage(),
        'hardware-addons-options-page/wrist-lanyard': (context) => WristLanyardPage(),

        '/test': (context) => test()
      },
    );
  }
}