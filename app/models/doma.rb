class Doma < ActiveRecord::Base
  self.table_name = "DOMA"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])
end
