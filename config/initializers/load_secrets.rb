#Load the shared secred for the SOCK API
API_SECRET = YAML.load_file("#{Rails.root.to_s}/config/secrets.yml")