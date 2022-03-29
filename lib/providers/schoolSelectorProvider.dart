import 'package:tumble/models/school.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/resources/database/repository/scheduleRepository.dart';
import 'package:tumble/util/school_enum.dart';

import '../service_locator.dart';

class SchoolSelectorProvider {
  static final schools = [
    School(
      schoolId: SchoolEnum.hkr,
      schoolName: 'Kristianstad University',
      schoolLogo: 'assets/school_logos/hkr_logo.png',
    ),
    School(
      schoolId: SchoolEnum.mau,
      schoolName: 'Malmö University',
      schoolLogo: 'assets/school_logos/mau_logo.png',
    ),
    School(
      schoolId: SchoolEnum.oru,
      schoolName: 'Örebro University',
      schoolLogo: 'assets/school_logos/oru_logo.png',
    ),
    // School(
    //   schoolId: SchoolEnum.ltu,
    //   schoolName: 'Luleå University of Technology',
    //   schoolLogo: 'assets/school_logos/ltu_logo.png',
    // ),~
    School(
      schoolId: SchoolEnum.hig,
      schoolName: 'Högskolan i Gävle',
      schoolLogo: 'assets/school_logos/hig_logo.png',
    ),
    // School(
    //   schoolId: SchoolEnum.sh,
    //   schoolName: 'Södertörns Högskola',
    //   schoolLogo: 'assets/school_logos/sh_logo.png',
    // ),
    School(
      schoolId: SchoolEnum.hv,
      schoolName: 'Högskolan Väst',
      schoolLogo: 'assets/school_logos/hv_logo.png',
    ),
    School(
      schoolId: SchoolEnum.hb,
      schoolName: 'Högskolan i Borås',
      schoolLogo: 'assets/school_logos/hb_logo.png',
    ),
    School(
      schoolId: SchoolEnum.mdh,
      schoolName: 'Mälardalen Högskola',
      schoolLogo: 'assets/school_logos/mdh_logo.png',
    ),
  ];

  static bool schoolSelected() {
    // Read preference default school
    return getDefaultSchool() != null;
  }

  static void setDefaultSchool(SchoolEnum school) {
    // Set preference default school
    if (getDefaultSchool() != null && school != getDefaultSchool()) {
      ScheduleRepository.deleteAllSchedules();
    }
    locator<PreferenceDTO>().defaultSchool = school;
  }

  static SchoolEnum? getDefaultSchool() {
    SchoolEnum? defaultSchool = locator<PreferenceDTO>().defaultSchool;
    if (defaultSchool == null) {
      return null;
    }
    return defaultSchool;
  }
}
