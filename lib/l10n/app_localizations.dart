import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get accountSettings;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all data. This action cannot be undone.\n\nPlease enter your password to confirm:'**
  String get deleteAccountWarning;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @permanentlyDeleteWarning.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account and all data'**
  String get permanentlyDeleteWarning;

  /// No description provided for @hidePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Hide Phone Number'**
  String get hidePhoneNumber;

  /// No description provided for @hidePhoneNumberSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your number private in public posts'**
  String get hidePhoneNumberSubtitle;

  /// No description provided for @hideExactLocation.
  ///
  /// In en, this message translates to:
  /// **'Hide Exact Location'**
  String get hideExactLocation;

  /// No description provided for @hideExactLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show only city/area not precise coordinates'**
  String get hideExactLocationSubtitle;

  /// No description provided for @postAnonymously.
  ///
  /// In en, this message translates to:
  /// **'Post Anonymously'**
  String get postAnonymously;

  /// No description provided for @postAnonymouslySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hide your identity when creating reports'**
  String get postAnonymouslySubtitle;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your account password'**
  String get changePasswordSubtitle;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive updates on your reports'**
  String get pushNotificationsSubtitle;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @emailNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get reports via email'**
  String get emailNotificationsSubtitle;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help from our team'**
  String get contactUsSubtitle;

  /// No description provided for @reportAbuse.
  ///
  /// In en, this message translates to:
  /// **'Report Abuse'**
  String get reportAbuse;

  /// No description provided for @reportAbuseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report suspicious activity'**
  String get reportAbuseSubtitle;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @supportAndLegal.
  ///
  /// In en, this message translates to:
  /// **'Support & Legal'**
  String get supportAndLegal;

  /// No description provided for @activeSession.
  ///
  /// In en, this message translates to:
  /// **'Active Session'**
  String get activeSession;

  /// No description provided for @twoActiveDevices.
  ///
  /// In en, this message translates to:
  /// **'two active devices'**
  String get twoActiveDevices;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @endCurrentSession.
  ///
  /// In en, this message translates to:
  /// **'End your current session'**
  String get endCurrentSession;

  /// No description provided for @logoutAllDevices.
  ///
  /// In en, this message translates to:
  /// **'Logout All Devices'**
  String get logoutAllDevices;

  /// No description provided for @logoutAllConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will log you out of all devices. You will need to sign in again.'**
  String get logoutAllConfirm;

  /// No description provided for @logoutAllBtn.
  ///
  /// In en, this message translates to:
  /// **'Logout All'**
  String get logoutAllBtn;

  /// No description provided for @noActiveSessions.
  ///
  /// In en, this message translates to:
  /// **'No active sessions found.'**
  String get noActiveSessions;

  /// No description provided for @activeSessions.
  ///
  /// In en, this message translates to:
  /// **'Active Sessions'**
  String get activeSessions;

  /// No description provided for @lastActive.
  ///
  /// In en, this message translates to:
  /// **'Last Active'**
  String get lastActive;

  /// No description provided for @currentSession.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get currentSession;

  /// No description provided for @updatePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your account password'**
  String get updatePasswordSubtitle;

  /// No description provided for @manageActiveDevices.
  ///
  /// In en, this message translates to:
  /// **'Manage your active devices'**
  String get manageActiveDevices;

  /// No description provided for @secureAccountEverywhere.
  ///
  /// In en, this message translates to:
  /// **'Sign out from all devices at once'**
  String get secureAccountEverywhere;

  /// No description provided for @matchFound.
  ///
  /// In en, this message translates to:
  /// **'Match Found'**
  String get matchFound;

  /// No description provided for @matchFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified when potential matches are found'**
  String get matchFoundSubtitle;

  /// No description provided for @commentsOnMyReport.
  ///
  /// In en, this message translates to:
  /// **'Comments On My Report'**
  String get commentsOnMyReport;

  /// No description provided for @commentsOnMyReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Updates when someone responds your post'**
  String get commentsOnMyReportSubtitle;

  /// No description provided for @generalUpdates.
  ///
  /// In en, this message translates to:
  /// **'General Updates'**
  String get generalUpdates;

  /// No description provided for @generalUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Platform news and community updates'**
  String get generalUpdatesSubtitle;

  /// No description provided for @smsNotification.
  ///
  /// In en, this message translates to:
  /// **'SMS Notification'**
  String get smsNotification;

  /// No description provided for @smsNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive important alerts via text message'**
  String get smsNotificationSubtitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @editProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change your name, email or avatar'**
  String get editProfileSubtitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @myReports.
  ///
  /// In en, this message translates to:
  /// **'My Reports'**
  String get myReports;

  /// No description provided for @noReportsFound.
  ///
  /// In en, this message translates to:
  /// **'No reports found.'**
  String get noReportsFound;

  /// No description provided for @messagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTitle;

  /// No description provided for @noActiveChats.
  ///
  /// In en, this message translates to:
  /// **'No active chats.'**
  String get noActiveChats;

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get unknownUser;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet.'**
  String get noMessagesYet;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message.....'**
  String get typeMessageHint;

  /// No description provided for @reportSubmittedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully! ✅'**
  String get reportSubmittedSuccess;

  /// No description provided for @reportItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Item'**
  String get reportItemTitle;

  /// No description provided for @iLostItem.
  ///
  /// In en, this message translates to:
  /// **'I lost item'**
  String get iLostItem;

  /// No description provided for @iFoundItem.
  ///
  /// In en, this message translates to:
  /// **'I found item'**
  String get iFoundItem;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people;

  /// No description provided for @itemType.
  ///
  /// In en, this message translates to:
  /// **'Item Type'**
  String get itemType;

  /// No description provided for @personType.
  ///
  /// In en, this message translates to:
  /// **'Person Type'**
  String get personType;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @describeItemHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the item in detail ....'**
  String get describeItemHint;

  /// No description provided for @descriptionValidation.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 10 characters'**
  String get descriptionValidation;

  /// No description provided for @includeIdentifiersWarning.
  ///
  /// In en, this message translates to:
  /// **'*Include unique identifiers to help verify the owner'**
  String get includeIdentifiersWarning;

  /// No description provided for @dateLost.
  ///
  /// In en, this message translates to:
  /// **'DATE Lost'**
  String get dateLost;

  /// No description provided for @dateFound.
  ///
  /// In en, this message translates to:
  /// **'DATE Found'**
  String get dateFound;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @whereLostHint.
  ///
  /// In en, this message translates to:
  /// **'Where did you lose it?'**
  String get whereLostHint;

  /// No description provided for @whereFoundHint.
  ///
  /// In en, this message translates to:
  /// **'Where did you find it?'**
  String get whereFoundHint;

  /// No description provided for @putLocationOnMap.
  ///
  /// In en, this message translates to:
  /// **'Put location on map'**
  String get putLocationOnMap;

  /// No description provided for @tapToSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Tap to select location'**
  String get tapToSelectLocation;

  /// No description provided for @addPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add Photos'**
  String get addPhotos;

  /// No description provided for @clickToUploadPhotos.
  ///
  /// In en, this message translates to:
  /// **'Click to upload photos'**
  String get clickToUploadPhotos;

  /// No description provided for @photoFormatWarning.
  ///
  /// In en, this message translates to:
  /// **'PNG, JPG up to 10MB'**
  String get photoFormatWarning;

  /// No description provided for @submitReport.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile Updated Successfully! ✅'**
  String get profileUpdatedSuccess;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @cityGovernorate.
  ///
  /// In en, this message translates to:
  /// **'City / Governorate'**
  String get cityGovernorate;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'save changes'**
  String get saveChanges;

  /// No description provided for @profileInformation.
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInformation;

  /// No description provided for @profilePicture.
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profilePicture;

  /// No description provided for @passwordUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully 🎉'**
  String get passwordUpdatedSuccess;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUsTitle;

  /// No description provided for @messageSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message Sent ✅'**
  String get messageSentSuccess;

  /// No description provided for @contactUsPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.'**
  String get contactUsPageSubtitle;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @subjectHint.
  ///
  /// In en, this message translates to:
  /// **'Subject...'**
  String get subjectHint;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How Can We Help..?'**
  String get howCanWeHelp;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @reportAbuseTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Abuse'**
  String get reportAbuseTitle;

  /// No description provided for @reportAbusePageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us keep the community safe. Report any suspicious activity, fake reports, or harassment.'**
  String get reportAbusePageSubtitle;

  /// No description provided for @enterReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your reason for report...'**
  String get enterReasonHint;

  /// No description provided for @describeIssueHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue'**
  String get describeIssueHint;

  /// No description provided for @fakeSpamReport.
  ///
  /// In en, this message translates to:
  /// **'Fake / Spam report'**
  String get fakeSpamReport;

  /// No description provided for @scamFraud.
  ///
  /// In en, this message translates to:
  /// **'Scam / Fraud'**
  String get scamFraud;

  /// No description provided for @inappropriateContent.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate Content'**
  String get inappropriateContent;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @privacyIntro.
  ///
  /// In en, this message translates to:
  /// **'At Wasst Kheir, we take your privacy seriously. This policy describes how we collect, use, and protect your personal information.'**
  String get privacyIntro;

  /// No description provided for @infoCollectTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Information We Collect'**
  String get infoCollectTitle;

  /// No description provided for @infoCollectBody.
  ///
  /// In en, this message translates to:
  /// **'We collect information you provide directly to us such as your name, email, and photos.'**
  String get infoCollectBody;

  /// No description provided for @howUseDataTitle.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use Data'**
  String get howUseDataTitle;

  /// No description provided for @howUseDataBody.
  ///
  /// In en, this message translates to:
  /// **'Your data is used to improve our services and help match lost and found items.'**
  String get howUseDataBody;

  /// No description provided for @locationDataTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Location Data'**
  String get locationDataTitle;

  /// No description provided for @locationDataBody.
  ///
  /// In en, this message translates to:
  /// **'We use GPS data to show items near you. You can disable this anytime.'**
  String get locationDataBody;

  /// No description provided for @termsConditionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditionsTitle;

  /// No description provided for @termsIntro.
  ///
  /// In en, this message translates to:
  /// **'Help us keep Wasset Kheir a safe and helpful community for everyone.'**
  String get termsIntro;

  /// No description provided for @beHonestTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Be Honest'**
  String get beHonestTitle;

  /// No description provided for @beHonestBody.
  ///
  /// In en, this message translates to:
  /// **'Only report items you have actually lost or found. False reports waste community time and resources.'**
  String get beHonestBody;

  /// No description provided for @respectPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Respect Privacy'**
  String get respectPrivacyTitle;

  /// No description provided for @respectPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'When posting photos, try to avoid capturing sensitive personal information of others.'**
  String get respectPrivacyBody;

  /// No description provided for @safeMeetupsTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Safe Meetups'**
  String get safeMeetupsTitle;

  /// No description provided for @safeMeetupsBody.
  ///
  /// In en, this message translates to:
  /// **'When returning items, always meet in public, well-lit places. Bring a friend if possible.'**
  String get safeMeetupsBody;

  /// No description provided for @noHarassmentTitle.
  ///
  /// In en, this message translates to:
  /// **'4. No Harassment'**
  String get noHarassmentTitle;

  /// No description provided for @noHarassmentBody.
  ///
  /// In en, this message translates to:
  /// **'Treat all members with respect. Harassment, hate speech, or bullying will result in an immediate ban.'**
  String get noHarassmentBody;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All as Read'**
  String get markAllAsRead;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all data. This action cannot be undone.\n\nPlease enter your password to confirm:'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecified;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'dd/mm/yyyy'**
  String get dateFormat;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Report Lost Items'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_subtitle_1.
  ///
  /// In en, this message translates to:
  /// **'Quickly report lost items with photos \n and location details to increase your \n  chances of recovery'**
  String get onboarding_subtitle_1;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Find Found Items'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_subtitle_2.
  ///
  /// In en, this message translates to:
  /// **'Browse through found items in your\n area and help reunite people with \n their belongings'**
  String get onboarding_subtitle_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Smart Search & Map'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_subtitle_3.
  ///
  /// In en, this message translates to:
  /// **'Use our intelligent search and \n interactive map to locate items based \n  on location and description'**
  String get onboarding_subtitle_3;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @sign_in_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your Waslt Kheir account'**
  String get sign_in_subtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get email_hint;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get password_hint;

  /// No description provided for @forgot_password_q.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password_q;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account? '**
  String get dont_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @sign_up_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to start reporting and finding items'**
  String get sign_up_subtitle;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get date_of_birth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @select_gender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get select_gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @phone_number_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phone_number_hint;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have account? '**
  String get already_have_account;

  /// No description provided for @forgot_password_title.
  ///
  /// In en, this message translates to:
  /// **'Forgot password..?'**
  String get forgot_password_title;

  /// No description provided for @forgot_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to reset your password.'**
  String get forgot_password_subtitle;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @we_send_otp_to_email.
  ///
  /// In en, this message translates to:
  /// **'we\'ll send a one-time code to this email'**
  String get we_send_otp_to_email;

  /// No description provided for @send_reset_code.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Code'**
  String get send_reset_code;

  /// No description provided for @back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back To Login'**
  String get back_to_login;

  /// No description provided for @enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enter_verification_code;

  /// No description provided for @otp_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We have sent a 6 digit code to your email.\nEnter the code we send you.'**
  String get otp_subtitle;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// No description provided for @verify_code.
  ///
  /// In en, this message translates to:
  /// **'Verify the Code'**
  String get verify_code;

  /// No description provided for @check_your_email.
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get check_your_email;

  /// No description provided for @reset_link_sent_email.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to {email}.'**
  String reset_link_sent_email(Object email);

  /// No description provided for @reset_code_sent_email.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset code to {email}.'**
  String reset_code_sent_email(Object email);

  /// No description provided for @reset_link_success.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent successfully!'**
  String get reset_link_success;

  /// No description provided for @enter_otp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enter_otp;

  /// No description provided for @connecting_lost_souls.
  ///
  /// In en, this message translates to:
  /// **'Connecting Lost Souls'**
  String get connecting_lost_souls;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search items, locations...'**
  String get search_hint;

  /// No description provided for @lost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lost;

  /// No description provided for @found.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get found;

  /// No description provided for @no_posts_found.
  ///
  /// In en, this message translates to:
  /// **'No posts found'**
  String get no_posts_found;

  /// No description provided for @ai_scanning.
  ///
  /// In en, this message translates to:
  /// **'AI Scanning'**
  String get ai_scanning;

  /// No description provided for @open_camera.
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get open_camera;

  /// No description provided for @opening_camera.
  ///
  /// In en, this message translates to:
  /// **'Opening camera...'**
  String get opening_camera;

  /// No description provided for @images_count.
  ///
  /// In en, this message translates to:
  /// **'Images ({count})'**
  String images_count(Object count);

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @location_not_specified.
  ///
  /// In en, this message translates to:
  /// **'Location not specified'**
  String get location_not_specified;

  /// No description provided for @reported_on.
  ///
  /// In en, this message translates to:
  /// **'Reported on {date}'**
  String reported_on(Object date);

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @location_on_map.
  ///
  /// In en, this message translates to:
  /// **'Location on Map'**
  String get location_on_map;

  /// No description provided for @reported_by.
  ///
  /// In en, this message translates to:
  /// **'Reported by'**
  String get reported_by;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @mark_found.
  ///
  /// In en, this message translates to:
  /// **'Mark Found'**
  String get mark_found;

  /// No description provided for @marked_found_btn.
  ///
  /// In en, this message translates to:
  /// **'Found ✓'**
  String get marked_found_btn;

  /// No description provided for @marked_found_success.
  ///
  /// In en, this message translates to:
  /// **'Marked as found!'**
  String get marked_found_success;

  /// No description provided for @map_view.
  ///
  /// In en, this message translates to:
  /// **'Map View'**
  String get map_view;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
