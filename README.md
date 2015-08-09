# Hot Drinks

This is meant to serve as a guide to writing your own Rails engines, or at least
understanding how they work.  Look through the commits and watch the Readme grow
as the engine develops.

Hot Drinks is a little toy app which will exercise the full MVC architecture and
show how each piece might be used in a real engine.

## Generating a Rails Engine

We start by using the Rails generator for plugins.  You can generate regular,
full, or mountable plugins.  For more information on regular plugins, you can
check out [the Rails guide on the topic][Rails plugin guide].  They're usually
meant for smaller bits of more experimental functionality.

Full or mountable plugins are full-fledged Rails Engines.  This means that they
act as miniature applications, and have a similar directory structure.  The
major difference between full and mountable plugins is that mountable plugins
are entirely namespaced, whereas full plugins are left in the namespace of your
whole application.  This makes full plugins far more dangerous to use.

The command to generate a Rails Engine is `rails plugin new plugin_name` with
the `--full` flag for a full plugin, or - you guessed it - the `--mountable`
flag for a mountable plugin.  For this tutorial, we'll stick with a mountable
plugin.

Since I'm a fan of RSpec, we'll skip the built-in tests and add in RSpec
ourselves.

```
$ rails plugin new hot_drinks --mountable --skip-test-unit --dummy-path=spec/test_app
```

What's that last bit?  The generator wants to encourage good testing practices,
so it actually builds a full-fledged app which will have our plugin mounted into
it.  So we can test the integration of our app with another app.  Sweet!
Unfortunately for us, it assumes you are using the `test/` directory for
testing, rather than the `spec/` directory.  So we're just moving that over.

Before we continue, let's turn this into a git repository.

```
$ git init
$ git add .
$ git commit -m "Initial commit"
```

Great!  Now let's look at our folder structure.

## The Structure of a Rails Engine

At the top level, we have some familiar filenames and directories:
```
$ ls
Gemfile
Gemfile.lock
MIT-LICENSE
README.md
Rakefile
app
bin
config
hot_drinks.gemspec
lib
spec
```

This looks like a regular Rails app, except that it has a `gemspec` file,
meaning it's all ready to be gemified and bundled in with your applications.

## Getting Ready for Testing

To make sure we're ready to test with RSpec, we'll add our dependencies to the
gemspec.  (Generally, when you're developing gems, it's best to avoid using the
Gemfile directly; see [Yehuda Katz's blog post about it][YK on gem gemfiles] for
the full explanation.)  We'll also add FactoryGirl for model generation.

``` ruby
s.add_development_dependency "rspec-rails", "~> 3.0"
s.add_development_dependency "factory_girl_rails", "~> 4.5"
```

While we're there, may as well add a homepage, summary, and description.

Once that's done, we need to

```
$ bundle install
```

to get our gems ready to go, and

```
$ rails generate rspec:install
```

to get our `spec_helper.rb` file ready.

### Updating Generators

Next, we'll tell our engine that we're using RSpec and FactoryGirl, so the Rails
generators will generate tests appropriately.

Look at the file `lib/hot_drinks/engine.rb`:

``` ruby
module HotDrinks
  class Engine < ::Rails::Engine
    isolate_namespace HotDrinks
  end
end

```

Let's understand this before we modify it.  The `isolate_namespace` line exists
because we told Rails to make this a mountable plugin.  So everything we create
will exist inside the `HotDrinks` namespace.  This line is super important!

We're going to add a few lines to the file, so it should now look like:

``` ruby
module HotDrinks
  class Engine < ::Rails::Engine
    isolate_namespace HotDrinks

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end

```

And we're ready to get to work.

## Adding Our Resources

Let's get down to our business rules now.  Essentially, we want to have coffee
and tea machines available.  They both basically work the same, just that one
produces coffee and the other produces tea.  We'll want to have a `Machine`
model representing our brewing machines, a `Drink` model representing the drinks
we generate, and a `DrinkType` model that will associate each drink and machine
as coffee or tea.  (We may want to add more drinks later - perhaps some apple
cider in the autumn?)

Our UX department has decided that we will have a page for each machine we
create, and that page will display available cups of coffee or tea created by
that machine.  Users can drink what's there, deleting the record from our
database.

### Generating a Model

Let's begin with our `DrinkType`s - they're straightforward enough.

```
$ rails generate model drink_type name:string
      invoke  active_record
      create    db/migrate/20150809110816_create_hot_drinks_drink_types.rb
      create    app/models/hot_drinks/drink_type.rb
      invoke    rspec
      create      spec/models/hot_drinks/drink_type_spec.rb
      invoke      factory_girl
      create        spec/factories/hot_drinks_drink_types.rb
```

Excellent, our engine used RSpec and FactoryGirl to test our model.  Note that
both the model and the spec files are namespaced.  This is reflected in the code
itself as well:

``` ruby
module HotDrinks
  class DrinkType < ActiveRecord::Base
  end
end

```

If you're extra sharp, you may also have noticed that the migration file looks a
little different than you might expect:

``` ruby
class CreateHotDrinksDrinkTypes < ActiveRecord::Migration
  def change
    create_table :hot_drinks_drink_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

```

Even the migration and table name are namespaced.  This way, they're less likely
to conflict with your application, and you could theoretically have a separate
`DrinkType` on the global level.

### Generating a Scaffold

The next step is going to be a little crazy.  We're going to generate a scaffold
for `Machine`s.  You shouldn't do this in your actual code, but we're trying to
work through this tutorial quickly, to show how this works.

Since we want to keep our Rails engine as slim as possible, we're going to trim
much of the fat off of the scaffold generation, just taking the bits we need.

```
$ rails generate scaffold machine name:string drink_type:references --no-assets --no-helper --no-view-specs --no-helper-specs --integration-tool=rspec
      invoke  active_record
      create    db/migrate/20150809112400_create_hot_drinks_machines.rb
      create    app/models/hot_drinks/machine.rb
      invoke    rspec
      create      spec/models/hot_drinks/machine_spec.rb
      invoke      factory_girl
      create        spec/factories/hot_drinks_machines.rb
      invoke  resource_route
       route    resources :machines
      invoke  scaffold_controller
      create    app/controllers/hot_drinks/machines_controller.rb
      invoke    erb
      create      app/views/hot_drinks/machines
      create      app/views/hot_drinks/machines/index.html.erb
      create      app/views/hot_drinks/machines/edit.html.erb
      create      app/views/hot_drinks/machines/show.html.erb
      create      app/views/hot_drinks/machines/new.html.erb
      create      app/views/hot_drinks/machines/_form.html.erb
      invoke    rspec
      create      spec/controllers/hot_drinks/machines_controller_spec.rb
      create      spec/routing/hot_drinks/machines_routing_spec.rb
      invoke      rspec
      create        spec/requests/hot_drinks/hot_drinks_machines_spec.rb
```

See how the controller and views are namespaced?  Cool.  You'll also note that
there was a route added to our `config/routes.rb`.  More on that later.

You'll note that I'm not really doing much with the tests.  We'll get there
soon.


[Rails plugin guide]: http://guides.rubyonrails.org/plugins.html
[YK on gem gemfiles]: http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/
