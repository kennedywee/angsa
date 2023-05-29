
# Angsa

Angsa is a comprehensive server-side Ruby gem designed for Ruby on Rails applications. It delivers essential functionalities including pagination, sorting, and search capabilities for ActiveRecord models. The design of Angsa is catered to align smoothly with Grid.js, a powerful JavaScript library engineered for table grid layouts.

## Prerequisites

For Angsa to function properly, it requires specific versions of various software. It has been tested with:

1.  Grid.js
2.  Rails 7
3.  Importmap
4.  Ruby 3.1.3

Please ensure that your environment meets these prerequisites.

## Installation

### Step 1: Install Grid.js with Importmap

To get started, install Grid.js by following the instructions provided on the official Grid.js website. Alternatively, you can add Grid.js to your Rails project by executing the following command:

`bin/importmap pin gridjs` 

Next, apply the basic styling for Grid.js available from the official website. Ensure that Grid.js is added to your `javascript/application.js`:

`import 'gridjs'` 

### Step 2: Install Angsa

Add the Angsa gem to your application's Gemfile:

`gem "angsa", "~> 0.1.1"` 

To install the gem, execute:

`bundle install` 

## Usage
### Generators
Begin by installing the base JavaScript for Grid.js using the command:

`rails generate angsa:install` 

Next, generate a setup for a model in your project using the command:

`rails generate angsa:table YourModel` 

For instance, if you have a `Post` model, the command will be:

`rails generate angsa:table Post` 

Having declared the required columns, proceed to generate the Stimulus controller with:

`rails generate angsa:js YourModel` 

For example, for the `Post` model, it will be:

`rails generate angsa:js Post` 


### Configuring the API URL

The API URL acts as a data source for Grid.js. To generate this URL, include the following code in your target controller. This will facilitate fetching data in JSON format:

```ruby
respond_to do |format|
	format.html
	format.json { render json:  YourModelAngsa.new(params) }
end
```

Replace `YourModel` with the name of the model you are working with. For example, for a `Post` model, the line would read `PostAngsa.new(params)`.

### Integrating with Your Views

The subsequent step is to implement the functionality in your views. Here's an example using Slim syntax. Simply append the attributes illustrated below to your table. Grid.js and Angsa will handle the rest:

```ruby
table#gridjs  data-controller='your-model-angsa'
``` 

Replace `'your-model'` with the name of your model. Remember to use hyphen-case (lowercase with hyphens separating words). For a `Post` model, the line would read `data-controller='post-angsa'`.

## Development

Clone the repository and execute `bin/setup` to install dependencies. Use `bin/console` for an interactive session to experiment.

To install this gem locally, use `bundle exec rake install`. If you wish to release a new version, modify the version number in `version.rb`, and execute `bundle exec rake release`. This command creates a git tag for the version, pushes git commits and the created tag, and finally pushes the `.gem` file to [rubygems.org](https://rubygems.org/).

## Contributing

We welcome bug reports and pull requests on [GitHub](https://github.com/kennedywee/angsa). We are committed to fostering an environment of collaboration. All contributors are expected to adhere to our [code of conduct](https://github.com/kennedywee/angsa/blob/main/CODE_OF_CONDUCT.md).

## License

Angsa is open-source, licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

We expect everyone interacting in the Angsa project's codebases, issue trackers, chat rooms, and mailing lists to adhere to our [code of conduct](https://github.com/kennedywee/angsa/blob/master/CODE_OF_CONDUCT.md).