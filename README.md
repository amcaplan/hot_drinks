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

[Rails plugin guide]: http://guides.rubyonrails.org/plugins.html
