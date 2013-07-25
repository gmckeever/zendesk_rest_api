# zendesk_rest_api

Use the Zendesk REST api to pull in specific ticket fields.

## Setup
* Run `bundle install`
* `cp .env-example .env` and replace with current credentials
* `export $(cat .env)`
* `bundle exec ruby zendesk.rb`
