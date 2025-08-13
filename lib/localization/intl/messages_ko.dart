// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(token) => "${token} 값을 삭제할 때 오류가 발생했습니다.";

  static String m1(token) => "앱 구성을 로드하는 동안 오류가 발생했습니다: ${token}";

  static String m2(token) => "${token} 값을 읽을 때 오류가 발생했습니다.";

  static String m3(token) => "값을 저장하는 동안 오류가 발생했습니다: ${token}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cacheExceptionTitle": MessageLookupByLibrary.simpleMessage(
      "장치의 정보에 액세스하는 동안 오류가 발생했습니다.",
    ),
    "certificateInvalidMessage": MessageLookupByLibrary.simpleMessage(
      "서버의 보안 인증서가 유효하지 않습니다.",
    ),
    "certificateInvalidTitle": MessageLookupByLibrary.simpleMessage("잘못된 인증서"),
    "deleteValueError": m0,
    "environmentExceptionMessage": m1,
    "environmentExceptionTitle": MessageLookupByLibrary.simpleMessage("환경 오류"),
    "formInvalidFailureTitle": MessageLookupByLibrary.simpleMessage("잘못된 양식"),
    "internetConnectionUnavailableMessage":
        MessageLookupByLibrary.simpleMessage("인터넷 연결을 확인하고 다시 시도하세요."),
    "internetConnectionUnavailableTitle": MessageLookupByLibrary.simpleMessage(
      "인터넷 연결 없음",
    ),
    "readValueError": m2,
    "requestBadMessage": MessageLookupByLibrary.simpleMessage(
      "서버로 전송된 매개변수가 올바르지 않습니다.",
    ),
    "requestBadTitle": MessageLookupByLibrary.simpleMessage("잘못된 요청"),
    "requestCanceledMessage": MessageLookupByLibrary.simpleMessage(
      "사용자가 요청을 취소했습니다.",
    ),
    "requestCanceledTitle": MessageLookupByLibrary.simpleMessage("청원 취소됨"),
    "saveValueError": m3,
    "serverUnderMantainanceTitle": MessageLookupByLibrary.simpleMessage(
      "서버가 점검 중입니다.",
    ),
    "sessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "세션이 만료되었습니다. 다시 로그인하세요.",
    ),
    "sessionExpiredTitle": MessageLookupByLibrary.simpleMessage("세션이 만료되었습니다."),
    "tryAgainLater": MessageLookupByLibrary.simpleMessage("나중에 다시 시도하세요."),
    "userUnauthorizedMessage": MessageLookupByLibrary.simpleMessage(
      "사용자에게 이 화면에 액세스할 수 있는 필수 권한이 없습니다.",
    ),
    "userUnauthorizedTitle": MessageLookupByLibrary.simpleMessage(
      "이 사용자에게는 화면에 액세스할 수 있는 권한이 없습니다.",
    ),
  };
}
