# Классификатор адресов России (КЛАДР)

Актуальную версию  [КЛАДРа](http://www.gnivc.ru/inf_provision/classifiers_reference/kladr/)  можно получить с сайта  [ФГУП ГНИВЦ ФНС России](http://www.gnivc.ru)

Федеральное государственное унитарное предприятие «Главный научно – исследовательский вычислительный центр Федеральной налоговой службы»


## Скачивание БД КЛАДРа выполняется такском:

    $ rake kladr:download_kladr_db


## Создание БД

Для данных из КЛАДРа используется отдельная БД.

    $ RAILS_ENV=kladr rake db:setup

    -- initialize_schema_migrations_table()
    -> 0.3293s

Определение схемы БД КЛАДРа
 
    $ RAILS_ENV=kladr rake kladr:define_schema_kladr_db


## Загрузка данных из таблиц КЛАДРа

Загрузка данных из KLADR.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_kladr

    Загружено записей: 212453 из 212453
    Затрачено времени: 00:07:11


Загрузка данных из STREET.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_street

    Загружено записей: 987387 из 987387
    Затрачено времени: 00:38:39


Загрузка данных из DOMA.DBF

    $ RAILS_ENV=kladr rake kladr:init_data_doma

    Загружено записей: 2115950 из 2115950
    Затрачено времени: 01:27:53

----


Отредактировано с помощью [Github Preview](http://github-preview.herokuapp.com)

----

* Ruby version **2.0.0-p247**

* Rails version **4.0.0**
