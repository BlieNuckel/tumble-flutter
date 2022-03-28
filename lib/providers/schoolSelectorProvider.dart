import 'package:tumble/models/school.dart';
import 'package:tumble/models/user_preference_dto.dart';
import 'package:tumble/resources/database/repository/preferenceRepository.dart';
import 'package:tumble/resources/database/repository/scheduleRepository.dart';
import 'package:tumble/util/school_enum.dart';

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

  static Future<bool> schoolSelected() async {
    // Read preference default school
    return await getDefaultSchool() != null;
  }

  static void setDefaultSchool(SchoolEnum school) async {
    // Set preference default school
    if (await getDefaultSchool() != null && school != await getDefaultSchool()) {
      ScheduleRepository.deleteAllSchedules();
    }
    PreferenceRepository.updatePreferences(PreferenceDTO(defaultSchool: school.name));
  }

  static Future<SchoolEnum?> getDefaultSchool() async {
    PreferenceDTO? preferenceDTO = await PreferenceRepository.getPreferences();
    String? defaultSchool = preferenceDTO?.defaultSchool;

    if (defaultSchool == "" || defaultSchool == "null" || defaultSchool == null) {
      return null;
    }

    return SchoolEnum.values.byName(defaultSchool);
  }
}
