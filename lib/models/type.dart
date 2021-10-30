import 'package:flutter/foundation.dart';

enum Type {
   firstName,
   lastName,
   email,
   phoneNumber,
   biography
}

extension SelectedType on Type {
   String get name => describeEnum(this);

   String get displayTitle {
      switch (this) {
         case Type.firstName:
            return 'First Name';
         case Type.lastName:
            return 'Last Name';
         case Type.email:
            return 'Email Address';
         case Type.phoneNumber:
            return 'Phone Number';
         case Type.biography:
            return 'Biography';
         default:
            return 'SelectedType is null';
      }
   }
}