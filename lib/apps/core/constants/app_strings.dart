/// Central registry of every user-facing string.
///
/// Nothing user-visible should be inlined in widgets — reference these instead.
abstract final class AppStrings {
  AppStrings._();

  // ── App ───────────────────────────────────────────────────────────────────
  static const String appName = 'Doctor Hunt';

  // ── Common actions ────────────────────────────────────────────────────────
  static const String next = 'Next';
  static const String getStarted = 'Get Started';
  static const String skip = 'Skip';
  static const String continueLabel = 'Continue';

  // ── Onboarding ────────────────────────────────────────────────────────────
  static const String onboardingTitle1 = 'Find Trusted Doctors';
  static const String onboardingTitle2 = 'Choose Best Doctors';
  static const String onboardingTitle3 = 'Easy Appointments';
  static const String onboardingSubtitle =
      'Contrary to popular belief, Lorem Ipsum is not simply random text. '
      'It has roots in a piece of it over 2000 years old.';

  // ── Choose role ───────────────────────────────────────────────────────────
  static const String chooseRoleTitle = 'Choose your role';
  static const String chooseRoleSubtitle =
      'The selected role determines the experience and available features.';
  static const String rolePatient = 'Patient';
  static const String rolePatientDescription =
      'Find doctors, book appointments, and manage your medical records.';
  static const String roleAdmin = 'Admin';
  static const String roleAdminDescription =
      'Manage doctors, appointments, users, and the platform.';

  // ── Auth — shared ─────────────────────────────────────────────────────────
  static const String authSubtitle =
      'You can search course, apply course and find scholarship '
      'for abroad studies';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String nameHint = 'Name';
  static const String nameFieldLabel = 'your name';
  static const String socialGoogle = 'Google';
  static const String socialFacebook = 'Facebook';

  // ── Login ─────────────────────────────────────────────────────────────────
  static const String loginTitle = 'Welcome back';
  static const String loginButton = 'Login';
  static const String forgotPassword = 'Forgot password';
  static const String loginSwitchPrefix = "Don't have an account? ";
  static const String loginSwitchAction = 'Join us';

  // ── Register ──────────────────────────────────────────────────────────────
  static const String registerTitle = 'Join us to start searching';
  static const String registerButton = 'Sign up';
  static const String registerSwitchPrefix = 'Have an account? ';
  static const String registerSwitchAction = 'Log in';
  static const String termsPrefix = 'I agree with the ';
  static const String termsAction = 'Terms of Service & Privacy Policy';
  static const String termsRequired = 'Please accept the terms to continue';

  // ── Password-recovery sheets ──────────────────────────────────────────────
  static const String forgotPasswordTitle = 'Forgot password';
  static const String forgotPasswordSubtitle =
      'Enter your email for the verification process, we will send '
      '4 digits code to your email.';
  static const String verifyCodeTitle = 'Enter 4 Digits Code';
  static const String verifyCodeSubtitle =
      'Enter the 4 digits code that you received on your email.';
  static const String resetPasswordTitle = 'Reset Password';
  static const String resetPasswordSubtitle =
      'Set the new password for your account so you can login and '
      'access all the features.';
  static const String newPasswordHint = 'New Password';
  static const String reenterPasswordHint = 'Re-enter Password';
  static const String updatePasswordButton = 'Update Password';

  // ── Bottom navigation ─────────────────────────────────────────────────────
  static const String tabHome = 'Home';
  static const String tabAppointments = 'Appointments';
  static const String tabChat = 'Chat';
  static const String tabProfile = 'Profile';
  static const String tabFavorites = 'Favorites';
  static const String tabBook = 'Book';
  static const String tabMap = 'Map';

  // ── Home ──────────────────────────────────────────────────────────────────
  static const String homeGreeting = 'Hi Handwerker!';
  static const String homeTitle = 'Find Your Doctor';
  static const String searchHint = 'Search.....';
  static const String popularDoctorsTitle = 'Popular Doctor';
  static const String featureDoctorsTitle = 'Feature Doctor';
  static const String seeAll = 'See all';
  static const String specialistFallback = 'Medicine Specialist';
  static const String perHourSuffix = '/ hours';
  static const String categoryDentist = 'Dentist';
  static const String categoryCardiologist = 'Cardiologist';
  static const String categoryOphthalmologist = 'Ophthalmologist';
  static const String categoryGastroenterologist = 'Gastroenterologist';
  static const String doctorFillerup = 'Dr. Fillerup Grab';
  static const String doctorCrick = 'Dr. Crick';
  static const String doctorStrain = 'Dr. Strain';
  static const String doctorLachinet = 'Dr. Lachinet';
  static const String doctorAddison = 'Dr. Addison Smith';
  static const String doctorBennett = 'Dr. Bennett Mccoy';

  /// Placeholder label for a not-yet-built tab, e.g. `"Home screen"`.
  static String tabPlaceholder(String title) => '$title screen';

  // ── Doctor details ─────────────────────────────────────────────────────
  static const String doctorDetailsTitle = 'Doctor Details';
  static const String bookNow = 'Book Now';
  static const String perHourShort = '/hr';
  static const String statRunningValue = '100';
  static const String statRunning = 'Running';
  static const String statOngoingValue = '500';
  static const String statOngoing = 'Ongoing';
  static const String statPatientValue = '700';
  static const String statPatient = 'Patient';
  static const String servicesTitle = 'Services';
  static const String servicePoint1 =
      'Patient care should be the number one priority.';
  static const String servicePoint2 =
      'If you run your practice you know how frustrating it can be when a '
      'patient misses an appointment.';
  static const String servicePoint3 =
      "That's why an appointment reminder system matters.";
  static const String mapClinic = 'KENYATTA HOSPITAL';
  static const String mapAttribution = 'OpenStreetMap contributors';
  static const String mapAreaWestlands = 'WESTLANDS';
  static const String mapAreaNairobi = 'Nairobi';
  static const String mapAreaUpperHill = 'UPPER HILL';
  static const String mapAreaKilimani = 'KILIMANI';
  static const String mapAreaParklands = 'Parklands';
  static const String mapAreaKariokor = 'KARIOKOR';
  static const String mapAreaPangani = 'PANGANI';
  static const String mapAreaHospital = 'Nairobi Hospital';
  static const String doctorNotFound = 'Doctor not found';
  static const String searchDoctors = 'Search doctors';
  static const String bookingUnavailable = 'Booking is not available yet.';

  /// Numbered list marker, e.g. `"1."` for the first service point.
  static String numberedItem(int index) => '${index + 1}.';

  // ── Booking ──────────────────────────────────────────────────────────
  static const String selectTimeTitle = 'Select Time';
  static const String todayLabel = 'Today';
  static const String tomorrowLabel = 'Tomorrow';
  static const String noSlotsAvailable = 'No slots available';
  static const String orLabel = 'OR';
  static const String contactClinic = 'Contact Clinic';
  static const String afternoonPeriod = 'Afternoon';
  static const String eveningPeriod = 'Evening';
  static const String bookingRequested = 'Appointment requested';

  static String oneSlotAvailable = '1 slot available';

  static String slotsAvailable(int count) => '$count slots available';

  static String periodSlots(String period, int count) => '$period $count slots';

  static String nextAvailabilityOn(String day) => 'Next availability on $day';

  /// "Book Now · 2 slots" — confirm label when several slots are chosen.
  static String bookNowWithCount(int count) =>
      '$bookNow · $count ${count == 1 ? 'slot' : 'slots'}';

  // ── Search ──────────────────────────────────────────────────────────
  static const String findDoctorsTitle = 'Find Doctors';
  static const String searchHintFull = 'Search doctors, specialties…';
  static const String experienceSuffix = 'Years experience';
  static const String nextAvailableLabel = 'Next Available';
  static const String noSearchResults = 'No doctors found';
  static const String noSearchResultsHint =
      'Try a different name or specialty.';
  static const String specialtyDentist = 'Teeth Dentist';

  static String experienceYears(int years) => '$years $experienceSuffix';

  static String patientStories(int count) => '$count Patient Stories';

  static String satisfactionPercent(int percent) => '$percent%';

  // ── Search — mock doctors (until the REST API is wired up) ────────────────
  static const String doctorShruti = 'Dr. Shruti Kedia';
  static const String doctorWatamaniuk = 'Dr. Watamaniuk';
  static const String doctorCrownover = 'Dr. Crownover';
  static const String doctorBalestra = 'Dr. Balestra';

  // ── Appointment ───────────────────────────────────────────────────────
  static const String appointmentTitle = 'Appointment';
  static const String appointmentForTitle = 'Appointment For';
  static const String patientNameHint = 'Patient Name';
  static const String contactNumberHint = 'Contact Number';
  static const String whoIsPatientTitle = 'Who is this patient?';
  static const String addPatient = 'Add';
  static const String mySelf = 'My Self';
  static const String myChild = 'My child';
  static const String appointmentConfirmed = 'Appointment confirmed';

  // ── Schedule (date / time / reminder) ─────────────────────────────────
  static const String availableTimeTitle = 'Available Time';
  static const String reminderTitle = 'Reminder Me Before';
  static const String confirmButton = 'Confirm';
  static const String childGirl = 'Child Girl';
  static const String nameTooShort = 'Enter at least 3 characters';
  static const String nameInvalid = 'Letters only, please';
  static const String phoneInvalid = 'Enter a valid phone number';

  /// "February 2021" — full month and year, for the calendar header.
  static String monthYear(DateTime date) =>
      '${monthFullNames[date.month - 1]} ${date.year}';

  static const List<String> monthFullNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// Weekday initials for the calendar's day header.
  static const List<String> weekdayInitials = [
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su',
  ];

  static const String todayLabelShort = 'Today';

  // ── Schedule — options ────────────────────────────────────────────────
  static const String previousMonth = 'Previous month';
  static const String nextMonth = 'Next month';

  /// "30 min" reminder chip label.
  static String reminderMinutes(int minutes) => '$minutes min';

  /// "02:00" — the schedule time chip's top line.
  static String slotTimeLabel(int hour24) {
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    return '${hour12.toString().padLeft(2, '0')}:00';
  }

  /// "PM" — the schedule time chip's second line.
  static String slotPeriodLabel(int hour24) => hour24 < 12 ? 'AM' : 'PM';

  /// Times offered on the schedule (24h, on the hour).
  static const List<int> scheduleHours = [10, 12, 14, 15, 16];

  /// Reminder lead times in minutes.
  static const List<int> reminderOptions = [30, 40, 25, 10, 35];

  /// "February 21" — month and day, for the confirmation sentence.
  static String monthDay(DateTime date) =>
      '${monthFullNames[date.month - 1]} ${date.day}';

  // ── Success dialog ─────────────────────────────────────────────────────
  static const String thankYou = 'Thank You !';
  static const String appointmentSuccessful = 'Your Appointment Successful';
  static const String doneButton = 'Done';
  static const String editAppointment = 'Edit your appointment';

  static String bookedWith({
    required String doctor,
    required String date,
    String time = '',
  }) => time.isEmpty
      ? 'You booked an appointment with $doctor on $date'
      : 'You booked an appointment with $doctor on $date, at $time';

  /// "2.4 km away" — caption on the clinic map card.
  static String distanceAway(String distance) => '$distance away';

  /// "23 Feb" — day and short month.
  static String shortDate(DateTime date) =>
      '${date.day} ${monthNames[date.month - 1]}';

  /// "Today, 23 Feb" / "Tomorrow, 24 Feb" / "Wed, 25 Feb".
  static String dateLabel(
    DateTime date, {
    bool isToday = false,
    bool isTomorrow = false,
  }) {
    final prefix = isToday
        ? todayLabel
        : isTomorrow
        ? tomorrowLabel
        : weekdayNames[date.weekday - 1];
    return '$prefix, ${shortDate(date)}';
  }

  /// "1:00 PM" / "1:30 PM" from a 24-hour hour + minute.
  static String slotLabel(int hour24, int minute) {
    final suffix = hour24 >= 12 ? 'PM' : 'AM';
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final mm = minute.toString().padLeft(2, '0');
    return '$hour12:$mm $suffix';
  }

  static const List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const String clinicFallback = 'Kenyatta National Hospital';

  // ── Validation messages ───────────────────────────────────────────────────
  static String fieldRequired(String label) => 'Enter $label';
  static const String emailRequired = 'Enter your email';
  static const String emailInvalid = 'Enter a valid email';
  static const String passwordRequired = 'Enter your password';

  static String passwordMinLength(int minLength) =>
      'Password must be at least $minLength characters';
  static const String reenterPasswordRequired = 'Re-enter your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';

  static String otpRequired(int length) => 'Enter the $length-digit code';
}
