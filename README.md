# Sweater Weather

![languages](https://img.shields.io/github/languages/top/tjroeder/sweater_weather?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/tjroeder/sweater_weather)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Background and Description

Sweater Weather is a backend application which is used to plan road trips. This app will allow users to see the current weather as well as the forecasted weather at their destination. The project portrays a service-oriented architecture application. The future front-end will communicate this back-end through an API. This project is to expose that API that satisfies the front-end team’s requirements.

- The project description and requirements for Sweater Weather can be found [here](https://backend.turing.edu/module3/projects/sweater_weather/).

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

## Requirements and Setup (for Mac):

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.6

### Gems Utilized
- Capybara
- Email Validator
- Factory_Bot_Rails
- Faker
- Faraday
- Figaro
- JSON:API Serializer
- Pry
- RSpec
- SimpleCov
- Shoulda-Matchers
- VCR
- Webmock

## Setup
1. Clone this repository:
On your local machine open a terminal session and enter the following commands for SSH or HTTPS to clone the repositiory.


- using ssh key <br>
```shell
$ git clone git@github.com:tjroeder/sweater_weather.git
```

- using https <br>
```shell
$ git clone https://github.com/tjroeder/sweater_weather.git
```

Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Sweater Weather project directory.

```shell
$ cd sweater_weather
```

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.

```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, run the following command.

```shell
$ bundle install
```

There should be be verbose text diplayed of the installation process that looks similar to below. (this is not an actual copy of what will be output).

```shell
$ bundle install
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies...
Using bundler 2.1.4
Using byebug 11.1.3
Fetching coderay 1.1.2
Installing coderay 1.1.2
Using diff-lcs 1.4.4
Using method_source 1.0.0
Using pry 0.13.1
Fetching pry-byebug 3.9.0
Installing pry-byebug 3.9.0
Fetching rspec-support 3.10.1
Installing rspec-support 3.10.1
Fetching rspec-core 3.10.1
Installing rspec-core 3.10.1
Fetching rspec-expectations 3.10.1
Installing rspec-expectations 3.10.1
Fetching rspec-mocks 3.10.1
Installing rspec-mocks 3.10.1
Fetching rspec 3.10.0
Installing rspec 3.10.0
Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
If there are any errors, verify that bundler, Rails, and your Ruby environment are correctly setup.

4. Database Migration
Before using the web application you will need to setup your databases locally by running the following command

```shell
$ rails db:{:drop,:create,:migrate,:seed}
```

5. Startup and Access<br>
Finally, in order to use the web app you will have to start the server locally and access the app through a web browser. 
- Start server
```shell
$ rails s
```

- Open web browser and visit link base before testing end points.
    http://localhost:3000/

## External Endpoints
## Frontend Endpoints
### Retreive weather for a city:
#### Request Example:
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

## Endpoints
### Merchants:
- get all merchants - `GET /api/v1/merchants`
- get one merchant - `GET /api/v1/merchants/:id`
- get all items for a given merchant ID - `GET /api/v1/merchants/:merchant_id/items`
- find one merchant by name fragment - `GET /api/vi/merchants/find?name=`
### Items:
- get all items - `GET /api/v1/items`
- get one item - `GET /api/v1/items/:id`
- create an item - `POST /api/v1/items`
- edit an item - `PATCH /api/v1/items/:id`
- delete an item - `DELETE /api/v1/items/:id`
- get the merchant data for a given item ID - `GET /api/v1/items/:item_id/merchant`
- find all items by name fragment - `GET /api/vi/items/find_all?name=`
- find all items by max price - `GET /api/vi/items/find_all?max_price=`
- find all items by min price - `GET /api/vi/items/find_all?min_price=`    
- find all items by max and min price - `GET /api/vi/items/find_all?max_price=4.00&min_price=8.00`

## **Contributor** ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/tjroeder"><img src="https://avatars.githubusercontent.com/u/78194232?v=4" width="100px;" alt=""/><br /><sub><b>Tim (he/him)</b></sub></a><br /><a href="https://github.com/tjroeder/rails-engine/commits?author=tjroeder" title="Code">💻</a> <a href="#ideas-tjroeder" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/tjroeder/rails-engine/commits?author=tjroeder" title="Tests">⚠️</a> <a href="https://github.com/tjroeder/rails-engine/pulls?q=is%3Apr+reviewed-by%3Atjroeder" title="Reviewed Pull Requests">👀</a></td>
   </td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!--
