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
### Mapquest Geocode Address
- Documentation - https://developer.mapquest.com/documentation/geocoding-api/
- `GET http://www.mapquestapi.com/geocoding/v1/address`
- Query Params
- `key` - Mapquest API key - required `String`
- `location` - The location to geocode - required `String`
- Response Example
```json
{
  "info": {
    "statuscode": 0,
    "copyright": {
      "text": "© 2018 MapQuest, Inc.",
      "imageUrl": "http://api.mqcdn.com/res/mqlogo.gif",
      "imageAltText": "© 2018 MapQuest, Inc."
    },
    "messages": []
  },
  "options": {
    "maxResults": -1,
    "thumbMaps": true,
    "ignoreLatLngInput": false
  },
  "results": [
    {
      "providedLocation": {
        "location": "Washington,DC"
      },
      "locations": [
        {
          "street": "",
          "adminArea6": "",
          "adminArea6Type": "Neighborhood",
          "adminArea5": "Washington",
          "adminArea5Type": "City",
          "adminArea4": "District of Columbia",
          "adminArea4Type": "County",
          "adminArea3": "DC",
          "adminArea3Type": "State",
          "adminArea1": "US",
          "adminArea1Type": "Country",
          "postalCode": "",
          "geocodeQualityCode": "A5XAX",
          "geocodeQuality": "CITY",
          "dragPoint": false,
          "sideOfStreet": "N",
          "linkId": "282772166",
          "unknownInput": "",
          "type": "s",
          "latLng": {
            "lat": 38.892062,
            "lng": -77.019912
          },
          "displayLatLng": {
            "lat": 38.892062,
            "lng": -77.019912
          },
          "mapUrl": "http://www.mapquestapi.com/staticmap/v4/getmap?key=KEY&type=map&size=225,160&pois=purple-1,38.892062,-77.019912,0,0,|&center=38.892062,-77.019912&zoom=12&rand=306744981"
        }
      ]
    }
  ]
}
```

### Open Weather One Call API
- Documentation - https://openweathermap.org/api/one-call-api
- `GET https://api.openweathermap.org/data/2.5/onecall`
- Query Params
- `appid` - Open Weather API Key - required `String`
- `lat` - Latitude Geographical Coordinate - required `Float`
- `lon` - Longitude Geographical Coordinate - required `Float`
- `exclude` - Parameter to exclude certain parts of weather data - optional `Float` - by default `exclude: minutely,alerts`
- `units` - Units of measurement - optional `Float` - by default `units: imperial`
- Example API call
```
https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid={API key}
```
- Examaple API Response
```
{
  "lat": 33.44,
  "lon": -94.04,
  "timezone": "America/Chicago",
  "timezone_offset": -21600,
  "current": {
    "dt": 1618317040,
    "sunrise": 1618282134,
    "sunset": 1618333901,
    "temp": 284.07,
    "feels_like": 282.84,
    "pressure": 1019,
    "humidity": 62,
    "dew_point": 277.08,
    "uvi": 0.89,
    "clouds": 0,
    "visibility": 10000,
    "wind_speed": 6,
    "wind_deg": 300,
    "weather": [
      {
        "id": 500,
        "main": "Rain",
        "description": "light rain",
        "icon": "10d"
      }
    ],
    "rain": {
      "1h": 0.21
    }
  },
    "minutely": [
    {
      "dt": 1618317060,
      "precipitation": 0.205
    },
    ...
  },
    "hourly": [
    {
      "dt": 1618315200,
      "temp": 282.58,
      "feels_like": 280.4,
      "pressure": 1019,
      "humidity": 68,
      "dew_point": 276.98,
      "uvi": 1.4,
      "clouds": 19,
      "visibility": 306,
      "wind_speed": 4.12,
      "wind_deg": 296,
      "wind_gust": 7.33,
      "weather": [
        {
          "id": 801,
          "main": "Clouds",
          "description": "few clouds",
          "icon": "02d"
        }
      ],
      "pop": 0
    },
    ...
  }
    "daily": [
    {
      "dt": 1618308000,
      "sunrise": 1618282134,
      "sunset": 1618333901,
      "moonrise": 1618284960,
      "moonset": 1618339740,
      "moon_phase": 0.04,
      "temp": {
        "day": 279.79,
        "min": 275.09,
        "max": 284.07,
        "night": 275.09,
        "eve": 279.21,
        "morn": 278.49
      },
      "feels_like": {
        "day": 277.59,
        "night": 276.27,
        "eve": 276.49,
        "morn": 276.27
      },
      "pressure": 1020,
      "humidity": 81,
      "dew_point": 276.77,
      "wind_speed": 3.06,
      "wind_deg": 294,
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d"
        }
      ],
      "clouds": 56,
      "pop": 0.2,
      "rain": 0.62,
      "uvi": 1.93
    },
    ...
    },
    "alerts": [
    {
      "sender_name": "NWS Tulsa",
      "event": "Heat Advisory",
      "start": 1597341600,
      "end": 1597366800,
      "description": "...HEAT ADVISORY REMAINS IN EFFECT FROM 1 PM THIS AFTERNOON TO\n8 PM CDT THIS EVENING...\n* WHAT...Heat index values of 105 to 109 degrees expected.\n* WHERE...Creek, Okfuskee, Okmulgee, McIntosh, Pittsburg,\nLatimer, Pushmataha, and Choctaw Counties.\n* WHEN...From 1 PM to 8 PM CDT Thursday.\n* IMPACTS...The combination of hot temperatures and high\nhumidity will combine to create a dangerous situation in which\nheat illnesses are possible.",
      "tags": [
        "Extreme temperature value"
        ]
    },
    ...
  ]
  ```
 
### Flickr Image Search API
- Documentation - https://www.flickr.com/services/api/flickr.photos.search.html
- `GET https://www.flickr.com/services/rest`
- Query Params
- `api_key` - Flickr API Key - required `String`
- `method` - Flickr API to use - required `String` - by default for app set to `flickr.photos.search`
- `text` - Query of photos titles, descriptions and tags - optional `Float` - required in current implementation
- `privacy_filter` - Return photos only matching a certain privacy level - optional `Integer` - by default for app set to `1` for public photos
- `safe_search` - Safe search setting - optional `Integer` - by default for app set to `1` for safe
- `content_type` - Content type setting - optional `Integer` - by default for app set to `1` for photos only
- `accuracy` - Recorded accuracy level of the location information - optional `Integer` - by default for app set to `11` for City accuracy
- `media` - Filter results by media type - optional `String` - by default for app set to `photos` 
- `geo_context` - Numeric value representing photos geotagginess beyond lat and long - optional `Integer` - by default for app set to `1` for outdooors
- `format` - Response format - optional `String` - by default for app set to `json`
- `nojsoncallback` - Response callback - optional `Integer` - by default for app set to `1`
- `extras` - Extra inforamation to return with call - optional `String` - by default for app set to `license,owner_name,url_l,url_t`
- Example API call
```
https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid={API key}
```
- Examaple API Response
```
{
    "photos": {
        "page": 1,
        "pages": 4,
        "perpage": 250,
        "total": 763,
        "photo": [
            {
                "id": "51171017393",
                "owner": "159558871@N05",
                "secret": "8d354343d4",
                "server": "65535",
                "farm": 66,
                "title": "Mile High Switching",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0,
                "license": "0",
                "ownername": "Christopher Parma",
                "url_l": "https://live.staticflickr.com/65535/51171017393_8d354343d4_b.jpg",
                "height_l": 684,
                "width_l": 1024,
                "url_t": "https://live.staticflickr.com/65535/51171017393_8d354343d4_t.jpg",
                "height_t": 67,
                "width_t": 100,
                "pathalias": null
            },
            {
                "id": "49506613916",
                "owner": "54515111@N00",
                "secret": "16394c2673",
                "server": "65535",
                "farm": 66,
                "title": "Downtown Denver",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0,
                "license": "3",
                "ownername": "Simon Foot",
                "url_l": "https://live.staticflickr.com/65535/49506613916_16394c2673_b.jpg",
                "height_l": 683,
                "width_l": 1024,
                "url_t": "https://live.staticflickr.com/65535/49506613916_16394c2673_t.jpg",
                "height_t": 67,
                "width_t": 100,
                "pathalias": "beerandloathing"
            }, {...}
         ]
    },
    "stat": "ok"
}
```

## Frontend Endpoints

### Retreive weather for a city:
- Request Example:
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```
- Query Params
- `location` - location to search for forecast - required `String`
- Response Example:
```

    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2022-03-09 08:50:22 -0700",
                "sunrise": "2022-03-09 05:03:53 -0700",
                "sunset": "2022-03-09 16:44:28 -0700",
                "temperature": 42.67,
                "feels_like": 39.11,
                "humidity": 71,
                "uvi": 3.38,
                "visibility": 10000,
                "conditions": "broken clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2022-03-09",
                    "sunrise": "2022-03-09 05:03:53 -0700",
                    "sunset": "2022-03-09 16:44:28 -0700",
                    "max_temp": 49.98,
                    "min_temp": 35.92,
                    "conditions": "rain and snow",
                    "icon": "13d"
                },
                {
                    "date": "2022-03-10",
                    "sunrise": "2022-03-10 05:02:22 -0700",
                    "sunset": "2022-03-10 16:45:27 -0700",
                    "max_temp": 51.48,
                    "min_temp": 33.66,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "date": "2022-03-11",
                    "sunrise": "2022-03-11 05:00:52 -0700",
                    "sunset": "2022-03-11 16:46:25 -0700",
                    "max_temp": 54.41,
                    "min_temp": 33.82,
                    "conditions": "rain and snow",
                    "icon": "13d"
                },
                {
                    "date": "2022-03-12",
                    "sunrise": "2022-03-12 04:59:21 -0700",
                    "sunset": "2022-03-12 16:47:22 -0700",
                    "max_temp": 32,
                    "min_temp": 18.07,
                    "conditions": "snow",
                    "icon": "13d"
                },
                {
                    "date": "2022-03-13",
                    "sunrise": "2022-03-13 05:57:49 -0600",
                    "sunset": "2022-03-13 17:48:20 -0600",
                    "max_temp": 40.62,
                    "min_temp": 17.49,
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "08:00:00",
                    "temperature": 42.3,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "09:00:00",
                    "temperature": 42.67,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "10:00:00",
                    "temperature": 43.21,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "11:00:00",
                    "temperature": 44.64,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "12:00:00",
                    "temperature": 46.54,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "13:00:00",
                    "temperature": 48.45,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "14:00:00",
                    "temperature": 49.98,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "15:00:00",
                    "temperature": 49.39,
                    "conditions": "clear sky",
                    "icon": "01d"
                }
            ]
        }
    }
}
```

### Retreive background image for a city:
- Request Example:
```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```
- Query Params
- `location` - location to search for background image search - required `String`
- Response Example:
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "image_id": "43691964192",
                "owner_id": "8121206@N07",
                "secret_id": "4ff507454d",
                "title": "Denver Skyline",
                "location": "denver,co skyline",
                "image_links": {
                    "large_url": "https://live.staticflickr.com/930/43691964192_4ff507454d_b.jpg",
                    "large_height": 683,
                    "large_width": 1024,
                    "thumbnail_url": "https://live.staticflickr.com/930/43691964192_4ff507454d_t.jpg",
                    "thumbnail_height": 67,
                    "thumbnail_width": 100
                },
                "credit": {
                    "owner_name": "Christopher Wallace",
                    "license": "All Rights Reserved",
                    "license_url": "",
                    "source": "Flickr",
                    "notice": "This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc.",
                    "terms_url": "https://www.flickr.com/help/terms/api"
                }
            }
        }
    }
}
```

### User Registration
- Request Example:
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
- Query Params
- `email` - user email - required `String`
- `password` - user password - required `String`
- `password_confirmation` - user password confirmation - required `String`
- Response Example:
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### User Login
- Request Example:
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```
- Query Params
- `email` - user email - required `String`
- `password` - user password - required `String`
- Response Example:
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### Road Trip
- Request Example:
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
- Query Params
- `origin` - road trip origin location - required `String`
- `destination` - road trip destination location - required `String`
- `api_key` - user api key - required `String`
- Response Example:
```
status: 200
body:

{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```

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
