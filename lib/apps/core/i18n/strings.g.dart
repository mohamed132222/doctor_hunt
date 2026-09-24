/// Generated file. Do not edit.
///
/// Original: lib/apps/core/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 310 (155 per locale)
///
/// Built on 2026-09-19 at 17:31 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
  en(languageCode: 'en', build: Translations.build),
  ar(languageCode: 'ar', build: _StringsAr.build);

  const AppLocale({
    required this.languageCode,
    this.scriptCode,
    this.countryCode,
    required this.build,
  }); // ignore: unused_element

  @override
  final String languageCode;
  @override
  final String? scriptCode;
  @override
  final String? countryCode;
  @override
  final TranslationBuilder<AppLocale, Translations> build;

  /// Gets current instance managed by [LocaleSettings].
  Translations get translations =>
      LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider
    extends BaseTranslationProvider<AppLocale, Translations> {
  TranslationProvider({required super.child})
    : super(settings: LocaleSettings.instance);

  static InheritedLocaleData<AppLocale, Translations> of(
    BuildContext context,
  ) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
  Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings
    extends BaseFlutterLocaleSettings<AppLocale, Translations> {
  LocaleSettings._() : super(utils: AppLocaleUtils.instance);

  static final instance = LocaleSettings._();

  // static aliases (checkout base methods for documentation)
  static AppLocale get currentLocale => instance.currentLocale;
  static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
  static AppLocale setLocale(
    AppLocale locale, {
    bool? listenToDeviceLocale = false,
  }) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale setLocaleRaw(
    String rawLocale, {
    bool? listenToDeviceLocale = false,
  }) => instance.setLocaleRaw(
    rawLocale,
    listenToDeviceLocale: listenToDeviceLocale,
  );
  static AppLocale useDeviceLocale() => instance.useDeviceLocale();
  @Deprecated('Use [AppLocaleUtils.supportedLocales]')
  static List<Locale> get supportedLocales => instance.supportedLocales;
  @Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]')
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
  static void setPluralResolver({
    String? language,
    AppLocale? locale,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) => instance.setPluralResolver(
    language: language,
    locale: locale,
    cardinalResolver: cardinalResolver,
    ordinalResolver: ordinalResolver,
  );
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
  AppLocaleUtils._()
    : super(baseLocale: _baseLocale, locales: AppLocale.values);

  static final instance = AppLocaleUtils._();

  // static aliases (checkout base methods for documentation)
  static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
  static AppLocale parseLocaleParts({
    required String languageCode,
    String? scriptCode,
    String? countryCode,
  }) => instance.parseLocaleParts(
    languageCode: languageCode,
    scriptCode: scriptCode,
    countryCode: countryCode,
  );
  static AppLocale findDeviceLocale() => instance.findDeviceLocale();
  static List<Locale> get supportedLocales => instance.supportedLocales;
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations.build({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta = TranslationMetadata(
         locale: AppLocale.en,
         overrides: overrides ?? {},
         cardinalResolver: cardinalResolver,
         ordinalResolver: ordinalResolver,
       ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  // Translations
  String get addPatient => 'Add';
  String get afternoonPeriod => 'Afternoon';
  String get appName => 'Doctor Hunt';
  String get appointmentConfirmed => 'Appointment confirmed';
  String get appointmentForTitle => 'Appointment For';
  String get appointmentSuccessful => 'Your Appointment Successful';
  String get appointmentTitle => 'Appointment';
  String get authSubtitle =>
      'You can search course, apply course and find scholarship for abroad studies';
  String get availableTimeTitle => 'Available Time';
  String get bookNow => 'Book Now';
  String get bookingRequested => 'Appointment requested';
  String get bookingUnavailable => 'Booking is not available yet.';
  String get categoryCardiologist => 'Cardiologist';
  String get categoryDentist => 'Dentist';
  String get categoryGastroenterologist => 'Gastroenterologist';
  String get categoryOphthalmologist => 'Ophthalmologist';
  String get childGirl => 'Child Girl';
  String get chooseRoleSubtitle =>
      'The selected role determines the experience and available features.';
  String get chooseRoleTitle => 'Choose your role';
  String get clinicFallback => 'Kenyatta National Hospital';
  String get confirmButton => 'Confirm';
  String get contactClinic => 'Contact Clinic';
  String get contactNumberHint => 'Contact Number';
  String get continueLabel => 'Continue';

  String distanceAway({required Object distance}) => '${distance} away';
  String get doctorAddison => 'Dr. Addison Smith';
  String get doctorBalestra => 'Dr. Balestra';
  String get doctorBennett => 'Dr. Bennett Mccoy';
  String get doctorCrick => 'Dr. Crick';
  String get doctorCrownover => 'Dr. Crownover';
  String get doctorDetailsTitle => 'Doctor Details';
  String get doctorFillerup => 'Dr. Fillerup Grab';
  String get doctorLachinet => 'Dr. Lachinet';
  String get doctorNotFound => 'Doctor not found';
  String get doctorShruti => 'Dr. Shruti Kedia';
  String get doctorStrain => 'Dr. Strain';
  String get doctorWatamaniuk => 'Dr. Watamaniuk';
  String get doneButton => 'Done';
  String get editAppointment => 'Edit your appointment';
  String get emailHint => 'Email';
  String get emailInvalid => 'Enter a valid email';
  String get emailRequired => 'Enter your email';
  String get eveningPeriod => 'Evening';
  String get experienceSuffix => 'Years experience';

  String experienceYears({required Object years}) =>
      '${years} Years experience';
  String get featureDoctorsTitle => 'Feature Doctor';

  String fieldRequired({required Object label}) => 'Enter ${label}';
  String get findDoctorsTitle => 'Find Doctors';
  String get forgotPassword => 'Forgot password';
  String get forgotPasswordSubtitle =>
      'Enter your email for the verification process, we will send 4 digits code to your email.';
  String get forgotPasswordTitle => 'Forgot password';
  String get getStarted => 'Get Started';
  String get homeGreeting => 'Hi Handwerker!';
  String get homeTitle => 'Find Your Doctor';
  String get loginButton => 'Login';
  String get loginSwitchAction => 'Join us';

  String get loginSwitchPrefix => 'Don\'t have an account? ';
  String get loginTitle => 'Welcome back';
  String get mapAreaHospital => 'Nairobi Hospital';
  String get mapAreaKariokor => 'KARIOKOR';
  String get mapAreaKilimani => 'KILIMANI';
  String get mapAreaNairobi => 'Nairobi';
  String get mapAreaPangani => 'PANGANI';
  String get mapAreaParklands => 'Parklands';
  String get mapAreaUpperHill => 'UPPER HILL';
  String get mapAreaWestlands => 'WESTLANDS';
  String get mapAttribution => 'OpenStreetMap contributors';
  String get mapClinic => 'KENYATTA HOSPITAL';
  String get myChild => 'My child';
  String get mySelf => 'My Self';
  String get nameFieldLabel => 'your name';
  String get nameHint => 'Name';
  String get nameInvalid => 'Letters only, please';
  String get nameTooShort => 'Enter at least 3 characters';
  String get newPasswordHint => 'New Password';
  String get next => 'Next';

  String nextAvailabilityOn({required Object day}) =>
      'Next availability on ${day}';
  String get nextAvailableLabel => 'Next Available';
  String get nextMonth => 'Next month';
  String get noSearchResults => 'No doctors found';
  String get noSearchResultsHint => 'Try a different name or specialty.';
  String get noSlotsAvailable => 'No slots available';
  String get onboardingSubtitle =>
      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.';
  String get onboardingTitle1 => 'Find Trusted Doctors';
  String get onboardingTitle2 => 'Choose Best Doctors';
  String get onboardingTitle3 => 'Easy Appointments';
  String get orLabel => 'OR';

  String otpRequired({required Object length}) =>
      'Enter the ${length}-digit code';
  String get passwordHint => 'Password';

  String passwordMinLength({required Object minLength}) =>
      'Password must be at least ${minLength} characters';
  String get passwordRequired => 'Enter your password';
  String get passwordsDoNotMatch => 'Passwords do not match';
  String get patientNameHint => 'Patient Name';

  String patientStories({required Object count}) => '${count} Patient Stories';
  String get perHourShort => '/hr';
  String get perHourSuffix => '/ hours';

  String periodSlots({required Object period, required Object count}) =>
      '${period} ${count} slots';
  String get phoneInvalid => 'Enter a valid phone number';
  String get popularDoctorsTitle => 'Popular Doctor';
  String get previousMonth => 'Previous month';
  String get reenterPasswordHint => 'Re-enter Password';
  String get reenterPasswordRequired => 'Re-enter your password';
  String get registerButton => 'Sign up';
  String get registerSwitchAction => 'Log in';
  String get registerSwitchPrefix => 'Have an account? ';
  String get registerTitle => 'Join us to start searching';

  String reminderMinutes({required Object minutes}) => '${minutes} min';
  String get reminderTitle => 'Reminder Me Before';
  String get resetPasswordSubtitle =>
      'Set the new password for your account so you can login and access all the features.';
  String get resetPasswordTitle => 'Reset Password';
  String get roleAdmin => 'Admin';
  String get roleAdminDescription =>
      'Manage doctors, appointments, users, and the platform.';
  String get rolePatient => 'Patient';
  String get rolePatientDescription =>
      'Find doctors, book appointments, and manage your medical records.';

  String satisfactionPercent({required Object percent}) => '${percent}%';
  String get searchDoctors => 'Search doctors';
  String get searchHint => 'Search.....';
  String get searchHintFull => 'Search doctors, specialties…';
  String get seeAll => 'See all';
  String get selectTimeTitle => 'Select Time';
  String get servicePoint1 => 'Patient care should be the number one priority.';
  String get servicePoint2 =>
      'If you run your practice you know how frustrating it can be when a patient misses an appointment.';

  String get servicePoint3 =>
      'That\'s why an appointment reminder system matters.';
  String get servicesTitle => 'Services';
  String get skip => 'Skip';

  String slotsAvailable({required Object count}) => '${count} slots available';
  String get socialFacebook => 'Facebook';
  String get socialGoogle => 'Google';
  String get specialistFallback => 'Medicine Specialist';
  String get specialtyDentist => 'Teeth Dentist';
  String get statOngoing => 'Ongoing';
  String get statOngoingValue => '500';
  String get statPatient => 'Patient';
  String get statPatientValue => '700';
  String get statRunning => 'Running';
  String get statRunningValue => '100';
  String get tabAppointments => 'Appointments';
  String get tabBook => 'Book';
  String get tabChat => 'Chat';
  String get tabFavorites => 'Favorites';
  String get tabHome => 'Home';
  String get tabMap => 'Map';

  String tabPlaceholder({required Object title}) => '${title} screen';
  String get tabProfile => 'Profile';
  String get termsAction => 'Terms of Service & Privacy Policy';
  String get termsPrefix => 'I agree with the ';
  String get termsRequired => 'Please accept the terms to continue';
  String get thankYou => 'Thank You !';
  String get todayLabel => 'Today';
  String get todayLabelShort => 'Today';
  String get tomorrowLabel => 'Tomorrow';
  String get updatePasswordButton => 'Update Password';
  String get verifyCodeSubtitle =>
      'Enter the 6 digits code that you received on your email.';
  String get verifyCodeTitle => 'Enter 6 Digits Code';
  String get resendCodeQuestion => 'Didn\'t receive the code?';
  String get resendCodeButton => 'Resend code';
  String resendCodeCountdown({required Object seconds}) =>
      'Resend code in ${seconds}s';
  String get whoIsPatientTitle => 'Who is this patient?';
}

// Path: <root>
class _StringsAr extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  _StringsAr.build({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta = TranslationMetadata(
         locale: AppLocale.ar,
         overrides: overrides ?? {},
         cardinalResolver: cardinalResolver,
         ordinalResolver: ordinalResolver,
       ),
       super.build(
         cardinalResolver: cardinalResolver,
         ordinalResolver: ordinalResolver,
       ) {
    super.$meta.setFlatMapFunction(
      $meta.getTranslation,
    ); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <ar>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  @override
  late final _StringsAr _root = this; // ignore: unused_field

  // Translations
  @override
  String get addPatient => 'إضافة';
  @override
  String get afternoonPeriod => 'بعد الظهر';
  @override
  String get appName => 'دكتور هانت';
  @override
  String get appointmentConfirmed => 'تم تأكيد الموعد';
  @override
  String get appointmentForTitle => 'الموعد لـ';
  @override
  String get appointmentSuccessful => 'تم حجز موعدك بنجاح';
  @override
  String get appointmentTitle => 'الموعد';
  @override
  String get authSubtitle =>
      'يمكنك البحث عن دورات، والتقديم عليها، وإيجاد منح دراسية بالخارج';
  @override
  String get availableTimeTitle => 'الأوقات المتاحة';
  @override
  String get bookNow => 'احجز الآن';
  @override
  String get bookingRequested => 'تم طلب الموعد';
  @override
  String get bookingUnavailable => 'الحجز غير متاح بعد.';
  @override
  String get categoryCardiologist => 'قلب';
  @override
  String get categoryDentist => 'طب أسنان';
  @override
  String get categoryGastroenterologist => 'جهاز هضمي';
  @override
  String get categoryOphthalmologist => 'عيون';
  @override
  String get childGirl => 'بنتي';
  @override
  String get chooseRoleSubtitle =>
      'الدور المختار يحدد التجربة والمزايا المتاحة لك.';
  @override
  String get chooseRoleTitle => 'اختر دورك';
  @override
  String get clinicFallback => 'مستشفى كينياتا الوطني';
  @override
  String get confirmButton => 'تأكيد';
  @override
  String get contactClinic => 'تواصل مع العيادة';
  @override
  String get contactNumberHint => 'رقم التواصل';
  @override
  String get continueLabel => 'متابعة';
  @override
  String distanceAway({required Object distance}) => 'يبعد ${distance}';
  @override
  String get doctorAddison => 'Dr. Addison Smith';
  @override
  String get doctorBalestra => 'Dr. Balestra';
  @override
  String get doctorBennett => 'Dr. Bennett Mccoy';
  @override
  String get doctorCrick => 'Dr. Crick';
  @override
  String get doctorCrownover => 'Dr. Crownover';
  @override
  String get doctorDetailsTitle => 'بيانات الطبيب';
  @override
  String get doctorFillerup => 'Dr. Fillerup Grab';
  @override
  String get doctorLachinet => 'Dr. Lachinet';
  @override
  String get doctorNotFound => 'لم يتم العثور على الطبيب';
  @override
  String get doctorShruti => 'Dr. Shruti Kedia';
  @override
  String get doctorStrain => 'Dr. Strain';
  @override
  String get doctorWatamaniuk => 'Dr. Watamaniuk';
  @override
  String get doneButton => 'تم';
  @override
  String get editAppointment => 'تعديل موعدك';
  @override
  String get emailHint => 'البريد الإلكتروني';
  @override
  String get emailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';
  @override
  String get emailRequired => 'أدخل بريدك الإلكتروني';
  @override
  String get eveningPeriod => 'المساء';
  @override
  String get experienceSuffix => 'سنوات خبرة';
  @override
  String experienceYears({required Object years}) => '${years} سنوات خبرة';
  @override
  String get featureDoctorsTitle => 'أطباء مميزون';
  @override
  String fieldRequired({required Object label}) => 'أدخل ${label}';
  @override
  String get findDoctorsTitle => 'ابحث عن الأطباء';
  @override
  String get forgotPassword => 'نسيت كلمة المرور';
  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني لإتمام عملية التحقق، وسنرسل رمزًا مكوّنًا من ٤ أرقام إلى بريدك.';
  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';
  @override
  String get getStarted => 'ابدأ الآن';
  @override
  String get homeGreeting => 'مرحبًا هاندفيركر!';
  @override
  String get homeTitle => 'ابحث عن طبيبك';
  @override
  String get loginButton => 'تسجيل الدخول';
  @override
  String get loginSwitchAction => 'انضم إلينا';

  @override
  String get loginSwitchPrefix => 'ليس لديك حساب؟ ';
  @override
  String get loginTitle => 'مرحبًا بعودتك';
  @override
  String get mapAreaHospital => 'مستشفى نيروبي';
  @override
  String get mapAreaKariokor => 'كاريوكور';
  @override
  String get mapAreaKilimani => 'كيليماني';
  @override
  String get mapAreaNairobi => 'نيروبي';
  @override
  String get mapAreaPangani => 'بانجاني';
  @override
  String get mapAreaParklands => 'باركلاندز';
  @override
  String get mapAreaUpperHill => 'أبر هيل';
  @override
  String get mapAreaWestlands => 'ويستلاندز';
  @override
  String get mapAttribution => 'مساهمو OpenStreetMap';
  @override
  String get mapClinic => 'مستشفى كينياتا';
  @override
  String get myChild => 'طفلي';
  @override
  String get mySelf => 'أنا';
  @override
  String get nameFieldLabel => 'اسمك';
  @override
  String get nameHint => 'الاسم';
  @override
  String get nameInvalid => 'حروف فقط، من فضلك';
  @override
  String get nameTooShort => 'أدخل ٣ أحرف على الأقل';
  @override
  String get newPasswordHint => 'كلمة المرور الجديدة';
  @override
  String get next => 'التالي';
  @override
  String nextAvailabilityOn({required Object day}) => 'أقرب موعد متاح ${day}';
  @override
  String get nextAvailableLabel => 'أقرب موعد متاح';
  @override
  String get nextMonth => 'الشهر التالي';
  @override
  String get noSearchResults => 'لا يوجد أطباء';
  @override
  String get noSearchResultsHint => 'جرّب اسمًا أو تخصصًا آخر.';
  @override
  String get noSlotsAvailable => 'لا توجد مواعيد متاحة';
  @override
  String get onboardingSubtitle =>
      'على خلاف الاعتقاد السائد، ليس لوريم إيبسوم نصٌ عشوائي فحسب. بل جذوره تعود إلى نصٍّ عمره أكثر من ٢٠٠٠ عام.';
  @override
  String get onboardingTitle1 => 'ابحث عن أطباء موثوقين';
  @override
  String get onboardingTitle2 => 'اختر أفضل الأطباء';
  @override
  String get onboardingTitle3 => 'مواعيد بسهولة';
  @override
  String get orLabel => 'أو';
  @override
  String otpRequired({required Object length}) =>
      'أدخل الرمز المكوّن من ${length} أرقام';
  @override
  String get passwordHint => 'كلمة المرور';
  @override
  String passwordMinLength({required Object minLength}) =>
      'كلمة المرور يجب ألا تقل عن ${minLength} أحرف';
  @override
  String get passwordRequired => 'أدخل كلمة المرور';
  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';
  @override
  String get patientNameHint => 'اسم المريض';
  @override
  String patientStories({required Object count}) => '${count} قصة مريض';
  @override
  String get perHourShort => '/ساعة';
  @override
  String get perHourSuffix => '/ الساعة';
  @override
  String periodSlots({required Object period, required Object count}) =>
      '${period} ${count} موعد';
  @override
  String get phoneInvalid => 'أدخل رقم هاتف صحيح';
  @override
  String get popularDoctorsTitle => 'أطباء مشهورون';
  @override
  String get previousMonth => 'الشهر السابق';
  @override
  String get reenterPasswordHint => 'أعد إدخال كلمة المرور';
  @override
  String get reenterPasswordRequired => 'أعد إدخال كلمة المرور';
  @override
  String get registerButton => 'إنشاء حساب';
  @override
  String get registerSwitchAction => 'تسجيل الدخول';
  @override
  String get registerSwitchPrefix => 'لديك حساب بالفعل؟ ';
  @override
  String get registerTitle => 'انضم إلينا لتبدأ البحث';
  @override
  String reminderMinutes({required Object minutes}) => '${minutes} دقيقة';
  @override
  String get reminderTitle => 'ذكّرني قبل';
  @override
  String get resetPasswordSubtitle =>
      'عيّن كلمة مرور جديدة لحسابك لتتمكن من الدخول والاستفادة من كل المزايا.';
  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';
  @override
  String get roleAdmin => 'مسؤول';
  @override
  String get roleAdminDescription =>
      'أدر الأطباء والمواعيد والمستخدمين والمنصة.';
  @override
  String get rolePatient => 'مريض';
  @override
  String get rolePatientDescription =>
      'ابحث عن الأطباء، واحجز المواعيد، وأدر سجلاتك الطبية.';
  @override
  String satisfactionPercent({required Object percent}) => '${percent}٪';
  @override
  String get searchDoctors => 'ابحث عن أطباء';
  @override
  String get searchHint => 'ابحث.....';
  @override
  String get searchHintFull => 'ابحث عن أطباء أو تخصصات…';
  @override
  String get seeAll => 'عرض الكل';
  @override
  String get selectTimeTitle => 'اختر الوقت';
  @override
  String get servicePoint1 => 'رعاية المريض يجب أن تكون الأولوية القصوى.';
  @override
  String get servicePoint2 =>
      'إذا كنت تدير عيادة، فأنت تعرف مدى الإحباط عندما يفوّت المريض موعده.';

  @override
  String get servicePoint3 => 'لهذا يهمّ نظام تذكير المواعيد.';
  @override
  String get servicesTitle => 'الخدمات';
  @override
  String get skip => 'تخطٍ';
  @override
  String slotsAvailable({required Object count}) => '${count} موعد متاح';
  @override
  String get socialFacebook => 'فيسبوك';
  @override
  String get socialGoogle => 'جوجل';
  @override
  String get specialistFallback => 'أخصائي باطنة';
  @override
  String get specialtyDentist => 'طبيب أسنان';
  @override
  String get statOngoing => 'جارية';
  @override
  String get statOngoingValue => '٥٠٠';
  @override
  String get statPatient => 'مريض';
  @override
  String get statPatientValue => '٧٠٠';
  @override
  String get statRunning => 'قيد التشغيل';
  @override
  String get statRunningValue => '١٠٠';
  @override
  String get tabAppointments => 'المواعيد';
  @override
  String get tabBook => 'الحجز';
  @override
  String get tabChat => 'المحادثات';
  @override
  String get tabFavorites => 'المفضلة';
  @override
  String get tabHome => 'الرئيسية';
  @override
  String get tabMap => 'الخريطة';
  @override
  String tabPlaceholder({required Object title}) => 'شاشة ${title}';
  @override
  String get tabProfile => 'الملف الشخصي';
  @override
  String get termsAction => 'شروط الخدمة وسياسة الخصوصية';
  @override
  String get termsPrefix => 'أوافق على ';
  @override
  String get termsRequired => 'يرجى قبول الشروط للمتابعة';
  @override
  String get thankYou => 'شكرًا لك !';
  @override
  String get todayLabel => 'اليوم';
  @override
  String get todayLabelShort => 'اليوم';
  @override
  String get tomorrowLabel => 'غدًا';
  @override
  String get updatePasswordButton => 'تحديث كلمة المرور';
  @override
  String get verifyCodeSubtitle =>
      'أدخل الرمز المكوّن من ٦ أرقام الذي وصلك على بريدك الإلكتروني.';
  @override
  String get verifyCodeTitle => 'أدخل الرمز المكوّن من ٦ أرقام';
  @override
  String get resendCodeQuestion => 'لم يصلك الرمز؟';
  @override
  String get resendCodeButton => 'إعادة إرسال الرمز';
  @override
  String resendCodeCountdown({required Object seconds}) =>
      'إعادة الإرسال خلال ${seconds} ثانية';
  @override
  String get whoIsPatientTitle => 'من هو المريض؟';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'addPatient':
        return 'Add';
      case 'afternoonPeriod':
        return 'Afternoon';
      case 'appName':
        return 'Doctor Hunt';
      case 'appointmentConfirmed':
        return 'Appointment confirmed';
      case 'appointmentForTitle':
        return 'Appointment For';
      case 'appointmentSuccessful':
        return 'Your Appointment Successful';
      case 'appointmentTitle':
        return 'Appointment';
      case 'authSubtitle':
        return 'You can search course, apply course and find scholarship for abroad studies';
      case 'availableTimeTitle':
        return 'Available Time';
      case 'bookNow':
        return 'Book Now';
      case 'bookingRequested':
        return 'Appointment requested';
      case 'bookingUnavailable':
        return 'Booking is not available yet.';
      case 'categoryCardiologist':
        return 'Cardiologist';
      case 'categoryDentist':
        return 'Dentist';
      case 'categoryGastroenterologist':
        return 'Gastroenterologist';
      case 'categoryOphthalmologist':
        return 'Ophthalmologist';
      case 'childGirl':
        return 'Child Girl';
      case 'chooseRoleSubtitle':
        return 'The selected role determines the experience and available features.';
      case 'chooseRoleTitle':
        return 'Choose your role';
      case 'clinicFallback':
        return 'Kenyatta National Hospital';
      case 'confirmButton':
        return 'Confirm';
      case 'contactClinic':
        return 'Contact Clinic';
      case 'contactNumberHint':
        return 'Contact Number';
      case 'continueLabel':
        return 'Continue';
      case 'distanceAway':
        return ({required Object distance}) => '${distance} away';
      case 'doctorAddison':
        return 'Dr. Addison Smith';
      case 'doctorBalestra':
        return 'Dr. Balestra';
      case 'doctorBennett':
        return 'Dr. Bennett Mccoy';
      case 'doctorCrick':
        return 'Dr. Crick';
      case 'doctorCrownover':
        return 'Dr. Crownover';
      case 'doctorDetailsTitle':
        return 'Doctor Details';
      case 'doctorFillerup':
        return 'Dr. Fillerup Grab';
      case 'doctorLachinet':
        return 'Dr. Lachinet';
      case 'doctorNotFound':
        return 'Doctor not found';
      case 'doctorShruti':
        return 'Dr. Shruti Kedia';
      case 'doctorStrain':
        return 'Dr. Strain';
      case 'doctorWatamaniuk':
        return 'Dr. Watamaniuk';
      case 'doneButton':
        return 'Done';
      case 'editAppointment':
        return 'Edit your appointment';
      case 'emailHint':
        return 'Email';
      case 'emailInvalid':
        return 'Enter a valid email';
      case 'emailRequired':
        return 'Enter your email';
      case 'eveningPeriod':
        return 'Evening';
      case 'experienceSuffix':
        return 'Years experience';
      case 'experienceYears':
        return ({required Object years}) => '${years} Years experience';
      case 'featureDoctorsTitle':
        return 'Feature Doctor';
      case 'fieldRequired':
        return ({required Object label}) => 'Enter ${label}';
      case 'findDoctorsTitle':
        return 'Find Doctors';
      case 'forgotPassword':
        return 'Forgot password';
      case 'forgotPasswordSubtitle':
        return 'Enter your email for the verification process, we will send 4 digits code to your email.';
      case 'forgotPasswordTitle':
        return 'Forgot password';
      case 'getStarted':
        return 'Get Started';
      case 'homeGreeting':
        return 'Hi Handwerker!';
      case 'homeTitle':
        return 'Find Your Doctor';
      case 'loginButton':
        return 'Login';
      case 'loginSwitchAction':
        return 'Join us';
      case 'loginSwitchPrefix':
        return 'Don\'t have an account? ';
      case 'loginTitle':
        return 'Welcome back';
      case 'mapAreaHospital':
        return 'Nairobi Hospital';
      case 'mapAreaKariokor':
        return 'KARIOKOR';
      case 'mapAreaKilimani':
        return 'KILIMANI';
      case 'mapAreaNairobi':
        return 'Nairobi';
      case 'mapAreaPangani':
        return 'PANGANI';
      case 'mapAreaParklands':
        return 'Parklands';
      case 'mapAreaUpperHill':
        return 'UPPER HILL';
      case 'mapAreaWestlands':
        return 'WESTLANDS';
      case 'mapAttribution':
        return 'OpenStreetMap contributors';
      case 'mapClinic':
        return 'KENYATTA HOSPITAL';
      case 'myChild':
        return 'My child';
      case 'mySelf':
        return 'My Self';
      case 'nameFieldLabel':
        return 'your name';
      case 'nameHint':
        return 'Name';
      case 'nameInvalid':
        return 'Letters only, please';
      case 'nameTooShort':
        return 'Enter at least 3 characters';
      case 'newPasswordHint':
        return 'New Password';
      case 'next':
        return 'Next';
      case 'nextAvailabilityOn':
        return ({required Object day}) => 'Next availability on ${day}';
      case 'nextAvailableLabel':
        return 'Next Available';
      case 'nextMonth':
        return 'Next month';
      case 'noSearchResults':
        return 'No doctors found';
      case 'noSearchResultsHint':
        return 'Try a different name or specialty.';
      case 'noSlotsAvailable':
        return 'No slots available';
      case 'onboardingSubtitle':
        return 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of it over 2000 years old.';
      case 'onboardingTitle1':
        return 'Find Trusted Doctors';
      case 'onboardingTitle2':
        return 'Choose Best Doctors';
      case 'onboardingTitle3':
        return 'Easy Appointments';
      case 'orLabel':
        return 'OR';
      case 'otpRequired':
        return ({required Object length}) => 'Enter the ${length}-digit code';
      case 'passwordHint':
        return 'Password';
      case 'passwordMinLength':
        return ({required Object minLength}) =>
            'Password must be at least ${minLength} characters';
      case 'passwordRequired':
        return 'Enter your password';
      case 'passwordsDoNotMatch':
        return 'Passwords do not match';
      case 'patientNameHint':
        return 'Patient Name';
      case 'patientStories':
        return ({required Object count}) => '${count} Patient Stories';
      case 'perHourShort':
        return '/hr';
      case 'perHourSuffix':
        return '/ hours';
      case 'periodSlots':
        return ({required Object period, required Object count}) =>
            '${period} ${count} slots';
      case 'phoneInvalid':
        return 'Enter a valid phone number';
      case 'popularDoctorsTitle':
        return 'Popular Doctor';
      case 'previousMonth':
        return 'Previous month';
      case 'reenterPasswordHint':
        return 'Re-enter Password';
      case 'reenterPasswordRequired':
        return 'Re-enter your password';
      case 'registerButton':
        return 'Sign up';
      case 'registerSwitchAction':
        return 'Log in';
      case 'registerSwitchPrefix':
        return 'Have an account? ';
      case 'registerTitle':
        return 'Join us to start searching';
      case 'reminderMinutes':
        return ({required Object minutes}) => '${minutes} min';
      case 'reminderTitle':
        return 'Reminder Me Before';
      case 'resetPasswordSubtitle':
        return 'Set the new password for your account so you can login and access all the features.';
      case 'resetPasswordTitle':
        return 'Reset Password';
      case 'roleAdmin':
        return 'Admin';
      case 'roleAdminDescription':
        return 'Manage doctors, appointments, users, and the platform.';
      case 'rolePatient':
        return 'Patient';
      case 'rolePatientDescription':
        return 'Find doctors, book appointments, and manage your medical records.';
      case 'satisfactionPercent':
        return ({required Object percent}) => '${percent}%';
      case 'searchDoctors':
        return 'Search doctors';
      case 'searchHint':
        return 'Search.....';
      case 'searchHintFull':
        return 'Search doctors, specialties…';
      case 'seeAll':
        return 'See all';
      case 'selectTimeTitle':
        return 'Select Time';
      case 'servicePoint1':
        return 'Patient care should be the number one priority.';
      case 'servicePoint2':
        return 'If you run your practice you know how frustrating it can be when a patient misses an appointment.';
      case 'servicePoint3':
        return 'That\'s why an appointment reminder system matters.';
      case 'servicesTitle':
        return 'Services';
      case 'skip':
        return 'Skip';
      case 'slotsAvailable':
        return ({required Object count}) => '${count} slots available';
      case 'socialFacebook':
        return 'Facebook';
      case 'socialGoogle':
        return 'Google';
      case 'specialistFallback':
        return 'Medicine Specialist';
      case 'specialtyDentist':
        return 'Teeth Dentist';
      case 'statOngoing':
        return 'Ongoing';
      case 'statOngoingValue':
        return '500';
      case 'statPatient':
        return 'Patient';
      case 'statPatientValue':
        return '700';
      case 'statRunning':
        return 'Running';
      case 'statRunningValue':
        return '100';
      case 'tabAppointments':
        return 'Appointments';
      case 'tabBook':
        return 'Book';
      case 'tabChat':
        return 'Chat';
      case 'tabFavorites':
        return 'Favorites';
      case 'tabHome':
        return 'Home';
      case 'tabMap':
        return 'Map';
      case 'tabPlaceholder':
        return ({required Object title}) => '${title} screen';
      case 'tabProfile':
        return 'Profile';
      case 'termsAction':
        return 'Terms of Service & Privacy Policy';
      case 'termsPrefix':
        return 'I agree with the ';
      case 'termsRequired':
        return 'Please accept the terms to continue';
      case 'thankYou':
        return 'Thank You !';
      case 'todayLabel':
        return 'Today';
      case 'todayLabelShort':
        return 'Today';
      case 'tomorrowLabel':
        return 'Tomorrow';
      case 'updatePasswordButton':
        return 'Update Password';
      case 'verifyCodeSubtitle':
        return 'Enter the 4 digits code that you received on your email.';
      case 'verifyCodeTitle':
        return 'Enter 4 Digits Code';
      case 'whoIsPatientTitle':
        return 'Who is this patient?';
      default:
        return null;
    }
  }
}

extension on _StringsAr {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'addPatient':
        return 'إضافة';
      case 'afternoonPeriod':
        return 'بعد الظهر';
      case 'appName':
        return 'دكتور هانت';
      case 'appointmentConfirmed':
        return 'تم تأكيد الموعد';
      case 'appointmentForTitle':
        return 'الموعد لـ';
      case 'appointmentSuccessful':
        return 'تم حجز موعدك بنجاح';
      case 'appointmentTitle':
        return 'الموعد';
      case 'authSubtitle':
        return 'يمكنك البحث عن دورات، والتقديم عليها، وإيجاد منح دراسية بالخارج';
      case 'availableTimeTitle':
        return 'الأوقات المتاحة';
      case 'bookNow':
        return 'احجز الآن';
      case 'bookingRequested':
        return 'تم طلب الموعد';
      case 'bookingUnavailable':
        return 'الحجز غير متاح بعد.';
      case 'categoryCardiologist':
        return 'قلب';
      case 'categoryDentist':
        return 'طب أسنان';
      case 'categoryGastroenterologist':
        return 'جهاز هضمي';
      case 'categoryOphthalmologist':
        return 'عيون';
      case 'childGirl':
        return 'بنتي';
      case 'chooseRoleSubtitle':
        return 'الدور المختار يحدد التجربة والمزايا المتاحة لك.';
      case 'chooseRoleTitle':
        return 'اختر دورك';
      case 'clinicFallback':
        return 'مستشفى كينياتا الوطني';
      case 'confirmButton':
        return 'تأكيد';
      case 'contactClinic':
        return 'تواصل مع العيادة';
      case 'contactNumberHint':
        return 'رقم التواصل';
      case 'continueLabel':
        return 'متابعة';
      case 'distanceAway':
        return ({required Object distance}) => 'يبعد ${distance}';
      case 'doctorAddison':
        return 'Dr. Addison Smith';
      case 'doctorBalestra':
        return 'Dr. Balestra';
      case 'doctorBennett':
        return 'Dr. Bennett Mccoy';
      case 'doctorCrick':
        return 'Dr. Crick';
      case 'doctorCrownover':
        return 'Dr. Crownover';
      case 'doctorDetailsTitle':
        return 'بيانات الطبيب';
      case 'doctorFillerup':
        return 'Dr. Fillerup Grab';
      case 'doctorLachinet':
        return 'Dr. Lachinet';
      case 'doctorNotFound':
        return 'لم يتم العثور على الطبيب';
      case 'doctorShruti':
        return 'Dr. Shruti Kedia';
      case 'doctorStrain':
        return 'Dr. Strain';
      case 'doctorWatamaniuk':
        return 'Dr. Watamaniuk';
      case 'doneButton':
        return 'تم';
      case 'editAppointment':
        return 'تعديل موعدك';
      case 'emailHint':
        return 'البريد الإلكتروني';
      case 'emailInvalid':
        return 'أدخل بريدًا إلكترونيًا صحيحًا';
      case 'emailRequired':
        return 'أدخل بريدك الإلكتروني';
      case 'eveningPeriod':
        return 'المساء';
      case 'experienceSuffix':
        return 'سنوات خبرة';
      case 'experienceYears':
        return ({required Object years}) => '${years} سنوات خبرة';
      case 'featureDoctorsTitle':
        return 'أطباء مميزون';
      case 'fieldRequired':
        return ({required Object label}) => 'أدخل ${label}';
      case 'findDoctorsTitle':
        return 'ابحث عن الأطباء';
      case 'forgotPassword':
        return 'نسيت كلمة المرور';
      case 'forgotPasswordSubtitle':
        return 'أدخل بريدك الإلكتروني لإتمام عملية التحقق، وسنرسل رمزًا مكوّنًا من ٤ أرقام إلى بريدك.';
      case 'forgotPasswordTitle':
        return 'نسيت كلمة المرور';
      case 'getStarted':
        return 'ابدأ الآن';
      case 'homeGreeting':
        return 'مرحبًا هاندفيركر!';
      case 'homeTitle':
        return 'ابحث عن طبيبك';
      case 'loginButton':
        return 'تسجيل الدخول';
      case 'loginSwitchAction':
        return 'انضم إلينا';
      case 'loginSwitchPrefix':
        return 'ليس لديك حساب؟ ';
      case 'loginTitle':
        return 'مرحبًا بعودتك';
      case 'mapAreaHospital':
        return 'مستشفى نيروبي';
      case 'mapAreaKariokor':
        return 'كاريوكور';
      case 'mapAreaKilimani':
        return 'كيليماني';
      case 'mapAreaNairobi':
        return 'نيروبي';
      case 'mapAreaPangani':
        return 'بانجاني';
      case 'mapAreaParklands':
        return 'باركلاندز';
      case 'mapAreaUpperHill':
        return 'أبر هيل';
      case 'mapAreaWestlands':
        return 'ويستلاندز';
      case 'mapAttribution':
        return 'مساهمو OpenStreetMap';
      case 'mapClinic':
        return 'مستشفى كينياتا';
      case 'myChild':
        return 'طفلي';
      case 'mySelf':
        return 'أنا';
      case 'nameFieldLabel':
        return 'اسمك';
      case 'nameHint':
        return 'الاسم';
      case 'nameInvalid':
        return 'حروف فقط، من فضلك';
      case 'nameTooShort':
        return 'أدخل ٣ أحرف على الأقل';
      case 'newPasswordHint':
        return 'كلمة المرور الجديدة';
      case 'next':
        return 'التالي';
      case 'nextAvailabilityOn':
        return ({required Object day}) => 'أقرب موعد متاح ${day}';
      case 'nextAvailableLabel':
        return 'أقرب موعد متاح';
      case 'nextMonth':
        return 'الشهر التالي';
      case 'noSearchResults':
        return 'لا يوجد أطباء';
      case 'noSearchResultsHint':
        return 'جرّب اسمًا أو تخصصًا آخر.';
      case 'noSlotsAvailable':
        return 'لا توجد مواعيد متاحة';
      case 'onboardingSubtitle':
        return 'على خلاف الاعتقاد السائد، ليس لوريم إيبسوم نصٌ عشوائي فحسب. بل جذوره تعود إلى نصٍّ عمره أكثر من ٢٠٠٠ عام.';
      case 'onboardingTitle1':
        return 'ابحث عن أطباء موثوقين';
      case 'onboardingTitle2':
        return 'اختر أفضل الأطباء';
      case 'onboardingTitle3':
        return 'مواعيد بسهولة';
      case 'orLabel':
        return 'أو';
      case 'otpRequired':
        return ({required Object length}) =>
            'أدخل الرمز المكوّن من ${length} أرقام';
      case 'passwordHint':
        return 'كلمة المرور';
      case 'passwordMinLength':
        return ({required Object minLength}) =>
            'كلمة المرور يجب ألا تقل عن ${minLength} أحرف';
      case 'passwordRequired':
        return 'أدخل كلمة المرور';
      case 'passwordsDoNotMatch':
        return 'كلمتا المرور غير متطابقتين';
      case 'patientNameHint':
        return 'اسم المريض';
      case 'patientStories':
        return ({required Object count}) => '${count} قصة مريض';
      case 'perHourShort':
        return '/ساعة';
      case 'perHourSuffix':
        return '/ الساعة';
      case 'periodSlots':
        return ({required Object period, required Object count}) =>
            '${period} ${count} موعد';
      case 'phoneInvalid':
        return 'أدخل رقم هاتف صحيح';
      case 'popularDoctorsTitle':
        return 'أطباء مشهورون';
      case 'previousMonth':
        return 'الشهر السابق';
      case 'reenterPasswordHint':
        return 'أعد إدخال كلمة المرور';
      case 'reenterPasswordRequired':
        return 'أعد إدخال كلمة المرور';
      case 'registerButton':
        return 'إنشاء حساب';
      case 'registerSwitchAction':
        return 'تسجيل الدخول';
      case 'registerSwitchPrefix':
        return 'لديك حساب بالفعل؟ ';
      case 'registerTitle':
        return 'انضم إلينا لتبدأ البحث';
      case 'reminderMinutes':
        return ({required Object minutes}) => '${minutes} دقيقة';
      case 'reminderTitle':
        return 'ذكّرني قبل';
      case 'resetPasswordSubtitle':
        return 'عيّن كلمة مرور جديدة لحسابك لتتمكن من الدخول والاستفادة من كل المزايا.';
      case 'resetPasswordTitle':
        return 'إعادة تعيين كلمة المرور';
      case 'roleAdmin':
        return 'مسؤول';
      case 'roleAdminDescription':
        return 'أدر الأطباء والمواعيد والمستخدمين والمنصة.';
      case 'rolePatient':
        return 'مريض';
      case 'rolePatientDescription':
        return 'ابحث عن الأطباء، واحجز المواعيد، وأدر سجلاتك الطبية.';
      case 'satisfactionPercent':
        return ({required Object percent}) => '${percent}٪';
      case 'searchDoctors':
        return 'ابحث عن أطباء';
      case 'searchHint':
        return 'ابحث.....';
      case 'searchHintFull':
        return 'ابحث عن أطباء أو تخصصات…';
      case 'seeAll':
        return 'عرض الكل';
      case 'selectTimeTitle':
        return 'اختر الوقت';
      case 'servicePoint1':
        return 'رعاية المريض يجب أن تكون الأولوية القصوى.';
      case 'servicePoint2':
        return 'إذا كنت تدير عيادة، فأنت تعرف مدى الإحباط عندما يفوّت المريض موعده.';
      case 'servicePoint3':
        return 'لهذا يهمّ نظام تذكير المواعيد.';
      case 'servicesTitle':
        return 'الخدمات';
      case 'skip':
        return 'تخطٍ';
      case 'slotsAvailable':
        return ({required Object count}) => '${count} موعد متاح';
      case 'socialFacebook':
        return 'فيسبوك';
      case 'socialGoogle':
        return 'جوجل';
      case 'specialistFallback':
        return 'أخصائي باطنة';
      case 'specialtyDentist':
        return 'طبيب أسنان';
      case 'statOngoing':
        return 'جارية';
      case 'statOngoingValue':
        return '٥٠٠';
      case 'statPatient':
        return 'مريض';
      case 'statPatientValue':
        return '٧٠٠';
      case 'statRunning':
        return 'قيد التشغيل';
      case 'statRunningValue':
        return '١٠٠';
      case 'tabAppointments':
        return 'المواعيد';
      case 'tabBook':
        return 'الحجز';
      case 'tabChat':
        return 'المحادثات';
      case 'tabFavorites':
        return 'المفضلة';
      case 'tabHome':
        return 'الرئيسية';
      case 'tabMap':
        return 'الخريطة';
      case 'tabPlaceholder':
        return ({required Object title}) => 'شاشة ${title}';
      case 'tabProfile':
        return 'الملف الشخصي';
      case 'termsAction':
        return 'شروط الخدمة وسياسة الخصوصية';
      case 'termsPrefix':
        return 'أوافق على ';
      case 'termsRequired':
        return 'يرجى قبول الشروط للمتابعة';
      case 'thankYou':
        return 'شكرًا لك !';
      case 'todayLabel':
        return 'اليوم';
      case 'todayLabelShort':
        return 'اليوم';
      case 'tomorrowLabel':
        return 'غدًا';
      case 'updatePasswordButton':
        return 'تحديث كلمة المرور';
      case 'verifyCodeSubtitle':
        return 'أدخل الرمز المكوّن من ٤ أرقام الذي وصلك على بريدك الإلكتروني.';
      case 'verifyCodeTitle':
        return 'أدخل الرمز المكوّن من ٤ أرقام';
      case 'whoIsPatientTitle':
        return 'من هو المريض؟';
      default:
        return null;
    }
  }
}
