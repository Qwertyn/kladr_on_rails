class Street < ActiveRecord::Base
  self.table_name = "STREET"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])

  def doma
    Doma.where("code LIKE ?", "#{code[0..14]}____")
  end
end
