class Doma < ActiveRecord::Base
  self.table_name = "doma"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])
end
