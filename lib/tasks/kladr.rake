require 'dbf'
require 'iconv'

# Переопределение метода DBF, чтобы проще создавать записи в таблицы
module DBF
  class Record
    def attributes
      # @attributes ||= Hash[@columns.map {|column| [column.name, init_attribute(column)]}]
      @attributes ||= Hash[@columns.map {|column| [column.underscored_name, init_attribute(column)]}]
    end
  end
end

module KLADR
  def self.init_data(model)
    puts "\n Загрузка записей для #{model} ..."
    table = DBF::Table.new("tmp/base/#{model.table_name}.DBF", nil, 'cp866')
    total = table.record_count
    start_time = Time.now
    k = 0

    table.each do |record|
      model.create(record.attributes)
      k += 1
      print "#{k} / #{total}  #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')} \r "
    end

    puts "Загружено записей: #{k} из #{total} \nЗатрачено времени: #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')}"
  end
end

namespace :kladr do


  desc "Скачивание БД КЛАДРа"
  task :download_kladr_db => [:environment]  do
    start_time = Time.now
    `curl -o tmp/base.7z http://gnivc.ru/html/gnivcsoft/KLADR/Base.7z`

    puts "Скачивание БД КЛАДРа завершено \nЗатрачено времени: #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')}"
  end

  desc "Разархивирование БД КЛАДРа"
  task :unzip_kladr_db => [:environment]  do
    puts "Произведите разархивирование БД КЛАДРа в ручном режиме"
    # TODO реализовать unzip разными утилитами
  end


  desc "Загрузка КЛАДРа"
  task :init_data, [:environment]  => [:define_schema_kladr_db, :init_data_kladr, :init_data_street, :init_data_doma, :init_data_socrbase]  do
    puts "Загрузка КЛАДРа прошла успешно"
  end


# Про DBF
# stackoverflow.com/questions/9395683/how-to-migrate-dbase-database-in-rails
# https://github.com/infused/dbf/blob/master/README.md

  desc "Определение схемы БД КЛАДРа"
  task :define_schema_kladr_db => [:environment]  do
    tables = %w[KLADR STREET DOMA SOCRBASE]
    tables.each do |table|
      t = DBF::Table.new("tmp/base/#{table}.DBF".downcase)
      eval(t.schema)
    end

    schema_indexes = %Q{
ActiveRecord::Schema.define do
  add_index "kladr", :name
  add_index "kladr", :code

  add_index "street", :name
  add_index "street", :code

  add_index "doma", :name
  add_index "doma", :code
end
}
    eval(schema_indexes)
    puts "Определение схемы БД КЛАДРа прошло успешно"
  end


  desc "Загрузка данных из KLADR.DBF"
  task :init_data_kladr => [:environment]  do
    KLADR.init_data(Kladr)
  end

  desc "Загрузка данных из STREET.DBF"
  task :init_data_street => [:environment]  do
    KLADR.init_data(Street)
  end

  desc "Загрузка данных из DOMA.DBF"
  task :init_data_doma => [:environment]  do
    KLADR.init_data(Doma)
  end

  desc "Загрузка данных из SOCRBASE.DBF"
  task :init_data_socrbase => [:environment]  do
    KLADR.init_data(Socrbase)
  end

end