class Socrbase < ActiveRecord::Base
  self.table_name = "socrbase"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])

end
