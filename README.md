# Классификатор адресов России (КЛАДР)

Актуальную версию  [КЛАДРа](http://www.gnivc.ru/inf_provision/classifiers_reference/kladr/)  можно получить с сайта  [ФГУП ГНИВЦ ФНС России](http://www.gnivc.ru)

Федеральное государственное унитарное предприятие «Главный научно – исследовательский вычислительный центр Федеральной налоговой службы»


## Скачивание БД КЛАДРа выполняется такском:

    $ rake kladr:download_kladr_db


## Создание БД

Для данных из КЛАДРа используется отдельная БД.

    $ RAILS_ENV=kladr rake db:setup

## Загрузка данных КЛАДРа

### Либо загрузка всего КЛАДРа целиком:

    $ RAILS_ENV=kladr rake kladr:init_data

### Либо выполнение подзадач по-отдельности.

Определение схемы БД КЛАДРа
 
    $ RAILS_ENV=kladr rake kladr:define_schema_kladr_db

Загрузка данных из KLADR.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_kladr

    Загружено записей: 212453 из 212453
    Затрачено времени: 00:07:04


Загрузка данных из STREET.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_street

    Загружено записей: 987387 из 987387
    Затрачено времени: 00:38:39


Загрузка данных из DOMA.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_doma

    Загружено записей: 2115950 из 2115950
    Затрачено времени: 01:27:53


Загрузка данных из SOCRBASE.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_socrbase

    Загружено записей: 157 из 157
    Затрачено времени: 00:00:00


### Выборка регионов

Иногда требуется только список регионов. Получить их можно следующим образом:

    table = DBF::Table.new("tmp/base/Kladr.DBF", nil, 'cp866')
    k = 0
    table.each{|record| if record.code =~ /^\d{2}00000000000/; k+=1; puts "#{k} \t #{record.attributes}"; end;}

Вывод на экран можно заменить созданием записи в БД, например

    Region.create(Где из record

----


Отредактировано с помощью [Github Preview](http://github-preview.herokuapp.com)

----

* Ruby version **2.0.0-p247**

* Rails version **4.0.0**
