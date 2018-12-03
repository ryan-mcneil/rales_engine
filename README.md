# README - RALES ENGINE

I have developed a JSON API to expose the SalesEngine data. Fastjson is used to format and limit the JSON output.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

From GitHub clone down repository using the following commands in terminal:
* git clone git@github.com:ryan-mcneil/rales_engine.git
* cd rales_engine

### Prerequisites

You will need Rails installed and verify that it is version 5.1

To check your version using terminal run: rails -v in the command line.
If you have not installed rails, in terminal run: gem install rails -v 5.1 in the command line.


### Installing

Open terminal and run these commands:
* bundle
* bundle update
* bundle exec rake db:{create,migrate}
* bundle exec rake import:data (this may take a few minutes)
* rails s

Open up a web browser (preferably Firefox or Chrome with a JSON Viewer)

Navigate to localhost:3000 (a landing page should be displayed)


## Running the tests

* Note: Before running RSpec, ensure you're in the project root directory.

From terminal run: rspec

After RSpec has completed, you should see all tests passing as GREEN.  Any tests that have failed or thrown an error will display RED.  Any tests that have been skipped will be displayed as YELLOW.

## Accessing the API

From localhost:3000, the various endpoints can be reached. For example, trying running:

- http://localhost:3000/api/v1/items
- http://localhost:3000/api/v1/transactions
- http://localhost:3000/api/v1/customers/22
- http://localhost:3000/api/v1/merchants/56/invoices
- http://localhost:3000/api/v1/merchants/find?name=Schroeder-Jerde
- http://localhost:3000/api/v1/items/find_all?merchant_id=43
- http://localhost:3000/api/v1/merchants/most_revenue?quantity=3

-  Trying running `rake routes` from the terminal or looking through the spec suite for other available queries.

## Built With

* Rails
* RSpec
* ShouldaMatchers
* Pry
* SimpleCov
* FactoryBot
* PostreSQL
* Fast JSON API


## Versioning

GitHub

## Authors

* Ryan McNeil - Github: ryan-mcneil


## Acknowledgments

* coffee
