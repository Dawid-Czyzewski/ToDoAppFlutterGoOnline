const String kDatabaseName = 'tasks.db';
const int kDatabaseVersion = 1;
const String kTableTasks = 'tasks';
const String kColId = 'id';
const String kColTitle = 'title';
const String kColDescription = 'description';
const String kColDeadline = 'deadline';
const String kColIsDone = 'isDone';

const String kCreateTasksTable = '''
  CREATE TABLE $kTableTasks (
    $kColId INTEGER PRIMARY KEY AUTOINCREMENT,
    $kColTitle TEXT NOT NULL,
    $kColDescription TEXT,
    $kColDeadline TEXT NOT NULL,
    $kColIsDone INTEGER NOT NULL
  )
''';