[![Build Status](https://travis-ci.org/hanami/hanami.svg?branch=master)](https://travis-ci.org/hanami/hanami)
[![Gem Version](https://badge.fury.io/rb/kawaii-api.svg)](https://badge.fury.io/rb/kawaii-api)
[![CodeClimate](https://codeclimate.com/github/rybex/kawaii/badges/gpa.svg)](https://codeclimate.com/github/rybex/kawaii)

# Kawaii

I would like to share new web API framework based on Rack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kawaii-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kawaii-api

## Creating new project

To create new project structure execute:

    $ kawaii-api new app_name

And then execute:

    $ cd app_name
    $ bundle install
    $ rackup

## Defining routes
You can define routes in many ways. All routes have to be defined in class which interhits from `Kawaii::Routing::Routes` class. This is why you can easily split your routes into many files.

### Support HTTP methods

```ruby
class Routes < Kawaii::Routing::Routes

  #you can specify mapping to controller class
  get    '/kawaii',  "controller#method"
  post   '/kawaii',  "controller#method"
  put	 '/kawaii',  "controller#method"
  delete '/kawaii',  "controller#method"

  #or define block as a route handler
  get '/kawaii' do |params, request|
    {message: 'Hello'}
  end
  post '/kawaii' do |params, request|
    {message: 'Hello'}
  end
  put '/kawaii' do |params, request|
    {message: 'Hello'}
  end
  delete '/kawaii' do |params, request|
    {message: 'Hello'}
  end
end
```

### REST Resources

```ruby
class Routes < Kawaii::Routing::Routes

  resource  :car
  resources :house
end
```

| HTTP_METHOD | PATH      | MAPPING     |
|------------:|-----------|-------------|
| :GET        | /car      | car#index   |
| :GET        | /car/new  | car#new     |
| :POST       | /car      | car#create  |
| :GET        | /car/edit | car#edit    |
| :PUT        | /car      | car#update  |
| :DELETE     | /car      | car#destroy |

```ruby
class Routes < Kawaii::Routing::Routes

  resources :car
end
```

| HTTP_METHOD | PATH          | MAPPING     |
|------------:|---------------|-------------|
| :GET        | /car          | car#index   |
| :GET        | /car/new      | car#new     |
| :GET        | /car/:id      | car#show    |
| :POST       | /car          | car#create  |
| :GET        | /car/:id/edit | car#edit    |
| :PUT        | /car/:id      | car#update  |
| :DELETE     | /car/:id      | car#destroy |

####Nested resources

```ruby
class Routes < Kawaii::Routing::Routes

  resources :car do
    resource :wheel
  end
end
```

####Additional options
You can specify which methods do you want to generate.

```ruby
class Routes < Kawaii::Routing::Routes

  resources :car,  [:index, :edit]
  resource :wheel, [:index]
end
```

### Namespaced routes

```ruby
class Routes < Kawaii::Routing::Routes

  namespace :car do
    resources :wheel

    get :wheel, "controller#method"
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kawaii/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
