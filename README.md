# Googlepay

## Installation

A Ruby interface to the Google Pay API. Currently focused on the Google Pay for Passes part of the API, with the intention of integrating with Google Pay for Payments in the future. 

```ruby
gem 'googlepay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install googlepay

## Try It

To try an implementation of the gem, try it [here](https://google-pay-demo.herokuapp.com/) or view the demo code [here](https://github.com/regularlady/googlepay-demo). 

## Setup

In order to use the googlepay gem, you will need to have a Google Service account setup. 

#### Access to the REST API

1. Sign up for a [Google Cloud Platform](https://cloud.google.com/) account.
2. Create a new project. 
3. Within the new project, set up a [Service Account](https://cloud.google.com/iam/docs/service-accounts). 
4. Click on Actions on your new Service Account, Create Key, generate a JSON key and download. 
5. Add the file into an initializer in your project. 

Example: initializers/googlepay.rb

    require 'googlepay'

    Googlepay.configure do |config|
      config.service_account = {
        "type": "service_account",
        "project_id": "",
        "private_key_id": "",
        "private_key": "",
        "client_email": "",
        "client_id": "",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": ""
      }
    end  

preferably by storing them as an ENV VAR in YAML format. 

    require 'googlepay'

    Googlepay.configure do |config|
      config.service_account = Rails.application.credentials.service_account
      #config.service_account = ENV['SERVICE_ACCOUNT']
    end

#### Tie your service account to your Google Pay API for Passes account

Visit [here](https://developers.google.com/pay/passes/guides/get-started/basic-setup/get-access-to-rest-api) to learn how to work with Google on getting registered for a Google Pay API for Passes account and to access the Google Pay API for Passes Merchant Center. Once registered in the Merchant Center, save your Issuer ID.

#### Enable the Google Pay API

Visit https://console.developers.google.com/apis/api/walletobjects.googleapis.com/overview?project={YOUR PROJECT} to enable the API for your project. Without doing so will cause this error: 

    Google Pay Passes API has not been used in project 615220349094 before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/walletobjects.googleapis.com/overview?project={ID} then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry.

#### Use OAuth 2.0 for your Server to Server application

This gem takes care of this for you, thanks to [googleauth](https://github.com/googleapis/google-auth-library-ruby). 

## Usage 

### Event Tickets

JSON EventTicketClass must be created before EventTicketObjects can be created.

Refer to the [Google Pay for Passes Code Snippets](https://developers.google.com/pay/passes/guides/pass-verticals/event-tickets/code-snippets) to build a JSON Object. I have also included simplified examples in EXAMPLE.md and you can review the specs for uses. 

#### Create/Update EventTicketClass

    parameters = JSON Object
    id = Googlepay::EventTicketClass.new(parameters)[:id]

Use the Issuer ID and a Unique ID formatted {Issuer ID.Unique ID} for the ID of the JSON object. If the ID exists already, the gem will update the EventTicketClass automatically. 

More documentation [here](https://developers.google.com/wallet/tickets/events/rest/v1/eventticketclass).

#### Create EventTicketObject

     Googlepay::EventTicketObject.new(parameters)

Use the Class ID and a Unique ID formatted {Issuer ID.Unique ID} for the ID of the JSON object. Include the array of domains to whitelist JWT saving functionality in the origin parameter. The Google Pay API for Passes button will not render when the origins field is not defined. You could potentially get an "Load denied by X-Frame-Options" or "Refused to display" messages in the browser console when the origins field is not defined.

More documentation [here](https://developers.google.com/wallet/tickets/events/rest/v1/eventticketobject).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/regularlady/googlepay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

The googlepay gem is not affiliated with or endorsed by Google.

## Code of Conduct

Everyone interacting in the Googlepay project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/googlepay/blob/master/CODE_OF_CONDUCT.md).
