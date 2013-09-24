class Kladr < ActiveRecord::Base
  self.table_name = "KLADR"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])
end
