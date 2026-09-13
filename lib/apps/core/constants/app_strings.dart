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

  /// Placeholder label for a not-yet-built tab, e.g. `"Home screen"`.
  static String tabPlaceholder(String title) => '$title screen';

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
