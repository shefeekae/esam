
class UserSchemas {

   static const String forgetPasswordQuery = '''
mutation forgotPassword(\$userDetails: JSON) {
  forgotPassword(userDetails: \$userDetails)
}
''';
  
}