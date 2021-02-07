database_name = "websocket_#{Lucky::Env.name}"

AppDatabase.configure do |settings|
  settings.credentials = Avram::Credentials.void
end

Avram.configure do |settings|
  settings.database_to_migrate = UnusedDB

  # In production, allow lazy loading (N+1).
  # In development and test, raise an error if you forget to preload associations
  # settings.lazy_load_enabled = Lucky::Env.production?
end
