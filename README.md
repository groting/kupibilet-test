# README

Это приложение разработано как тестовое задание для компании "Купибилет". Его основное назначение состоит в сокращение длины ссылок предоставленных пользователем. Процесс сокращения состоит в генерации уникального хеша для каждой предоставленой пользователем ссылки, с возможность использования сокращеной ссылки для перехода на исходную страницу.

#Требования:

Приложение было разработано на базе:

1. Ruby 2.5.1
2. Rails 5.2.0
3. Mysql 5.7
4. Thin 1.7.2

#Установка:

0. Для работы приложение необходим рабочий сервер Mysql. Пример установки для Ubuntu 'http://help.ubuntu.ru/wiki/mysql'

1. Скачать приложение с git с помощью функционала **git clone**.
2. Перейти в директорию с приложением и выполнить **bundle**.
3. Создать файл **config/database.yml**. Он должен соответствовать вашим настройкам для базы данных. Для удобства приложен файл образец **config/database.yml.sample**.
4. Выполнить **rake db:create** и **rake db:migrate**.
5. Создать файл **config/thin.yml**. Он должен соответствовать вашим настройкам для веб сервера. Для удобства приложен файл образец **config/thin.yml.sample**.
6. (По желанию) Можно запустить тесты используя **bundle exec rspec**.

#Использование:

1. Запустить веб сервер Thin **bundle exec thin start**.

2. Запрос создания ссылок:

```
POST /
Content-Type: application/json
{
"longUrl": "https://www.rust-lang.org/ru-RU/documentation.html"
}

Ответ: 
200 OK

Content-Type: application/json
{
"url": "http://{server ip adress}/KfWc5wcT3WGupLeyRQkpNhPv"
}

```
3. Запрос перехода:

```
GET /KfWc5wcT3WGupLeyRQkpNhPv

Ответ:
HTTP/1.1 301 Moved Permanently
Location: https://www.rust-lang.org/ru-RU/documentation.html

```