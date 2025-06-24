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

* GENERATE THE KEY AND CRT FILES (local HTTPS)
  openssl req -x509 -sha256 -nodes -newkey rsa:2048 -keyout config/certs/localhost.key -out config/certs/localhost.crt -subj "/CN=localhost" -days 365

