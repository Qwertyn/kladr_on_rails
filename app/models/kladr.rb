class Kladr < ActiveRecord::Base
  self.table_name = "KLADR"
  establish_connection(YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))['kladr'])

  # СС РРР ГГГ ППП АА
  # SS RRR GGG PPP AA

  # выборка регионов (первый уровень иерархии) подумать как по-другому
  # scope :regions, where("code REGEXP ?", "^[[:digit:]][[:digit:]]+00000000000")
  # scope :regions, where("code LIKE ?", "__00000000000")
  # scope :regions, select{ |region| region.code[2..12] == "00000000000"}

  def self.regions
    where("code LIKE ?", "__00000000000")
  end


  def entity_level_1
    # тут тока из таблицы кладр
  end

  def entity_level_2
    # тут тока из таблицы кладр (наверно)
  end

  def entity_level_3
    # а тут прибавить ещё и записи из Улицыи
  end



  # TODO как-то сделать по-человечески
  def children
    case code
    when /^\d{2}0*$/
      parent_code = code[0..1]
      Kladr.where("code != ? AND (code LIKE ? OR code LIKE ? OR code LIKE ?)",
        "#{parent_code}00000000000", "#{parent_code}___00000000", "#{parent_code}000___00000", "#{parent_code}000000___00")
    when /^\d{5}0*$/
      parent_code = code[0..4]
      Kladr.where("code != ? AND (code LIKE ? OR code LIKE ?)",
        "#{parent_code}00000000", "#{parent_code}___00000", "#{parent_code}000___00")
    when /^\d{8}0*$/
      parent_code = code[0..7]
      Kladr.where("code != ? AND code LIKE ?",
        "#{parent_code}00000", "#{parent_code}___00")
    end
  end

  # TODO заменить на отношения 1 ко многим
  def street
    Street.where("code LIKE ?", "#{code[0..10]}____00")
  end

  # TODO заменить на отношения 1 ко многим
  def doma
    Doma.where("code LIKE ?", "#{code[0..10]}0000____")
  end


  # вот как-то так надо, но пока не получилось
  # has_many :street, :class_name => 'Street', :conditions => '( STREET.code LIKE ? = "#{code[0..10]}____00"'



  # TODO потом перенести чтобы был виден и другим моделям
  # возможно и не нужен ужеы
  # def parent_code #(code)
    # case code
    # when /^\d{2}0*$/
      # code[0..1]
    # when /^\d{5}0*$/
      # code[0..4]
    # when /^\d{8}0*$/
      # code[0..7]
    # when /^\d{11}0*$/
      # code[0..10]
    # end
  # end


end
