class Street < ActiveRecord::Base
  self.table_name = "STREET"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])
end
