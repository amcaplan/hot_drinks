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

## 

[Rails plugin guide]: http://guides.rubyonrails.org/plugins.html
[YK on gem gemfiles]: http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/
