require 'dbf'
require 'iconv'

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


  desc "Загрузка данных из KLADR.DBF"
  task :init_data_kladr => [:environment]  do
    table = DBF::Table.new("tmp/base/KLADR.DBF")
    eval(table.schema)
    Kladr.reset_column_information
    total = table.record_count
    start_time = Time.now
    k = 0

    table.each do |record|
      Kladr.create({
        "name" => Iconv.conv('UTF-8','cp866',record.name),
        "socr" => Iconv.conv('UTF-8','cp866',record.socr),
        "code" => Iconv.conv('UTF-8','cp866',record.code),
        "index" => Iconv.conv('UTF-8','cp866',record.index),
        "gninmb" => Iconv.conv('UTF-8','cp866',record.gninmb),
        "uno" => Iconv.conv('UTF-8','cp866',record.uno),
        "ocatd" => Iconv.conv('UTF-8','cp866',record.ocatd),
        "status" => Iconv.conv('UTF-8','cp866',record.status),
      })
      k += 1
      print "#{k} / #{total}  #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')} \r "
    end
    
    puts "Загружено записей: #{k} из #{total} \nЗатрачено времени: #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')}"
  end


  desc "Загрузка данных из STREET.DBF"
  task :init_data_street => [:environment]  do
    table = DBF::Table.new("tmp/base/STREET.DBF")
    eval(table.schema)
    Street.reset_column_information
    total = table.record_count
    start_time = Time.now
    k = 0

    table.each do |record|
      Street.create({
        "name" => Iconv.conv('UTF-8','cp866',record.name),
        "socr" => Iconv.conv('UTF-8','cp866',record.socr),
        "code" => Iconv.conv('UTF-8','cp866',record.code),
        "index" => Iconv.conv('UTF-8','cp866',record.index),
        "gninmb" => Iconv.conv('UTF-8','cp866',record.gninmb),
        "uno" => Iconv.conv('UTF-8','cp866',record.uno),
        "ocatd" => Iconv.conv('UTF-8','cp866',record.ocatd),
      })
      k += 1
      print "#{k} / #{total}  #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')} \r "
    end
    
    puts "Загружено записей: #{k} из #{total} \nЗатрачено времени: #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')}"
  end


  desc "Загрузка данных из DOMA.DBF"
  task :init_data_doma => [:environment]  do
    table = DBF::Table.new("tmp/base/DOMA.DBF")
    eval(table.schema)
    Doma.reset_column_information
    total = table.record_count
    start_time = Time.now
    k = 0
    
    table.each do |record|
      Doma.create({
        "name" => Iconv.conv('UTF-8','cp866',record.name),
        "korp" => Iconv.conv('UTF-8','cp866',record.korp),
        "socr" => Iconv.conv('UTF-8','cp866',record.socr),
        "code" => Iconv.conv('UTF-8','cp866',record.code),
        "index" => Iconv.conv('UTF-8','cp866',record.index),
        "gninmb" => Iconv.conv('UTF-8','cp866',record.gninmb),
        "uno" => Iconv.conv('UTF-8','cp866',record.uno),
        "ocatd" => Iconv.conv('UTF-8','cp866',record.ocatd),
      })
      k += 1
      print "#{k} / #{total}  #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')} \r "
    end
    
    puts "Загружено записей: #{k} из #{total} \nЗатрачено времени: #{Time.at(Time.now - start_time).gmtime.strftime('%R:%S')}"
  end


end