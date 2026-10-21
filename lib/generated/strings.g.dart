/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 588 (294 per locale)
///
/// Built on 2026-10-21 at 17:45 UTC

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
  String get adminActiveAvailable => 'Active & Available';
  String get adminActiveDoctors => 'Active Doctors';
  String get adminAddDoctor => 'Add Doctor';
  String get adminAddPhoto => 'Add photo';
  String get adminAdministrator => 'Administrator';
  String get adminAppInfo => 'App Information';
  String get adminAppVersion => 'v1.0.0';
  String get adminAppointment => 'Appointment';
  String get adminAppointmentCancelled => 'Appointment cancelled';
  String get adminAppointmentCompleted => 'Marked as completed';
  String get adminAppointmentDetailsTitle => 'Appointment Details';
  String get adminAppointmentsTitle => 'Appointments';
  String get adminAvailabilitySaved => 'Availability saved';
  String get adminAvailabilityTitle => 'Doctor Availability';
  String get adminBuildVersion => 'Build version';
  String get adminCameraOption => 'Camera';
  String get adminCancelAppointment => 'Cancel Appointment';
  String get adminCancelConfirmBody =>
      'This marks the appointment as cancelled.';
  String get adminCancelConfirmTitle => 'Cancel appointment?';
  String get adminChangePassword => 'Change Password';
  String get adminChangePasswordSubtitle =>
      'Update master security credentials';
  String get adminChangePasswordTitle => 'Change Password';
  String get adminClinicLocation => 'Clinic Location';
  String get adminConsultationFee => 'Consultation Fee';
  String get adminCreateDoctorButton => 'Create Doctor';
  String get adminCreateDoctorTitle => 'Create Doctor';
  String get adminDateLabel => 'Date';
  String adminDaysEnabled({required Object count}) => '${count} days enabled';
  String get adminDeleteDoctor => 'Delete Doctor';
  String adminDeleteDoctorConfirmBody({required Object name}) =>
      'This permanently removes ${name} from the catalog. This can\'t be undone.';
  String get adminDeleteDoctorConfirmTitle => 'Delete Doctor?';
  String get adminDoctor => 'Doctor';
  String get adminDoctorCreated => 'Doctor created';
  String get adminDoctorDeleted => 'Doctor deleted';
  String get adminDoctorDetailsTitle => 'Doctor Details';
  String get adminDoctorNameHint => 'e.g. Dr. Ahmed Ali';
  String get adminDoctorNameLabel => 'Doctor Name';
  String get adminDoctorStatus => 'Doctor Status';
  String get adminDoctorUpdated => 'Changes saved';
  String get adminDoctorsTitle => 'Doctors';
  String get adminEditDoctor => 'Edit Doctor';
  String get adminEditDoctorTitle => 'Edit Doctor';
  String get adminEditProfileTitle => 'Edit Profile';
  String get adminEmailAddress => 'Email Address';
  String get adminEndTime => 'End Time';
  String get adminFeeHint => 'e.g. \$28.00';
  String get adminFeeLabel => 'Fee';
  String get adminFilterAll => 'All';
  String get adminFullName => 'Full Name';
  String get adminGalleryOption => 'Gallery';
  String get adminLocationName => 'Location Name';
  String get adminLocationNameHint => 'e.g. Central Clinic';
  String get adminLogout => 'Logout';
  String get adminLogoutConfirmBody =>
      'You\'ll need to sign in again to manage the clinic.';
  String get adminLogoutConfirmTitle => 'Log out?';
  String get adminManageAvailability => 'Manage Availability';
  String get adminMarkCompleted => 'Mark as Completed';
  String adminMinutesOption({required Object count}) => '${count} Minutes';
  String get adminNoAppointmentsBody => 'Appointments will appear here.';
  String get adminNoAppointmentsTitle => 'No appointments';
  String get adminNoDoctorsBody =>
      'There are currently no doctors registered on Doctor Hunt. Add your first doctor to get started.';
  String get adminNoDoctorsTitle => 'No Doctors Found';
  String get adminPasswordUpdated => 'Password updated';
  String get adminPatient => 'Patient';
  String get adminProfileSaved => 'Profile updated';
  String get adminProfileSubtitle => 'Edit super admin details & permissions';
  String get adminProfileTitle => 'Admin Profile';
  String get adminRating => 'Rating';
  String adminReviewsCount({required Object count}) => '${count} reviews';
  String get adminSaveAvailability => 'Save Availability';
  String get adminSaveChanges => 'Save Changes';
  String get adminSearchDoctorsHint => 'Search doctors...';
  String get adminSelectSpecialty => 'Select specialty';
  String get adminSettingsTitle => 'Settings';
  String get adminSlotDuration => 'Slot Duration';
  String get adminSpecialtyLabel => 'Specialty';
  String get adminStartTime => 'Start Time';
  String get adminStatusActive => 'Active';
  String get adminStatusCancelled => 'Cancelled';
  String get adminStatusCompleted => 'Completed';
  String get adminStatusInactive => 'Inactive';
  String get adminStatusUpcoming => 'Upcoming';
  String get adminTapMapHint => 'Tap the map to set the location';
  String get adminTapPhotoToChange => 'Tap photo to change';
  String get adminTimeLabel => 'Time';
  String get adminTotalDoctors => 'Total Doctors';
  String get adminViewDetails => 'View Details';
  String get adminWorkingDays => 'Working Days';
  String get adminWorkingHours => 'Working Hours';
  String get afternoonPeriod => 'Afternoon';
  String get appName => 'Doctor Hunt';
  String get appointmentConfirmed => 'Appointment confirmed';
  String get appointmentForTitle => 'Appointment For';
  String get appointmentSuccessful => 'Your Appointment Successful';
  String get appointmentTitle => 'Appointment';
  String get apptDateLabel => 'Appointment date';
  String get apptEmptyCancelled => 'No cancelled appointments';
  String get apptEmptyCompleted => 'No completed appointments';
  String get apptEmptyUpcoming => 'No upcoming appointments';
  String get apptFeeLabel => 'Consultation fee';
  String get apptRateDoctor => 'Rate Doctor';
  String get apptRateTitle => 'Rate your visit';
  String get apptReviewHint => 'Share your experience (optional)';
  String get apptReviewThanks => 'Thanks for your review';
  String get apptSlotTaken => 'This slot was just booked. Please pick another.';
  String get apptSubmit => 'Submit';
  String get apptTapToRate => 'Tap to rate your visit';
  String get apptTimeLabel => 'Appointment time';
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
  String get commonCancel => 'Cancel';
  String get commonDelete => 'Delete';
  String get confirmButton => 'Confirm';
  String get contactClinic => 'Contact Clinic';
  String get contactNumberHint => 'Contact Number';
  String get continueLabel => 'Continue';
  String get dayFriday => 'Friday';
  String get dayMonday => 'Monday';
  String get daySaturday => 'Saturday';
  String get daySunday => 'Sunday';
  String get dayThursday => 'Thursday';
  String get dayTuesday => 'Tuesday';
  String get dayWednesday => 'Wednesday';
  String distanceAway({required Object distance}) => '${distance} away';
  String get doctorAddison => 'Dr. Addison Smith';
  String get doctorBalestra => 'Dr. Balestra';
  String get doctorBennett => 'Dr. Bennett Mccoy';
  String get doctorCrownover => 'Dr. Crownover';
  String get doctorDetailsTitle => 'Doctor Details';
  String get doctorFillerup => 'Dr. Fillerup Grab';
  String get doctorNotFound => 'Doctor not found';
  String get doctorShruti => 'Dr. Shruti Kedia';
  String get doctorWatamaniuk => 'Dr. Watamaniuk';
  String get doneButton => 'Done';
  String get drawerAppointments => 'My Appointments';
  String get drawerLogout => 'Logout';
  String get drawerLogoutConfirmBody =>
      'You\'ll need to sign in again to book appointments.';
  String get drawerLogoutConfirmTitle => 'Log out?';
  String get drawerOpenMenu => 'Open menu';
  String get drawerSettings => 'Settings';
  String get editAppointment => 'Edit your appointment';
  String get emailHint => 'Email';
  String get emailInvalid => 'Enter a valid email';
  String get emailRequired => 'Enter your email';
  String get eveningPeriod => 'Evening';
  String get experienceSuffix => 'Years experience';
  String experienceYears({required Object years}) =>
      '${years} Years experience';
  String get favoriteDoctorsTitle => 'Favourite Doctors';
  String get favoritesEmptyBody =>
      'Tap the heart on a doctor to save them here.';
  String get favoritesEmptyTitle => 'No favourites yet';
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
  String get mapAttribution => 'OpenStreetMap contributors';
  String get morningPeriod => 'Morning';
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
  String get patientFallbackName => 'Patient User';
  String get patientNameHint => 'Patient Name';
  String patientStories({required Object count}) => '${count} Patient Stories';
  String get perHourShort => '/hr';
  String get perHourSuffix => '/ hours';
  String periodSlots({required Object period, required Object count}) =>
      '${period} ${count} slots';
  String get personalInformation => 'Personal information';
  String get phoneInvalid => 'Enter a valid phone number';
  String get popularDoctorsTitle => 'Popular Doctor';
  String get previousMonth => 'Previous month';
  String get privacyPolicyBullet1 =>
      'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.';
  String get privacyPolicyBullet2 =>
      'Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form.';
  String get privacyPolicyBullet3 =>
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry and has been the standard ever since.';
  String get privacyPolicyBullet4 =>
      'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to readable content.';
  String get privacyPolicyHeading => 'Doctor Hunt Apps Privacy Policy';
  String get privacyPolicyIntro =>
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.';
  String get privacyPolicyOutro =>
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout, using Lorem Ipsum as placeholder text before the final copy is available.';
  String get privacyPolicyTitle => 'Privacy policy';
  String get profileUpdated => 'Profile updated';
  String get reenterPasswordHint => 'Re-enter Password';
  String get reenterPasswordRequired => 'Re-enter your password';
  String get registerButton => 'Sign up';
  String get registerSwitchAction => 'Log in';
  String get registerSwitchPrefix => 'Have an account? ';
  String get registerTitle => 'Join us to start searching';
  String reminderMinutes({required Object minutes}) => '${minutes} min';
  String get reminderTitle => 'Reminder Me Before';
  String get resendCodeButton => 'Resend code';
  String resendCodeCountdown({required Object seconds}) =>
      'Resend code in ${seconds}s';
  String get resendCodeQuestion => 'Didn\'t receive the code?';
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
  String get seedAdminEmail => 'admin@doctorhunt.com';
  String get seedAdminName => 'Ahmed Khaled';
  String get seedClinicLocation => 'Central Clinic · 24 Garden Avenue';
  String get seedPatientDanielKim => 'Daniel Kim';
  String get seedPatientEthanBrooks => 'Ethan Brooks';
  String get seedPatientJamesWilson => 'James Wilson';
  String get seedPatientMayaPatel => 'Maya Patel';
  String get seedPatientOliviaMartin => 'Olivia Martin';
  String get seedPatientSophiaClark => 'Sophia Clark';
  String get seedReviewKind => 'Very professional and kind.';
  String get seedReviewReassuring => 'Clear and reassuring.';
  String get selectTimeTitle => 'Select Time';
  String get servicePoint1 => 'Patient care should be the number one priority.';
  String get servicePoint2 =>
      'If you run your practice you know how frustrating it can be when a patient misses an appointment.';
  String get servicePoint3 =>
      'That\'s why an appointment reminder system matters.';
  String get servicesTitle => 'Services';
  String get settingsAccountSection => 'Account settings';
  String get settingsChangePassword => 'Change Password';
  String get settingsLanguageArabic => 'العربية';
  String get settingsLanguageEnglish => 'English';
  String get settingsLanguageTitle => 'Select language';
  String get settingsLanguages => 'Languages';
  String get settingsMoreSection => 'More options';
  String get settingsNotifications => 'Notifications';
  String get settingsPrivacyPolicy => 'Privacy Policy';
  String get skip => 'Skip';
  String slotsAvailable({required Object count}) => '${count} slots available';
  String get socialFacebook => 'Facebook';
  String get socialGoogle => 'Google';
  String get specialistFallback => 'Medicine Specialist';
  String get specialtyDentist => 'Teeth Dentist';
  String get statRating => 'Rating';
  String get statReviews => 'Reviews';
  String get statSatisfaction => 'Satisfaction';
  String get tabAppointments => 'Appointments';
  String get tabBook => 'Book';
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
  String get adminActiveAvailable => 'نشط ومتاح';
  @override
  String get adminActiveDoctors => 'الأطباء النشطون';
  @override
  String get adminAddDoctor => 'إضافة طبيب';
  @override
  String get adminAddPhoto => 'إضافة صورة';
  @override
  String get adminAdministrator => 'المسؤول';
  @override
  String get adminAppInfo => 'معلومات التطبيق';
  @override
  String get adminAppVersion => 'v1.0.0';
  @override
  String get adminAppointment => 'الموعد';
  @override
  String get adminAppointmentCancelled => 'تم إلغاء الموعد';
  @override
  String get adminAppointmentCompleted => 'تم وضع علامة مكتمل';
  @override
  String get adminAppointmentDetailsTitle => 'تفاصيل الموعد';
  @override
  String get adminAppointmentsTitle => 'المواعيد';
  @override
  String get adminAvailabilitySaved => 'تم حفظ التوفّر';
  @override
  String get adminAvailabilityTitle => 'توفّر الطبيب';
  @override
  String get adminBuildVersion => 'رقم الإصدار';
  @override
  String get adminCameraOption => 'الكاميرا';
  @override
  String get adminCancelAppointment => 'إلغاء الموعد';
  @override
  String get adminCancelConfirmBody => 'سيتم وضع علامة ملغي على الموعد.';
  @override
  String get adminCancelConfirmTitle => 'إلغاء الموعد؟';
  @override
  String get adminChangePassword => 'تغيير كلمة المرور';
  @override
  String get adminChangePasswordSubtitle => 'تحديث بيانات الأمان الرئيسية';
  @override
  String get adminChangePasswordTitle => 'تغيير كلمة المرور';
  @override
  String get adminClinicLocation => 'موقع العيادة';
  @override
  String get adminConsultationFee => 'رسوم الكشف';
  @override
  String get adminCreateDoctorButton => 'إنشاء طبيب';
  @override
  String get adminCreateDoctorTitle => 'إنشاء طبيب';
  @override
  String get adminDateLabel => 'التاريخ';
  @override
  String adminDaysEnabled({required Object count}) => '${count} أيام مفعّلة';
  @override
  String get adminDeleteDoctor => 'حذف الطبيب';
  @override
  String adminDeleteDoctorConfirmBody({required Object name}) =>
      'سيؤدي هذا إلى حذف ${name} نهائيًا من القائمة. لا يمكن التراجع.';
  @override
  String get adminDeleteDoctorConfirmTitle => 'حذف الطبيب؟';
  @override
  String get adminDoctor => 'الطبيب';
  @override
  String get adminDoctorCreated => 'تم إنشاء الطبيب';
  @override
  String get adminDoctorDeleted => 'تم حذف الطبيب';
  @override
  String get adminDoctorDetailsTitle => 'بيانات الطبيب';
  @override
  String get adminDoctorNameHint => 'مثال: د. أحمد علي';
  @override
  String get adminDoctorNameLabel => 'اسم الطبيب';
  @override
  String get adminDoctorStatus => 'حالة الطبيب';
  @override
  String get adminDoctorUpdated => 'تم حفظ التغييرات';
  @override
  String get adminDoctorsTitle => 'الأطباء';
  @override
  String get adminEditDoctor => 'تعديل الطبيب';
  @override
  String get adminEditDoctorTitle => 'تعديل الطبيب';
  @override
  String get adminEditProfileTitle => 'تعديل الملف الشخصي';
  @override
  String get adminEmailAddress => 'البريد الإلكتروني';
  @override
  String get adminEndTime => 'وقت الانتهاء';
  @override
  String get adminFeeHint => 'مثال: \$28.00';
  @override
  String get adminFeeLabel => 'الرسوم';
  @override
  String get adminFilterAll => 'الكل';
  @override
  String get adminFullName => 'الاسم الكامل';
  @override
  String get adminGalleryOption => 'المعرض';
  @override
  String get adminLocationName => 'اسم الموقع';
  @override
  String get adminLocationNameHint => 'مثال: العيادة المركزية';
  @override
  String get adminLogout => 'تسجيل الخروج';
  @override
  String get adminLogoutConfirmBody =>
      'ستحتاج إلى تسجيل الدخول مرة أخرى لإدارة العيادة.';
  @override
  String get adminLogoutConfirmTitle => 'تسجيل الخروج؟';
  @override
  String get adminManageAvailability => 'إدارة التوفّر';
  @override
  String get adminMarkCompleted => 'وضع علامة مكتمل';
  @override
  String adminMinutesOption({required Object count}) => '${count} دقيقة';
  @override
  String get adminNoAppointmentsBody => 'ستظهر المواعيد هنا.';
  @override
  String get adminNoAppointmentsTitle => 'لا توجد مواعيد';
  @override
  String get adminNoDoctorsBody =>
      'لا يوجد أطباء مسجّلون في دكتور هانت حاليًا. أضف أول طبيب للبدء.';
  @override
  String get adminNoDoctorsTitle => 'لا يوجد أطباء';
  @override
  String get adminPasswordUpdated => 'تم تحديث كلمة المرور';
  @override
  String get adminPatient => 'المريض';
  @override
  String get adminProfileSaved => 'تم تحديث الملف الشخصي';
  @override
  String get adminProfileSubtitle => 'تعديل بيانات المسؤول والصلاحيات';
  @override
  String get adminProfileTitle => 'ملف المسؤول';
  @override
  String get adminRating => 'التقييم';
  @override
  String adminReviewsCount({required Object count}) => '${count} تقييم';
  @override
  String get adminSaveAvailability => 'حفظ التوفّر';
  @override
  String get adminSaveChanges => 'حفظ التغييرات';
  @override
  String get adminSearchDoctorsHint => 'ابحث عن أطباء...';
  @override
  String get adminSelectSpecialty => 'اختر التخصص';
  @override
  String get adminSettingsTitle => 'الإعدادات';
  @override
  String get adminSlotDuration => 'مدة الموعد';
  @override
  String get adminSpecialtyLabel => 'التخصص';
  @override
  String get adminStartTime => 'وقت البدء';
  @override
  String get adminStatusActive => 'نشط';
  @override
  String get adminStatusCancelled => 'ملغي';
  @override
  String get adminStatusCompleted => 'مكتمل';
  @override
  String get adminStatusInactive => 'غير نشط';
  @override
  String get adminStatusUpcoming => 'قادم';
  @override
  String get adminTapMapHint => 'اضغط على الخريطة لتحديد الموقع';
  @override
  String get adminTapPhotoToChange => 'اضغط على الصورة لتغييرها';
  @override
  String get adminTimeLabel => 'الوقت';
  @override
  String get adminTotalDoctors => 'إجمالي الأطباء';
  @override
  String get adminViewDetails => 'عرض التفاصيل';
  @override
  String get adminWorkingDays => 'أيام العمل';
  @override
  String get adminWorkingHours => 'ساعات العمل';
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
  String get apptDateLabel => 'تاريخ الموعد';
  @override
  String get apptEmptyCancelled => 'لا توجد مواعيد ملغاة';
  @override
  String get apptEmptyCompleted => 'لا توجد مواعيد مكتملة';
  @override
  String get apptEmptyUpcoming => 'لا توجد مواعيد قادمة';
  @override
  String get apptFeeLabel => 'رسوم الكشف';
  @override
  String get apptRateDoctor => 'قيّم الطبيب';
  @override
  String get apptRateTitle => 'قيّم زيارتك';
  @override
  String get apptReviewHint => 'شاركنا تجربتك (اختياري)';
  @override
  String get apptReviewThanks => 'شكرًا على تقييمك';
  @override
  String get apptSlotTaken => 'تم حجز هذا الموعد للتو. الرجاء اختيار موعد آخر.';
  @override
  String get apptSubmit => 'إرسال';
  @override
  String get apptTapToRate => 'اضغط لتقييم زيارتك';
  @override
  String get apptTimeLabel => 'وقت الموعد';
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
  String get commonCancel => 'إلغاء';
  @override
  String get commonDelete => 'حذف';
  @override
  String get confirmButton => 'تأكيد';
  @override
  String get contactClinic => 'تواصل مع العيادة';
  @override
  String get contactNumberHint => 'رقم التواصل';
  @override
  String get continueLabel => 'متابعة';
  @override
  String get dayFriday => 'الجمعة';
  @override
  String get dayMonday => 'الإثنين';
  @override
  String get daySaturday => 'السبت';
  @override
  String get daySunday => 'الأحد';
  @override
  String get dayThursday => 'الخميس';
  @override
  String get dayTuesday => 'الثلاثاء';
  @override
  String get dayWednesday => 'الأربعاء';
  @override
  String distanceAway({required Object distance}) => 'يبعد ${distance}';
  @override
  String get doctorAddison => 'Dr. Addison Smith';
  @override
  String get doctorBalestra => 'Dr. Balestra';
  @override
  String get doctorBennett => 'Dr. Bennett Mccoy';
  @override
  String get doctorCrownover => 'Dr. Crownover';
  @override
  String get doctorDetailsTitle => 'بيانات الطبيب';
  @override
  String get doctorFillerup => 'Dr. Fillerup Grab';
  @override
  String get doctorNotFound => 'لم يتم العثور على الطبيب';
  @override
  String get doctorShruti => 'Dr. Shruti Kedia';
  @override
  String get doctorWatamaniuk => 'Dr. Watamaniuk';
  @override
  String get doneButton => 'تم';
  @override
  String get drawerAppointments => 'مواعيدي';
  @override
  String get drawerLogout => 'تسجيل الخروج';
  @override
  String get drawerLogoutConfirmBody =>
      'ستحتاج إلى تسجيل الدخول مرة أخرى لحجز المواعيد.';
  @override
  String get drawerLogoutConfirmTitle => 'تسجيل الخروج؟';
  @override
  String get drawerOpenMenu => 'فتح القائمة';
  @override
  String get drawerSettings => 'الإعدادات';
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
  String get favoriteDoctorsTitle => 'الأطباء المفضّلون';
  @override
  String get favoritesEmptyBody => 'اضغط على القلب لدى أي طبيب لحفظه هنا.';
  @override
  String get favoritesEmptyTitle => 'لا توجد مفضّلات بعد';
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
  String get mapAttribution => 'مساهمو OpenStreetMap';
  @override
  String get morningPeriod => 'صباحًا';
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
  String get patientFallbackName => 'مستخدم مريض';
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
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get phoneInvalid => 'أدخل رقم هاتف صحيح';
  @override
  String get popularDoctorsTitle => 'أطباء مشهورون';
  @override
  String get previousMonth => 'الشهر السابق';
  @override
  String get privacyPolicyBullet1 =>
      'الجزء القياسي من لوريم إيبسوم المستخدم منذ القرن الخامس عشر معاد إنتاجه أدناه لمن يرغب بالاطلاع.';
  @override
  String get privacyPolicyBullet2 =>
      'كما أُعيد إنتاج القسمين 1.10.32 و1.10.33 من كتاب شيشرون بصيغتهما الأصلية تمامًا.';
  @override
  String get privacyPolicyBullet3 =>
      'لوريم إيبسوم هو ببساطة نص شكلي يُستخدم في صناعة الطباعة والتنضيد وظلّ المعيار منذ ذلك الحين.';
  @override
  String get privacyPolicyBullet4 =>
      'الهدف من استخدام لوريم إيبسوم أنه يوفّر توزيعًا طبيعيًا تقريبًا للأحرف بعكس النص المقروء.';
  @override
  String get privacyPolicyHeading => 'سياسة خصوصية تطبيق Doctor Hunt';
  @override
  String get privacyPolicyIntro =>
      'توجد صيغ عديدة من نصوص لوريم إيبسوم، لكن غالبيتها خضعت لتعديل بشكل أو بآخر عبر إقحام فقرات هزلية أو كلمات عشوائية لا تبدو مقنعة. من الحقائق الثابتة منذ زمن طويل أن القارئ ينشغل بالمحتوى المقروء للصفحة عند النظر إلى تخطيطها. والهدف من استخدام لوريم إيبسوم أنه يوفّر توزيعًا طبيعيًا تقريبًا للأحرف.';
  @override
  String get privacyPolicyOutro =>
      'من الحقائق الثابتة منذ زمن طويل أن القارئ ينشغل بالمحتوى المقروء للصفحة عند النظر إلى تخطيطها، مع استخدام لوريم إيبسوم كنص بديل إلى حين توفّر النص النهائي.';
  @override
  String get privacyPolicyTitle => 'سياسة الخصوصية';
  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي';
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
  String get resendCodeButton => 'إعادة إرسال الرمز';
  @override
  String resendCodeCountdown({required Object seconds}) =>
      'إعادة الإرسال خلال ${seconds} ثانية';
  @override
  String get resendCodeQuestion => 'لم يصلك الرمز؟';
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
  String get seedAdminEmail => 'admin@doctorhunt.com';
  @override
  String get seedAdminName => 'Ahmed Khaled';
  @override
  String get seedClinicLocation => 'Central Clinic · 24 Garden Avenue';
  @override
  String get seedPatientDanielKim => 'Daniel Kim';
  @override
  String get seedPatientEthanBrooks => 'Ethan Brooks';
  @override
  String get seedPatientJamesWilson => 'James Wilson';
  @override
  String get seedPatientMayaPatel => 'Maya Patel';
  @override
  String get seedPatientOliviaMartin => 'Olivia Martin';
  @override
  String get seedPatientSophiaClark => 'Sophia Clark';
  @override
  String get seedReviewKind => 'محترف ولطيف جدًا.';
  @override
  String get seedReviewReassuring => 'واضح ومطمئن.';
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
  String get settingsAccountSection => 'إعدادات الحساب';
  @override
  String get settingsChangePassword => 'تغيير كلمة المرور';
  @override
  String get settingsLanguageArabic => 'العربية';
  @override
  String get settingsLanguageEnglish => 'English';
  @override
  String get settingsLanguageTitle => 'اختر اللغة';
  @override
  String get settingsLanguages => 'اللغة';
  @override
  String get settingsMoreSection => 'خيارات أخرى';
  @override
  String get settingsNotifications => 'الإشعارات';
  @override
  String get settingsPrivacyPolicy => 'سياسة الخصوصية';
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
  String get statRating => 'التقييم';
  @override
  String get statReviews => 'التقييمات';
  @override
  String get statSatisfaction => 'الرضا';
  @override
  String get tabAppointments => 'المواعيد';
  @override
  String get tabBook => 'الحجز';
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
  String get whoIsPatientTitle => 'من هو المريض؟';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'addPatient':
        return 'Add';
      case 'adminActiveAvailable':
        return 'Active & Available';
      case 'adminActiveDoctors':
        return 'Active Doctors';
      case 'adminAddDoctor':
        return 'Add Doctor';
      case 'adminAddPhoto':
        return 'Add photo';
      case 'adminAdministrator':
        return 'Administrator';
      case 'adminAppInfo':
        return 'App Information';
      case 'adminAppVersion':
        return 'v1.0.0';
      case 'adminAppointment':
        return 'Appointment';
      case 'adminAppointmentCancelled':
        return 'Appointment cancelled';
      case 'adminAppointmentCompleted':
        return 'Marked as completed';
      case 'adminAppointmentDetailsTitle':
        return 'Appointment Details';
      case 'adminAppointmentsTitle':
        return 'Appointments';
      case 'adminAvailabilitySaved':
        return 'Availability saved';
      case 'adminAvailabilityTitle':
        return 'Doctor Availability';
      case 'adminBuildVersion':
        return 'Build version';
      case 'adminCameraOption':
        return 'Camera';
      case 'adminCancelAppointment':
        return 'Cancel Appointment';
      case 'adminCancelConfirmBody':
        return 'This marks the appointment as cancelled.';
      case 'adminCancelConfirmTitle':
        return 'Cancel appointment?';
      case 'adminChangePassword':
        return 'Change Password';
      case 'adminChangePasswordSubtitle':
        return 'Update master security credentials';
      case 'adminChangePasswordTitle':
        return 'Change Password';
      case 'adminClinicLocation':
        return 'Clinic Location';
      case 'adminConsultationFee':
        return 'Consultation Fee';
      case 'adminCreateDoctorButton':
        return 'Create Doctor';
      case 'adminCreateDoctorTitle':
        return 'Create Doctor';
      case 'adminDateLabel':
        return 'Date';
      case 'adminDaysEnabled':
        return ({required Object count}) => '${count} days enabled';
      case 'adminDeleteDoctor':
        return 'Delete Doctor';
      case 'adminDeleteDoctorConfirmBody':
        return ({required Object name}) =>
            'This permanently removes ${name} from the catalog. This can\'t be undone.';
      case 'adminDeleteDoctorConfirmTitle':
        return 'Delete Doctor?';
      case 'adminDoctor':
        return 'Doctor';
      case 'adminDoctorCreated':
        return 'Doctor created';
      case 'adminDoctorDeleted':
        return 'Doctor deleted';
      case 'adminDoctorDetailsTitle':
        return 'Doctor Details';
      case 'adminDoctorNameHint':
        return 'e.g. Dr. Ahmed Ali';
      case 'adminDoctorNameLabel':
        return 'Doctor Name';
      case 'adminDoctorStatus':
        return 'Doctor Status';
      case 'adminDoctorUpdated':
        return 'Changes saved';
      case 'adminDoctorsTitle':
        return 'Doctors';
      case 'adminEditDoctor':
        return 'Edit Doctor';
      case 'adminEditDoctorTitle':
        return 'Edit Doctor';
      case 'adminEditProfileTitle':
        return 'Edit Profile';
      case 'adminEmailAddress':
        return 'Email Address';
      case 'adminEndTime':
        return 'End Time';
      case 'adminFeeHint':
        return 'e.g. \$28.00';
      case 'adminFeeLabel':
        return 'Fee';
      case 'adminFilterAll':
        return 'All';
      case 'adminFullName':
        return 'Full Name';
      case 'adminGalleryOption':
        return 'Gallery';
      case 'adminLocationName':
        return 'Location Name';
      case 'adminLocationNameHint':
        return 'e.g. Central Clinic';
      case 'adminLogout':
        return 'Logout';
      case 'adminLogoutConfirmBody':
        return 'You\'ll need to sign in again to manage the clinic.';
      case 'adminLogoutConfirmTitle':
        return 'Log out?';
      case 'adminManageAvailability':
        return 'Manage Availability';
      case 'adminMarkCompleted':
        return 'Mark as Completed';
      case 'adminMinutesOption':
        return ({required Object count}) => '${count} Minutes';
      case 'adminNoAppointmentsBody':
        return 'Appointments will appear here.';
      case 'adminNoAppointmentsTitle':
        return 'No appointments';
      case 'adminNoDoctorsBody':
        return 'There are currently no doctors registered on Doctor Hunt. Add your first doctor to get started.';
      case 'adminNoDoctorsTitle':
        return 'No Doctors Found';
      case 'adminPasswordUpdated':
        return 'Password updated';
      case 'adminPatient':
        return 'Patient';
      case 'adminProfileSaved':
        return 'Profile updated';
      case 'adminProfileSubtitle':
        return 'Edit super admin details & permissions';
      case 'adminProfileTitle':
        return 'Admin Profile';
      case 'adminRating':
        return 'Rating';
      case 'adminReviewsCount':
        return ({required Object count}) => '${count} reviews';
      case 'adminSaveAvailability':
        return 'Save Availability';
      case 'adminSaveChanges':
        return 'Save Changes';
      case 'adminSearchDoctorsHint':
        return 'Search doctors...';
      case 'adminSelectSpecialty':
        return 'Select specialty';
      case 'adminSettingsTitle':
        return 'Settings';
      case 'adminSlotDuration':
        return 'Slot Duration';
      case 'adminSpecialtyLabel':
        return 'Specialty';
      case 'adminStartTime':
        return 'Start Time';
      case 'adminStatusActive':
        return 'Active';
      case 'adminStatusCancelled':
        return 'Cancelled';
      case 'adminStatusCompleted':
        return 'Completed';
      case 'adminStatusInactive':
        return 'Inactive';
      case 'adminStatusUpcoming':
        return 'Upcoming';
      case 'adminTapMapHint':
        return 'Tap the map to set the location';
      case 'adminTapPhotoToChange':
        return 'Tap photo to change';
      case 'adminTimeLabel':
        return 'Time';
      case 'adminTotalDoctors':
        return 'Total Doctors';
      case 'adminViewDetails':
        return 'View Details';
      case 'adminWorkingDays':
        return 'Working Days';
      case 'adminWorkingHours':
        return 'Working Hours';
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
      case 'apptDateLabel':
        return 'Appointment date';
      case 'apptEmptyCancelled':
        return 'No cancelled appointments';
      case 'apptEmptyCompleted':
        return 'No completed appointments';
      case 'apptEmptyUpcoming':
        return 'No upcoming appointments';
      case 'apptFeeLabel':
        return 'Consultation fee';
      case 'apptRateDoctor':
        return 'Rate Doctor';
      case 'apptRateTitle':
        return 'Rate your visit';
      case 'apptReviewHint':
        return 'Share your experience (optional)';
      case 'apptReviewThanks':
        return 'Thanks for your review';
      case 'apptSlotTaken':
        return 'This slot was just booked. Please pick another.';
      case 'apptSubmit':
        return 'Submit';
      case 'apptTapToRate':
        return 'Tap to rate your visit';
      case 'apptTimeLabel':
        return 'Appointment time';
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
      case 'commonCancel':
        return 'Cancel';
      case 'commonDelete':
        return 'Delete';
      case 'confirmButton':
        return 'Confirm';
      case 'contactClinic':
        return 'Contact Clinic';
      case 'contactNumberHint':
        return 'Contact Number';
      case 'continueLabel':
        return 'Continue';
      case 'dayFriday':
        return 'Friday';
      case 'dayMonday':
        return 'Monday';
      case 'daySaturday':
        return 'Saturday';
      case 'daySunday':
        return 'Sunday';
      case 'dayThursday':
        return 'Thursday';
      case 'dayTuesday':
        return 'Tuesday';
      case 'dayWednesday':
        return 'Wednesday';
      case 'distanceAway':
        return ({required Object distance}) => '${distance} away';
      case 'doctorAddison':
        return 'Dr. Addison Smith';
      case 'doctorBalestra':
        return 'Dr. Balestra';
      case 'doctorBennett':
        return 'Dr. Bennett Mccoy';
      case 'doctorCrownover':
        return 'Dr. Crownover';
      case 'doctorDetailsTitle':
        return 'Doctor Details';
      case 'doctorFillerup':
        return 'Dr. Fillerup Grab';
      case 'doctorNotFound':
        return 'Doctor not found';
      case 'doctorShruti':
        return 'Dr. Shruti Kedia';
      case 'doctorWatamaniuk':
        return 'Dr. Watamaniuk';
      case 'doneButton':
        return 'Done';
      case 'drawerAppointments':
        return 'My Appointments';
      case 'drawerLogout':
        return 'Logout';
      case 'drawerLogoutConfirmBody':
        return 'You\'ll need to sign in again to book appointments.';
      case 'drawerLogoutConfirmTitle':
        return 'Log out?';
      case 'drawerOpenMenu':
        return 'Open menu';
      case 'drawerSettings':
        return 'Settings';
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
      case 'favoriteDoctorsTitle':
        return 'Favourite Doctors';
      case 'favoritesEmptyBody':
        return 'Tap the heart on a doctor to save them here.';
      case 'favoritesEmptyTitle':
        return 'No favourites yet';
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
      case 'mapAttribution':
        return 'OpenStreetMap contributors';
      case 'morningPeriod':
        return 'Morning';
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
      case 'patientFallbackName':
        return 'Patient User';
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
      case 'personalInformation':
        return 'Personal information';
      case 'phoneInvalid':
        return 'Enter a valid phone number';
      case 'popularDoctorsTitle':
        return 'Popular Doctor';
      case 'previousMonth':
        return 'Previous month';
      case 'privacyPolicyBullet1':
        return 'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.';
      case 'privacyPolicyBullet2':
        return 'Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form.';
      case 'privacyPolicyBullet3':
        return 'Lorem Ipsum is simply dummy text of the printing and typesetting industry and has been the standard ever since.';
      case 'privacyPolicyBullet4':
        return 'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to readable content.';
      case 'privacyPolicyHeading':
        return 'Doctor Hunt Apps Privacy Policy';
      case 'privacyPolicyIntro':
        return 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters.';
      case 'privacyPolicyOutro':
        return 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout, using Lorem Ipsum as placeholder text before the final copy is available.';
      case 'privacyPolicyTitle':
        return 'Privacy policy';
      case 'profileUpdated':
        return 'Profile updated';
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
      case 'resendCodeButton':
        return 'Resend code';
      case 'resendCodeCountdown':
        return ({required Object seconds}) => 'Resend code in ${seconds}s';
      case 'resendCodeQuestion':
        return 'Didn\'t receive the code?';
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
      case 'seedAdminEmail':
        return 'admin@doctorhunt.com';
      case 'seedAdminName':
        return 'Ahmed Khaled';
      case 'seedClinicLocation':
        return 'Central Clinic · 24 Garden Avenue';
      case 'seedPatientDanielKim':
        return 'Daniel Kim';
      case 'seedPatientEthanBrooks':
        return 'Ethan Brooks';
      case 'seedPatientJamesWilson':
        return 'James Wilson';
      case 'seedPatientMayaPatel':
        return 'Maya Patel';
      case 'seedPatientOliviaMartin':
        return 'Olivia Martin';
      case 'seedPatientSophiaClark':
        return 'Sophia Clark';
      case 'seedReviewKind':
        return 'Very professional and kind.';
      case 'seedReviewReassuring':
        return 'Clear and reassuring.';
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
      case 'settingsAccountSection':
        return 'Account settings';
      case 'settingsChangePassword':
        return 'Change Password';
      case 'settingsLanguageArabic':
        return 'العربية';
      case 'settingsLanguageEnglish':
        return 'English';
      case 'settingsLanguageTitle':
        return 'Select language';
      case 'settingsLanguages':
        return 'Languages';
      case 'settingsMoreSection':
        return 'More options';
      case 'settingsNotifications':
        return 'Notifications';
      case 'settingsPrivacyPolicy':
        return 'Privacy Policy';
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
      case 'statRating':
        return 'Rating';
      case 'statReviews':
        return 'Reviews';
      case 'statSatisfaction':
        return 'Satisfaction';
      case 'tabAppointments':
        return 'Appointments';
      case 'tabBook':
        return 'Book';
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
        return 'Enter the 6 digits code that you received on your email.';
      case 'verifyCodeTitle':
        return 'Enter 6 Digits Code';
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
      case 'adminActiveAvailable':
        return 'نشط ومتاح';
      case 'adminActiveDoctors':
        return 'الأطباء النشطون';
      case 'adminAddDoctor':
        return 'إضافة طبيب';
      case 'adminAddPhoto':
        return 'إضافة صورة';
      case 'adminAdministrator':
        return 'المسؤول';
      case 'adminAppInfo':
        return 'معلومات التطبيق';
      case 'adminAppVersion':
        return 'v1.0.0';
      case 'adminAppointment':
        return 'الموعد';
      case 'adminAppointmentCancelled':
        return 'تم إلغاء الموعد';
      case 'adminAppointmentCompleted':
        return 'تم وضع علامة مكتمل';
      case 'adminAppointmentDetailsTitle':
        return 'تفاصيل الموعد';
      case 'adminAppointmentsTitle':
        return 'المواعيد';
      case 'adminAvailabilitySaved':
        return 'تم حفظ التوفّر';
      case 'adminAvailabilityTitle':
        return 'توفّر الطبيب';
      case 'adminBuildVersion':
        return 'رقم الإصدار';
      case 'adminCameraOption':
        return 'الكاميرا';
      case 'adminCancelAppointment':
        return 'إلغاء الموعد';
      case 'adminCancelConfirmBody':
        return 'سيتم وضع علامة ملغي على الموعد.';
      case 'adminCancelConfirmTitle':
        return 'إلغاء الموعد؟';
      case 'adminChangePassword':
        return 'تغيير كلمة المرور';
      case 'adminChangePasswordSubtitle':
        return 'تحديث بيانات الأمان الرئيسية';
      case 'adminChangePasswordTitle':
        return 'تغيير كلمة المرور';
      case 'adminClinicLocation':
        return 'موقع العيادة';
      case 'adminConsultationFee':
        return 'رسوم الكشف';
      case 'adminCreateDoctorButton':
        return 'إنشاء طبيب';
      case 'adminCreateDoctorTitle':
        return 'إنشاء طبيب';
      case 'adminDateLabel':
        return 'التاريخ';
      case 'adminDaysEnabled':
        return ({required Object count}) => '${count} أيام مفعّلة';
      case 'adminDeleteDoctor':
        return 'حذف الطبيب';
      case 'adminDeleteDoctorConfirmBody':
        return ({required Object name}) =>
            'سيؤدي هذا إلى حذف ${name} نهائيًا من القائمة. لا يمكن التراجع.';
      case 'adminDeleteDoctorConfirmTitle':
        return 'حذف الطبيب؟';
      case 'adminDoctor':
        return 'الطبيب';
      case 'adminDoctorCreated':
        return 'تم إنشاء الطبيب';
      case 'adminDoctorDeleted':
        return 'تم حذف الطبيب';
      case 'adminDoctorDetailsTitle':
        return 'بيانات الطبيب';
      case 'adminDoctorNameHint':
        return 'مثال: د. أحمد علي';
      case 'adminDoctorNameLabel':
        return 'اسم الطبيب';
      case 'adminDoctorStatus':
        return 'حالة الطبيب';
      case 'adminDoctorUpdated':
        return 'تم حفظ التغييرات';
      case 'adminDoctorsTitle':
        return 'الأطباء';
      case 'adminEditDoctor':
        return 'تعديل الطبيب';
      case 'adminEditDoctorTitle':
        return 'تعديل الطبيب';
      case 'adminEditProfileTitle':
        return 'تعديل الملف الشخصي';
      case 'adminEmailAddress':
        return 'البريد الإلكتروني';
      case 'adminEndTime':
        return 'وقت الانتهاء';
      case 'adminFeeHint':
        return 'مثال: \$28.00';
      case 'adminFeeLabel':
        return 'الرسوم';
      case 'adminFilterAll':
        return 'الكل';
      case 'adminFullName':
        return 'الاسم الكامل';
      case 'adminGalleryOption':
        return 'المعرض';
      case 'adminLocationName':
        return 'اسم الموقع';
      case 'adminLocationNameHint':
        return 'مثال: العيادة المركزية';
      case 'adminLogout':
        return 'تسجيل الخروج';
      case 'adminLogoutConfirmBody':
        return 'ستحتاج إلى تسجيل الدخول مرة أخرى لإدارة العيادة.';
      case 'adminLogoutConfirmTitle':
        return 'تسجيل الخروج؟';
      case 'adminManageAvailability':
        return 'إدارة التوفّر';
      case 'adminMarkCompleted':
        return 'وضع علامة مكتمل';
      case 'adminMinutesOption':
        return ({required Object count}) => '${count} دقيقة';
      case 'adminNoAppointmentsBody':
        return 'ستظهر المواعيد هنا.';
      case 'adminNoAppointmentsTitle':
        return 'لا توجد مواعيد';
      case 'adminNoDoctorsBody':
        return 'لا يوجد أطباء مسجّلون في دكتور هانت حاليًا. أضف أول طبيب للبدء.';
      case 'adminNoDoctorsTitle':
        return 'لا يوجد أطباء';
      case 'adminPasswordUpdated':
        return 'تم تحديث كلمة المرور';
      case 'adminPatient':
        return 'المريض';
      case 'adminProfileSaved':
        return 'تم تحديث الملف الشخصي';
      case 'adminProfileSubtitle':
        return 'تعديل بيانات المسؤول والصلاحيات';
      case 'adminProfileTitle':
        return 'ملف المسؤول';
      case 'adminRating':
        return 'التقييم';
      case 'adminReviewsCount':
        return ({required Object count}) => '${count} تقييم';
      case 'adminSaveAvailability':
        return 'حفظ التوفّر';
      case 'adminSaveChanges':
        return 'حفظ التغييرات';
      case 'adminSearchDoctorsHint':
        return 'ابحث عن أطباء...';
      case 'adminSelectSpecialty':
        return 'اختر التخصص';
      case 'adminSettingsTitle':
        return 'الإعدادات';
      case 'adminSlotDuration':
        return 'مدة الموعد';
      case 'adminSpecialtyLabel':
        return 'التخصص';
      case 'adminStartTime':
        return 'وقت البدء';
      case 'adminStatusActive':
        return 'نشط';
      case 'adminStatusCancelled':
        return 'ملغي';
      case 'adminStatusCompleted':
        return 'مكتمل';
      case 'adminStatusInactive':
        return 'غير نشط';
      case 'adminStatusUpcoming':
        return 'قادم';
      case 'adminTapMapHint':
        return 'اضغط على الخريطة لتحديد الموقع';
      case 'adminTapPhotoToChange':
        return 'اضغط على الصورة لتغييرها';
      case 'adminTimeLabel':
        return 'الوقت';
      case 'adminTotalDoctors':
        return 'إجمالي الأطباء';
      case 'adminViewDetails':
        return 'عرض التفاصيل';
      case 'adminWorkingDays':
        return 'أيام العمل';
      case 'adminWorkingHours':
        return 'ساعات العمل';
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
      case 'apptDateLabel':
        return 'تاريخ الموعد';
      case 'apptEmptyCancelled':
        return 'لا توجد مواعيد ملغاة';
      case 'apptEmptyCompleted':
        return 'لا توجد مواعيد مكتملة';
      case 'apptEmptyUpcoming':
        return 'لا توجد مواعيد قادمة';
      case 'apptFeeLabel':
        return 'رسوم الكشف';
      case 'apptRateDoctor':
        return 'قيّم الطبيب';
      case 'apptRateTitle':
        return 'قيّم زيارتك';
      case 'apptReviewHint':
        return 'شاركنا تجربتك (اختياري)';
      case 'apptReviewThanks':
        return 'شكرًا على تقييمك';
      case 'apptSlotTaken':
        return 'تم حجز هذا الموعد للتو. الرجاء اختيار موعد آخر.';
      case 'apptSubmit':
        return 'إرسال';
      case 'apptTapToRate':
        return 'اضغط لتقييم زيارتك';
      case 'apptTimeLabel':
        return 'وقت الموعد';
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
      case 'commonCancel':
        return 'إلغاء';
      case 'commonDelete':
        return 'حذف';
      case 'confirmButton':
        return 'تأكيد';
      case 'contactClinic':
        return 'تواصل مع العيادة';
      case 'contactNumberHint':
        return 'رقم التواصل';
      case 'continueLabel':
        return 'متابعة';
      case 'dayFriday':
        return 'الجمعة';
      case 'dayMonday':
        return 'الإثنين';
      case 'daySaturday':
        return 'السبت';
      case 'daySunday':
        return 'الأحد';
      case 'dayThursday':
        return 'الخميس';
      case 'dayTuesday':
        return 'الثلاثاء';
      case 'dayWednesday':
        return 'الأربعاء';
      case 'distanceAway':
        return ({required Object distance}) => 'يبعد ${distance}';
      case 'doctorAddison':
        return 'Dr. Addison Smith';
      case 'doctorBalestra':
        return 'Dr. Balestra';
      case 'doctorBennett':
        return 'Dr. Bennett Mccoy';
      case 'doctorCrownover':
        return 'Dr. Crownover';
      case 'doctorDetailsTitle':
        return 'بيانات الطبيب';
      case 'doctorFillerup':
        return 'Dr. Fillerup Grab';
      case 'doctorNotFound':
        return 'لم يتم العثور على الطبيب';
      case 'doctorShruti':
        return 'Dr. Shruti Kedia';
      case 'doctorWatamaniuk':
        return 'Dr. Watamaniuk';
      case 'doneButton':
        return 'تم';
      case 'drawerAppointments':
        return 'مواعيدي';
      case 'drawerLogout':
        return 'تسجيل الخروج';
      case 'drawerLogoutConfirmBody':
        return 'ستحتاج إلى تسجيل الدخول مرة أخرى لحجز المواعيد.';
      case 'drawerLogoutConfirmTitle':
        return 'تسجيل الخروج؟';
      case 'drawerOpenMenu':
        return 'فتح القائمة';
      case 'drawerSettings':
        return 'الإعدادات';
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
      case 'favoriteDoctorsTitle':
        return 'الأطباء المفضّلون';
      case 'favoritesEmptyBody':
        return 'اضغط على القلب لدى أي طبيب لحفظه هنا.';
      case 'favoritesEmptyTitle':
        return 'لا توجد مفضّلات بعد';
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
      case 'mapAttribution':
        return 'مساهمو OpenStreetMap';
      case 'morningPeriod':
        return 'صباحًا';
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
      case 'patientFallbackName':
        return 'مستخدم مريض';
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
      case 'personalInformation':
        return 'المعلومات الشخصية';
      case 'phoneInvalid':
        return 'أدخل رقم هاتف صحيح';
      case 'popularDoctorsTitle':
        return 'أطباء مشهورون';
      case 'previousMonth':
        return 'الشهر السابق';
      case 'privacyPolicyBullet1':
        return 'الجزء القياسي من لوريم إيبسوم المستخدم منذ القرن الخامس عشر معاد إنتاجه أدناه لمن يرغب بالاطلاع.';
      case 'privacyPolicyBullet2':
        return 'كما أُعيد إنتاج القسمين 1.10.32 و1.10.33 من كتاب شيشرون بصيغتهما الأصلية تمامًا.';
      case 'privacyPolicyBullet3':
        return 'لوريم إيبسوم هو ببساطة نص شكلي يُستخدم في صناعة الطباعة والتنضيد وظلّ المعيار منذ ذلك الحين.';
      case 'privacyPolicyBullet4':
        return 'الهدف من استخدام لوريم إيبسوم أنه يوفّر توزيعًا طبيعيًا تقريبًا للأحرف بعكس النص المقروء.';
      case 'privacyPolicyHeading':
        return 'سياسة خصوصية تطبيق Doctor Hunt';
      case 'privacyPolicyIntro':
        return 'توجد صيغ عديدة من نصوص لوريم إيبسوم، لكن غالبيتها خضعت لتعديل بشكل أو بآخر عبر إقحام فقرات هزلية أو كلمات عشوائية لا تبدو مقنعة. من الحقائق الثابتة منذ زمن طويل أن القارئ ينشغل بالمحتوى المقروء للصفحة عند النظر إلى تخطيطها. والهدف من استخدام لوريم إيبسوم أنه يوفّر توزيعًا طبيعيًا تقريبًا للأحرف.';
      case 'privacyPolicyOutro':
        return 'من الحقائق الثابتة منذ زمن طويل أن القارئ ينشغل بالمحتوى المقروء للصفحة عند النظر إلى تخطيطها، مع استخدام لوريم إيبسوم كنص بديل إلى حين توفّر النص النهائي.';
      case 'privacyPolicyTitle':
        return 'سياسة الخصوصية';
      case 'profileUpdated':
        return 'تم تحديث الملف الشخصي';
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
      case 'resendCodeButton':
        return 'إعادة إرسال الرمز';
      case 'resendCodeCountdown':
        return ({required Object seconds}) =>
            'إعادة الإرسال خلال ${seconds} ثانية';
      case 'resendCodeQuestion':
        return 'لم يصلك الرمز؟';
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
      case 'seedAdminEmail':
        return 'admin@doctorhunt.com';
      case 'seedAdminName':
        return 'Ahmed Khaled';
      case 'seedClinicLocation':
        return 'Central Clinic · 24 Garden Avenue';
      case 'seedPatientDanielKim':
        return 'Daniel Kim';
      case 'seedPatientEthanBrooks':
        return 'Ethan Brooks';
      case 'seedPatientJamesWilson':
        return 'James Wilson';
      case 'seedPatientMayaPatel':
        return 'Maya Patel';
      case 'seedPatientOliviaMartin':
        return 'Olivia Martin';
      case 'seedPatientSophiaClark':
        return 'Sophia Clark';
      case 'seedReviewKind':
        return 'محترف ولطيف جدًا.';
      case 'seedReviewReassuring':
        return 'واضح ومطمئن.';
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
      case 'settingsAccountSection':
        return 'إعدادات الحساب';
      case 'settingsChangePassword':
        return 'تغيير كلمة المرور';
      case 'settingsLanguageArabic':
        return 'العربية';
      case 'settingsLanguageEnglish':
        return 'English';
      case 'settingsLanguageTitle':
        return 'اختر اللغة';
      case 'settingsLanguages':
        return 'اللغة';
      case 'settingsMoreSection':
        return 'خيارات أخرى';
      case 'settingsNotifications':
        return 'الإشعارات';
      case 'settingsPrivacyPolicy':
        return 'سياسة الخصوصية';
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
      case 'statRating':
        return 'التقييم';
      case 'statReviews':
        return 'التقييمات';
      case 'statSatisfaction':
        return 'الرضا';
      case 'tabAppointments':
        return 'المواعيد';
      case 'tabBook':
        return 'الحجز';
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
        return 'أدخل الرمز المكوّن من ٦ أرقام الذي وصلك على بريدك الإلكتروني.';
      case 'verifyCodeTitle':
        return 'أدخل الرمز المكوّن من ٦ أرقام';
      case 'whoIsPatientTitle':
        return 'من هو المريض؟';
      default:
        return null;
    }
  }
}
