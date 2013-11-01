class Kladr < ActiveRecord::Base
  self.table_name = "kladr"
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

  def parent
    if code =~ /^\d{2}0*$/
      nil
    elsif (code =~ /^\d{5}0*$/) || (code =~ /^\d{2}000\d{3}0*$/) || (code =~ /^\d{2}000000\d{3}0*$/)
      Kladr.where("code LIKE ?", "#{code[0..1]}00000000000").first
    elsif (code =~ /^\d{8}0*$/) || (code =~ /^\d{5}000\d{3}0*$/)
      Kladr.where("code LIKE ?", "#{code[0..4]}00000000").first
    elsif (code =~ /^\d{11}0*$/)
      Kladr.where("code LIKE ?", "#{code[0..7]}00000").first
    end
  end

  def parents
    parent = self.parent
    while !parent.nil? do
      parents = [parent] + (parents || [])
      parent = parent.parent
    end
    parents || []
  end

  # TODO заменить на отношения 1 ко многим
  def street
    Street.where("code LIKE ?", "#{code[0..10]}____00")
  end

  # TODO заменить на отношения 1 ко многим
  def doma
    Doma.where("code LIKE ?", "#{code[0..10]}0000____")
  end

  def level
    case code
    when /^\d{2}0*$/
      '1'
    when /^\d{5}0*$/
      '2'
    when /^\d{8}0*$/
      '3'
    when /^\d{11}0*$/
      '4'
    end
  end

  def title
    name + ' ' + VOCABULARY[level][socr]
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



# Посмотреть!!!
# http://railsapps.github.io/twitter-bootstrap-rails.html
# https://github.com/RailsApps/rails-bootstrap
# https://github.com/anjlab/bootstrap-rails/issues/53
# http://stackoverflow.com/questions/18371318/installing-bootstrap-3-on-rails-app
# https://github.com/anjlab/bootstrap-rails

# посмотреть видеоуроки
# https://www.google.ru/#newwindow=1&q=rails%204.0%20twitter%20bootstrap%203%20tutorial&safe=off&tbs=qdr:y

end
