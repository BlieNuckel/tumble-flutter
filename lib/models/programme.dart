class Program {
  final String programName;
  final String programId;

  Program({required this.programName, required this.programId});

  factory Program.fromJson(dynamic programObject) {
    return Program(
      programName: programObject['scheduleName'] as String,
      programId: programObject['scheduleId'] as String,
    );
  }
}
