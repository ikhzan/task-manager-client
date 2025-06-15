class Config {
  static const String apiBaseUrl = "http://192.168.1.47:3000";
  static const String authEndpoint = "$apiBaseUrl/auth";
  static const String tasksEndpoint = "$apiBaseUrl/tasks";
  static const String teamsEndpoint = "$apiBaseUrl/teams";
  static const String usersEndpoint = "$apiBaseUrl/users";

  // Authentication Keys (if needed)
  static const String apiKey = "your-api-key";

  // Debug Mode
  static const bool debugMode = true;

}