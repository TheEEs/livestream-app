class AppDatabase < Avram::Database
end

class UnusedDB < Avram::Database
  configure do |settings|
    settings.credentials = Avram::Credentials.void
  end
end
