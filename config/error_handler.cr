Lucky::ErrorHandler.configure do |settings|
  settings.show_debug_output = Lucky::Env.development?
end
