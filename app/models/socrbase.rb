class Socrbase < ActiveRecord::Base
  self.table_name = "socrbase"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])

  def self.vocabulary
    socrs = Socrbase.all
    levels = socrs.map(&:level).uniq #=> ["1", "2", "3", "4", "5", "6"]
    hash = Hash[levels.map {|v| [v,{}]}] #=> {"1"=>{}, "2"=>{}, "3"=>{}, "4"=>{}, "5"=>{}, "6"=>{}}
    socrs.each{|record| hash[record.level].merge!({record.scname => record.socrname}) }
    hash
  end
end
