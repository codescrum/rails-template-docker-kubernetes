# README #

# RAILS TEMPLATE - (RAILS FOO)

Base template for deploying Rails applications

## ESSENTIAL VERSIONS

  - Ruby 2.2.0

  - Rails 4.2.2

  - Mongoid 4.0.2

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
We are using a combined strategy between [secrets](http://guides.rubyonrails.org/4_1_release_notes.html#config-secrets-yml) and [dotenv](https://github.com/bkeepers/dotenv) approaches, you can use a similar approach like Figaro, in fact after almost two years there is still a little discussion about what is the better approach for managing your settings and sensitive information (there is an interesting post from Figaro creator [here](http://www.collectiveidea.com/blog/archives/2013/12/18/the-marriage-of-figaro-and-rails/)).

Finally, these are our conclusions about the selected approach:

- Always gitignore your settings files (at least that this does not contain *polymorphic* and *sensitive data* -  but it would be an odd case)
- It is great that our settings can be managed using a rich object support, it give us a convenient way for controlling and structuring our information using a set-based approach, at the end we will have a better strategy for organizing our config data.
- In order to be compliant with the [config section](http://12factor.net/config) in the [twelve factor app](http://12factor.net/) methodology, we also can use ENV variables whenever necessary. `config/secrets.yml` as other YAML files in Rails is passed first through ERB, this behaviour give us the chance for configuring our ENV settings using dotenv approach which allows to load environment variables from .env into ENV in the configured environments.
- Keeping an easy deployment is a priority, and it is clear that using an ENV approach seems to cover this concern, but you can obtain the benefits of an hybrid solution by using a rich object support and ENV approach. Our experience has taught us that the sensitive data and the external integration credentials is a real concern for both the staging and production envs (especially for scenarios with limited control as Heroku), however you can manage this responsibility with ease, in your own servers you always can use capistrano (or similar solutions) for automating the remotely settings installation (secrets.yml) for every application server (this process is still missing in this template, but in the future it will be included). On the other hand, you also can configure your application so that it’s compliant with Heroku, it is enough by adding a little deployment hack, you can see this at the end of `config/application.rb` file (remember that the secrets file is gitignored).
- One of the most important thing in our context is the ‘convention over configuration’ fact, and **secrets** is the default approach (and convention) for managing the sensitive info in the Rails community
- Secure defaults, the new convention has agreed that the `secret_key_base` (used to verify the integrity of signed cookies) will be stored in the **secrets** file, you can see more info [here](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml) and [here](http://stackoverflow.com/questions/25426940/what-is-the-use-of-secret-key-base-in-rails-4)

#### Dotenv ([GITHUB REPO](https://github.com/bkeepers/dotenv))
You can use this integration for configuring your environment variables in the app environment you desire. For now the template has an `.env.example` in which you can establish a common structure for your ENVs, then you can integrate this declarations into the secrets file using an ERB definition: `secret_cat_key: <%= ENV["SECRET_CAT_KEY"] %>`

### TESTING
segregate support modules
### FRONTEND
### DEBUGGING
### PERFORMANCE
### CODE QUALITY
### MISC
autoloading lib
just one helper
