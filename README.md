# README

# CurrencyExchange app
* This Ruby on Rails application provides users with ability to view exchange rates between different currencies on a specific date.


## Ruby Version
* 3.3.6

## Rails Version
* 8.0.1

## System Dependencies

* Ruby
* Rails 
* SQLite3

## Install Dependencies
* Install the necessary Ruby gems by ranning:
`bash`
`bandle install`

## Database creation
- Create the database and run the migrations:
`bash` 
`rails db:create`
`rails db:migrate`
- This will create 

## Seed the Database

This will load the initial data from the `db/data/rates.json` file
 to populate the database with initial exchange rate data. Run:
`rails db:seed`

##  How to run the test suite

The app requires an initial setup done by running:
`rails test`


