import 'package:tumble/models/school.dart';
import 'package:tumble/providers/scheduleAPI.dart';
import 'package:tumble/service_locator.dart';
import 'package:tumble/util/school_enum.dart';

import '../resources/database/db/localStorageAPI.dart';

class SchoolSelectorProvider {
  static final _localStorageService = locator<LocalStorageService>();
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
    // ),
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
    return _localStorageService.getSchoolDefault() != "" &&
        _localStorageService.getSchoolDefault() != "null";
  }

  static void setDefaultSchool(SchoolEnum school) {
    if (getDefaultSchool() != null && school != getDefaultSchool()) {
      ScheduleApi.setFavorite("");
    }

    _localStorageService.setSchoolDefault(school);
  }

  static SchoolEnum? getDefaultSchool() {
    String defaultSchool = _localStorageService.getSchoolDefault();

    if (defaultSchool == "" || defaultSchool == "null") {
      return null;
    }

    return SchoolEnum.values.byName(defaultSchool);
  }
}
