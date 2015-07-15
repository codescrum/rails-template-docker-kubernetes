# RAILS TEMPLATE

Base template for deploying Rails applications

## ESSENTIAL VERSIONS

  - Ruby 2.2.0

  - Rails 4.2.2

  - Mongoid 4.0.2

Also this template is wrapped by [Zeus gem](https://github.com/burke/zeus) which preloads your Rails app so that your normal development tasks such as console, server, generate, and specs/tests take less than one second.

You can configure some zeus settings using the `zeus.json` file located in your rails root path.
We are not using Spring. If you would like to disable all possible problems with Spring, use the `DISABLE_SPRING=true` environment variable (place in your .zshrc file if you want).

## TECH EXPLANATIONS

### SECURITY
####Brakeman ([GITHUB REPO](https://github.com/presidentbeef/brakeman))
Brakeman is a static analysis tool which checks Ruby on Rails applications for security vulnerabilities.

*usage*

```sh
  brakeman -o output_file
```

#### SecureHeaders ([GITHUB REPO](https://github.com/twitter/secureheaders))
Security related headers all in one gem, you can find the config file in `config/initializers/security_headers.rb`, The security rules have been applied on `ApplicationController` class using the `ensure_security_headers` method

The gem will automatically apply several headers that are related to security. This includes:

##### General supports
- Prevents your content from being framed and potentially clickjacked
- Prevent content type sniffing
- Helps prevent attacks based on MIME-type confusion.
- Cross site scripting heuristic filter for IE/Chrome
- Prevent file downloads opening
- Restrict Adobe Flash Player's access to data

##### Strict Transport Security
Is a security feature that lets a web site tell browsers that it should only be communicated with using HTTPS, instead of using HTTP.

*Browser compatibility:*

- IE: 11
- Chrome: > 4
- Firefox: > 4
- Opera: 12
- Safari: 7

see more info here:
https://goo.gl/ldjc5h

##### Content Security Policy
Is an added layer of security that helps to detect and mitigate certain types of attacks, including Cross Site Scripting (XSS) and data injection attacks. These attacks are used for everything from data theft to site defacement or distribution of malware.

*Browser compatibility:*
 
- IE: Edge
- Chrome: > 25
- Firefox: > 24
- Opera: 15
- Safari: 7

see more info here:
https://goo.gl/u23dit
| https://goo.gl/wHC9C5
| https://goo.gl/Z8UvAz

##### Public Key Pinning
The Public Key Pinning Extension for HTTP (HPKP) is a security feature that tells a web client to associate a specific cryptographic public key with a certain web server to prevent MITM attacks with forged certificates.

*Browser compatibility:*
  
- IE: ?
- Chrome: > 38
- Firefox: > 35
- Opera: ?
- Safari: ?

*Server Compatibility*

- NGNIX: adding the following line and inserting the appropriate pin-sha256="..." values will enable HPKP on your nginx. This requires the ngx_http_headers_module.
- Apache: adding a line similar to the following to your webserver's config will enable HPKP on your Apache. This requires mod_headers enabled.

see more info here:
https://goo.gl/yrx3ex
| http://goo.gl/zFnaaW
### CONFIG
We are using a combined strategy between [secrets](http://guides.rubyonrails.org/4_1_release_notes.html#config-secrets-yml) and [dotenv](https://github.com/bkeepers/dotenv) approaches, you can use a similar approach like Figaro, in fact after almost two years there is still a little discussion about what is the best approach for managing your settings and sensitive information (there is an interesting post from Figaro's creator [here](http://www.collectiveidea.com/blog/archives/2013/12/18/the-marriage-of-figaro-and-rails/)).

Finally, these are our conclusions about the selected approach:

- Always gitignore your settings files (at least those that do not contain *heteromorphic* and *sensitive* data -  but it would be an odd case)
- It is great that our settings can be managed using a rich object support, it give us a convenient way for controlling and structuring our information using a set-based approach, at the end we will have a better strategy for organizing our config data.
- In order to be compliant with the [config section](http://12factor.net/config) in the [twelve factor app](http://12factor.net/) methodology, we also can use ENV variables whenever necessary. `config/secrets.yml` as other YAML files in Rails is passed first through ERB, this behaviour gives us the chance for configuring our ENV settings using dotenv which allows to load environment variables from `.env` into ENV in the configured environments.
- Keeping an easy deployment is a priority, and it is clear that using an ENV approach seems to cover this concern, but you can obtain the benefits of an hybrid solution by using a rich object support and ENV approach. Our experience has taught us that the sensitive data and the external integration credentials is a real concern for both the staging and production environments (especially for scenarios with limited control as Heroku), however you can manage this responsibility with ease, in your own servers you always can use capistrano (or similar solutions) for automating the remotely settings installation (secrets.yml) for every application server (this process is still missing in this template, but in the future it will be included). On the other hand, you also can configure your application so that it’s compliant with Heroku, it is enough by adding a little deployment hack, you can see this at the end of `config/application.rb` file (remember that the secrets file is gitignored).
- One of the most important thing in our context is the ‘convention over configuration’ fact, and **secrets** is the default approach (and convention) for managing the sensitive info in the Rails community
- Secure defaults, the new convention has agreed that the `secret_key_base` (used to verify the integrity of signed cookies) will be stored in the **secrets** file, you can see more info [here](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml) and [here](http://stackoverflow.com/questions/25426940/what-is-the-use-of-secret-key-base-in-rails-4)

#### Dotenv ([GITHUB REPO](https://github.com/bkeepers/dotenv))
You can use this integration for configuring your environment variables in the app environment you desire. For now the template has an `.env.example` in which you can establish a common structure for your ENVs, then you can integrate this declarations into the secrets file using an ERB definition: `secret_cat_key: <%= ENV["SECRET_CAT_KEY"] %>`
### TESTING
This template follows the Rspec rules mentioned on the [Rspec upgrading documentation](https://www.relishapp.com/rspec/rspec-rails/docs/upgrade#default-helper-files), in that sense we have two config files:

- spec_helper: this file provides an out-of-the-box way to avoid loading Rails for those specs that do not require it, accordingly to that, we are using the `--require spec_helper` option inside to the `.rspec` file by establishing a non-Rails configuration by default.
- rails_helper: this file provides a configuration space for specs which do depend on Rails (in a Rails project, most or all of them). `rails_helper.rb`. `.rspec` file requires `spec_helper.rb` by default, for that reason `rails_helper.rb` does not need to require to `spec_helper.rb` by itself.

Also, according to the current configuration you don’t need to add metadata information manually, take into account that newer versions of Rspec ( > 3.0.0) do not do that at least you specify it explicitly, you can find this config line in the `rails_helper.rb` file: `config.infer_spec_type_from_file_location!`. Be aware about how your files are structured, you can find a good guide [here](https://www.relishapp.com/rspec/rspec-rails/v/3-0/docs/directory-structure) for that.

#### Capybara & Poltergeist ([GITHUB REPO](https://github.com/teampoltergeist/poltergeist))
Poltergeist is a driver for Capybara. It allows you to run your Capybara tests on a headless WebKit browser, provided by PhantomJS. We are using this driver in favor of [capybara-webkit](https://github.com/thoughtbot/capybara-webkit) and [selenium](https://github.com/seleniumhq/selenium).

Selenium is a good tool for enabling automation of web browsers, it applies for automated testing too but it is pretty much slower than **capybara-webkit** and **poltergeist**.

Regarding **capybara-webkit** we can find that **poltergeist** has the following advantages:

- Sometimes, in **capybara-webkit** *what you see is NOT what you get (perhaps on the interacting scenarios)*, we have had some problems when we use some dynamic graphical interactions (animations, fade-out, fade-in, etc), some of them have been impossible to testing or in the good case for building our tests we have had to make some unpleasant tricks.
- Poltergeist has much clearer error messages, its debugging and inspection system is so much better, you can easily see if a html node is overlapping with another (avoiding to execute some action or event on it) or track your javascript faults.
- The installation process is easier, even on Linux you can find stable binary releases for PhantomJS.
- The screenshot feature is more customizable.
- You can inspect the network traffic.
- You have a richer keys and events sender (on specific html node).

At the end, you can customize several options for deploying Poltergeist changing the way how Capybara executes your test suite.
##### PhantomJS for Linux
you can find an stable release here:

- [PhantomJS 1.9.7](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2) (tested on Ubuntu 12.04)

you can choose the edge (2015-07-02):

- [PhantomJS 2.0.0](https://s3.amazonaws.com/travis-phantomjs/phantomjs-2.0.0-ubuntu-12.04.tar.bz2) (tested on Ubuntu 12.04)
- [PhantomJS 2.0.0](https://github.com/bprodoehl/phantomjs/releases/tag/v2.0.0-20150528) for linux 14.04 and 15.04 (no tested)

you can see the complete discussion [here](https://github.com/ariya/phantomjs/issues/12948)

##### PhantomJS for Mac

- You can install it using *brew* `brew install phantomjs`
- If you want to be in the edge you can install from [here](http://phantomjs.org/download.html)

##### PhantomJS for Windows
No, seriously?
#### Test coverage
Test coverage is covered by [simplecov gem](https://github.com/colszowka/simplecov), however this integration has some problems with Zeus but we have already dealt with. You can find more info [here](https://github.com/burke/zeus/wiki/SimpleCov) and [here](https://github.com/burke/zeus/issues/131#issuecomment-64106894), also you can manipulate the way how the things are loaded by modifying the `custom_plan.rb` file located in the rails root path.

Similarly, inside the `rails_helper` file (at the beginning of) we also have configured simplecov when zeus is not running. Finally we can find all the coverage in the `coverage/` folder which is gitignored by default and is updated once the tests have finished running.

#### Miscellaneous
We are complimented our test suite with:

- [VCR](https://github.com/vcr/vcr) records your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests. There is an example spec in the `spec/features/welcome_spec.rb`, also you can see more info [here](https://www.relishapp.com/vcr/vcr/v/2-9-0/docs/test-frameworks/usage-with-rspec-metadata)
- [Faker](https://github.com/stympy/faker) A library for generating fake data such as names, addresses, and phone numbers.
- [Factory Girl](https://github.com/thoughtbot/factory_girl) factory_girl is a fixtures replacement with a straightforward definition syntax, support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.

### CODE QUALITY
We have integrated four powerful gems for checking the code quality.

#### Rubocop ([GITHUB REPO](https://github.com/bbatsov/rubocop))
A Ruby static code analyzer, based on the community Ruby style guide. You can execute this code inspection process by using the `$ rubocop --format html -o tmp/rubocop.html` command, it will generate a new file `tmp/rubocop.html` in which you can see your “offenses” inside your code. Also, you can find the config rubocop file in `.rubocop.yml`

#### Rubycritic ([GITHUB REPO](https://github.com/whitesmith/rubycritic))
RubyCritic is a gem that wraps around static analysis gems such as [Reek](https://github.com/troessner/reek), [Flay](https://github.com/seattlerb/flay) and [Flog](https://github.com/seattlerb/flog) to provide a quality report of your Ruby code. You can execute this code inspection process by using the `$ rubycritic app` command, it will generate a html file set for the code quality report, you can find this in `tmp/rubycritic/overview.html`.

#### Rails Best Practices ([GITHUB REPO](https://github.com/railsbp/rails_best_practices))
It is a code metric tool to check the quality of Rails code. It is a little old fashioned but it could help you with some metrics that are not visible for the others analysers (Rubocop, Rubycritic)

#### Inch ([GITHUB REPO](https://github.com/rrrene/inch))
A documentation measurement tool for Ruby, based on YARD. you can generate several documentation reports for your code documentation, execute this code inspection by using the `$ inch` command, however you can also use other options like: `$ inch stats` `$ inch lists` `$ inch suggest` for obtaining a most complete information. You can see a quick start guide [here](http://trivelop.de/inch/)

#### Bullet ([GITHUB REPO](https://github.com/flyerhzm/bullet))
Bullet helps you to kill N+1 queries and unused eager loading, it will run each time that you execute any request on your web server, you can see either a javascript alert (you can also disable it) or a little report in the logs (or both of them) when a new related issue is found. You can find the config block in the `config/environment/development.rb` file

#### Shortcuts
We are using [Guard](https://github.com/guard/guard) for automating the inspection of code changes. Guard is a command line tool to easily handle events on file system modifications. We have integrated Guard with Inch, Rubycritic and Rubocop. If you want to execute this process you can run the `$ guard` command in the root project path.

If you do not want have a process for the monitoring stuff, you can run this task `code_quality:inspect` for running both Rubycritic, Rail Best Practices and Rubocop inspections by yourself.

### PERFORMANCE
Improving our application’s performance is really a critic stuff, in the previous section (**CODE QUALITY**) we have included the **Bullet** gem, you can use it for improving the performance a lot. However, we have included other gems which are very useful for tracking your load times as well.

#### Rack Mini Profiler ([GITHUB PROJECT](https://github.com/MiniProfiler/rack-mini-profiler))
It is a middleware that displays speed badge for every html page. Designed to work both in production and in development (it is configured in the development environment by default). If you experiment some problems with the caching behaviour you can see this [section](https://github.com/MiniProfiler/rack-mini-profiler#caching-behavior). In other hand, it could become annoying, so you can disable it by following the next instructions

#### Flamegraph ([GITHUB PROJECT](https://github.com/brendangregg/FlameGraph))
It is a stack trace visualizer for Ruby 2.0, flamegraph support is built into rack-mini-profiler, just require this gem and you should be good to go. you only need to add **?pp=flamegraph** at the end of your *query string*

### DEBUGGING & LOGGING
Debugging is a pretty important process for developing an application, we have integrated a [jazz_hands](https://github.com/jkrmr/jazz_hands) gem, it is an opinionated set of console-related gems and a bit of glue (having [Pry](https://github.com/pry/pry) as its core):

* [**Pry**][pry] for a powerful shell alternative to IRB.
* [**Awesome Print**][awesome_print] for stylish pretty print.
* [**Hirb**][hirb] for tabular collection output.
* [**Pry Rails**][pry-rails] for additional commands (`show-routes`,
  `show-models`, `show-middleware`) in the Rails console.
* [**Pry Doc**][pry-doc] to browse Ruby source, including C, directly from the
  console.
* [**Pry Git**][pry-git] to teach the console about git. Diffs, blames, and
  commits on methods and classes, not just files.
* [**Pry Remote**][pry-remote] to connect remotely to a Pry console.
* [**Pry Byebug**][pry-byebug] to turn the console into a simple debugger.
* [**Pry Stack Explorer**][pry-stack_explorer] to navigate the call stack and
  frames.
* [**Coolline**][coolline] and [**Coderay**][coderay] for syntax highlighting as
  you type. _Optional. MRI 2.0.0+ only_

You can see how to use Pry [here](http://www.sitepoint.com/rubyists-time-pry-irb/) there are amazing tricks and commands that you can utilize for inspecting your code, even make a [RDD - REPL Driven Development](https://www.youtube.com/watch?v=D9j_Mf91M0I).
### FRONTEND

#### THE SASS WAY

We want to integrate a new way for structuring and generating our styles resources in Rails. For that reason we have designed **Sassish**, and I will introduce you to it.

Sassish (we are thinking about changing its name, also we are thinking in gemify this piece of code as well) supports how the style files are organized and how these are loaded, its approach is an hybrid combination for both the traditional assets precompile philosophy and the sass benefits.

The main idea is to simplify the development process and improve the organization, reusability and loading issues (it will help you for including an [OOCSS](http://www.slideshare.net/stubbornella/object-oriented-css) philosophy in the future).

As you can see in the image below, we have two macro-levels of organization (you can choose only one level if you want), the first level solves the problem for including more than one style framework or design tool inside to more than one Rails layout, in this case we have two segmentations: **application** and **application-welcome**.

![alt tag](https://raw.githubusercontent.com/Johaned/rails-template/master/app/assets/images/sassish.png)


The second level is the most important one, it defines a new structure in which you have two kind of style resource areas, the first one allows you to define your general style (the common style inherited from the specific rails layout, in this case it is the **main** layout associated with the **application** manifest), all sass files defined here will be loaded in each html page associated with the main layout. Take into account that all common rendered css should be included in the **base** folder, on the other hand, the **core** folder only should be used for reusable components applying a more object oriented philosophy (you can read more info about that [here](http://www.smashingmagazine.com/2011/12/12/an-introduction-to-object-oriented-css-oocss/)  and [here](http://thesassway.com/intermediate/using-object-oriented-css-with-sass)).

The **styles** folder defines an automatic way for loading your stylesheets according to a specific action, it is related to the specific **controller** entity, suppose that you have the following distribution:

![alt tag](https://raw.githubusercontent.com/Johaned/rails-template/master/app/assets/images/new_styles_folder.png)


And suppose that you are requesting for a users’ action  (that is on the **main** layout), then **Sassish** will automatically include both **base** styles files and **users.sass** file, it means that all remaining files inside **styles** won’t be included.

However you can also use a **Sassish** helper named **add_sassish_style** for including more style files that you need per specific request (rails view).

```haml
- add_sassish_style 'main/styles/non-controller'
%h2= t(".sign_in")
= simple_form_for(resource, as: resource_name, url: session_path(resource_name)) do |f|
  .form-inputs
    = f.input :email, label: false, required: false, autofocus: true, placeholder: t(".your_email")
    = f.input :password, label: false, required: false, placeholder: t(".your_password")
    = f.input :remember_me, label: false, inline_label: t(".remember_me"), as: :boolean if devise_mapping.rememberable?
  .form-actions
    = f.button :submit, t(".sign_in"), class: 'btn-block'
.text-right
  %br
  = render "devise/shared/links"
```

Take into account that in order to above code works, you must to include your **non-controller.sass** file to the assets precompile declaration inside the **assets** initializer, you can also use the **precompiled_stylesheet** sassish generator.

```sh
$ rails g precompiled_stylesheet non-controller 
```

It will add the non-controller style to the assets precompile declaration, but it will use the folder defined for the sassish styles.

```sh
# config/initializers/assets.rb
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( main/styles/non-controller.css application-welcome.css application-session.css )
```

You can configure the sassish folder by using an initializer, this template already includes it

```ruby
Sassish.setup do |config|
  config.define_stylesheet_path 'main/styles'
end
```

This piece of code tells Sassish that in the ‘app/assets/stylesheets/**main/styles**’ folder will be stored all individual css style that will be only required using either the specific **controller** or the **add_sassish_style** helper.

Also, you do not need to be worried about your generators (assets, scaffold or similar), **Sassish** modifies the way how the stylesheet files are generated,all new resource created by a generator will take into account the configured sassish folder and the assets precompile declaration, so **Sassish** allows you to manage its approach with ease.

```sh
$ rails g scaffold user
$ rails g assets user
```

Finally, in order to make all this magic works, you need to replace your traditional stylesheet_link_tag to sassish_stylesheet_link_tag, it makes the same process than traditional helper, the main difference is that it will automatically include both a specific controller style resource and all added styles using the add_sassish_style helper.

```haml
!!!
/ app/views/layouts/application.html.haml
%html
  %head
    %meta{:name => "viewport", :content => "width=device-width, initial-scale=1.0"}
    %title= content_for?(:title) ? yield(:title) : 'Rails Foo'
    %meta{:name => "description", :content => "#{content_for?(:description) ? yield(:description) : 'Rails Foo'}"}
    = sassish_stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true
```

## Contributors
<ul>
  <li><a href="https://github.com/johaned">Johan Tique</a></li>
  <li><a href="https://github.com/gato-omega">Miguel Diaz</a></li>
</ul>

