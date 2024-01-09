import 'database_helper.dart';

// Function to insert initial dummy users if the table is empty
Future<void> insertInitialUsers() async {
  // Check if any users exist in the database
  List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();

  if (users.isEmpty) {
    // If no users exist, insert some initial users
    await DatabaseHelper().insertUser({
      'email': 'user1@user.com',
      'password': 'password1',
      'name': 'Name1',
      'surname': 'Surname1',
      'dateofbirth': DateTime(2002, 11, 11).toIso8601String(),
      'bio': 'boo boo emm memm'
    });
    // Insert other dummy users as needed
  }
}
