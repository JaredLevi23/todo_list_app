/*
 *  Database table structure
 */

enum Tables{
  todos
}


class DBTables {

  static const String todoTable = '''
    CREATE TABLE IF NOT EXISTS todos(
          id TEXT primary key,
          description TEXT,
          dateTime TEXT,
          path TEXT,
          isCompleted INTEGER
        )
  ''';

}