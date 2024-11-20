enum SelectedTab {
  search,
  home,
  setting,
}

enum APIResultType {
  EMPTY,
  LOADING,
  SUCCESS,
  CACHE_SUCCESS,
  FAILURE,
  SESSION_EXPIRED,
  NO_INTERNET,
  BAD_REQUEST,
  UNAUTHORISED,
  CACHEERROR,
  NOTFOUND,
}

enum NetworkResultType {
  SUCCESS,
  CACHE_SUCCESS,
  ERROR,
  ERROR422,
  CACHEERROR,
  NO_INTERNET,
  BAD_REQUEST,
  UNAUTHORISED,
  NOTFOUND,
  LOADING,
}

enum ImageType {
  local,
  network,
}

enum AppThemesType {
  light,
  dark,
}

enum FontSizeType {
  small(0.9),
  normal(1.0),
  large(1.1);

  final num value;

  const FontSizeType(this.value);
}

// enum FontStyleType {Inter, Montserrat, Lato, Dancing, Caveat }
enum FontStyleType { BricolageGrotesque, HelveticaNowText }

enum ToastLength { longth, short }

enum ToastDisplayGravity { bottom, top, center }

enum KeyStatType { withPercentage, withoutPercentage }

enum AuthFlow { signUp, login }

enum MyAppEnum { paris, berlin, somewhereElse, male, female, non_Binary }

enum InputTypes { textField, radio, checkbox }

enum NotificationType {
  messageRequest,
  activityInvitation,
  participationConfirmed,
  messageConfirmed,
  activityRequest,
  newFriendRequest
}

enum HomeFilterType { nationality, age, gender, language, interest, none }

enum ActivityRequestType { join, sent, joined, received, myActivityRequest }

enum ActivityFilterType {
  activityType,
  venueType,
  gender,
  language,
  age,
  dateTime,
  distance,
  cost,
  none
}

enum ComeFrom { none, edit, review }
