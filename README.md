# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


*** Dependencies installments (in Linux Ubuntu)

**** sudo apt-get --assume-yes install gcc libcurl4-openssl-dev libxml2-dev ruby ruby-dev
**** sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev
**** sudo apt-get install libpq-dev
**** sudo apt-get install libmagick++-dev


**** Create Database for first time use
*** Set config/database.yml
*** rake db:create (run in terminal)
*** rake db:migrate (run in terminal)


**** Generate application package
*** bundle install

