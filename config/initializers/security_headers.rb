::SecureHeaders::Configuration.configure do |config|

  # Strict Transport Security
  # is a security feature that lets a web site tell browsers that it should only be communicated with using HTTPS, instead of using HTTP.
  # - Browser compatibility:
  #   IE: 11
  #   Chrome: > 4
  #   Firefox: > 4
  #   Opera: 12
  #   Safari: 7
  # see more info here:
  # https://goo.gl/ldjc5h
  config.hsts = if Rails.env.production?
    {
      # The time, in seconds, that the browser should remember that this site is only to be accessed using HTTPS.
      :max_age => 20.years.to_i,
      # If this optional parameter is specified, this rule applies to all of the site's subdomains as well.
      :include_subdomains => true
    }
  else
    false
  end

  # Prevents your content from being framed and potentially clickjacked
  config.x_frame_options = 'DENY'
  # Prevent content type sniffing
  # This is a security feature that helps prevent attacks based on MIME-type confusion.
  config.x_content_type_options = "nosniff"
  # Cross site scripting heuristic filter for IE/Chrome
  config.x_xss_protection = {:value => 1, :mode => 'block'}
  # Prevent file downloads opening
  config.x_download_options = 'noopen'
  # Restrict Adobe Flash Player's access to data
  config.x_permitted_cross_domain_policies = 'none'

  # Content Security Policy
  # is an added layer of security that helps to detect and mitigate certain types of attacks, including Cross Site Scripting (XSS) and data injection attacks.
  # These attacks are used for everything from data theft to site defacement or distribution of malware.
  # - Browser compatibility:
  #   IE: Edge
  #   Chrome: > 25
  #   Firefox: > 24
  #   Opera: 15
  #   Safari: 7
  # see more info here:
  # https://goo.gl/u23dit
  # https://goo.gl/wHC9C5
  # https://goo.gl/Z8UvAz
  config.csp = {
    # It's often valuable to send extra information in the report uri that is not available in the reports themselves. Namely, "was the policy enforced"
    # and "where did the report come from"
    :app_name => "rails_foo", # do not use spaces here
    :tag_report_uri => true,
    :enforce => true,
    # The default-src directive defines the security policy for types of content which are not expressly called out by more specific directives.
    :default_src => "https: self inline eval",
    # The frame-src directive specifies valid sources for web workers and nested browsing contexts loading using elements such as <frame> and <iframe>.
    :frame_src => "https: http:.twimg.com http://itunes.apple.com", # just an example
    # The img-src directive specifies valid sources of images and favicons.
    :img_src => "https:",
    # allows a browser to send reports back to the host if their security policy was breached
    # :report_uri => '/uri-directive'
    :report_uri => Rails.application.secrets.report_uri
  }

  # Public Key Pinning
  # The Public Key Pinning Extension for HTTP (HPKP) is a security feature that tells a web client to associate a specific cryptographic
  # public key with a certain web server to prevent MITM attacks with forged certificates.
  # - Browser compatibility:
  #   IE: ?
  #   Chrome: > 38
  #   Firefox: > 35
  #   Opera: ?
  #   Safari: ?
  # - Server Compatibility
  #   NGNIX: Adding the following line and inserting the appropriate pin-sha256="..." values will enable HPKP on your nginx. This requires the ngx_http_headers_module.
  #   Apache: Adding a line similar to the following to your webserver's config will enable HPKP on your Apache. This requires mod_headers enabled.
  # see more info here:
  # https://goo.gl/yrx3ex
  # http://goo.gl/zFnaaW
  config.hpkp = {
    # The time, in seconds, that the browser should remember that this site is only to be accessed using one of the pinned keys.
    :max_age => 60.days.to_i,
    # If this optional parameter is specified, this rule applies to all of the site's subdomains as well.
    :include_subdomains => true,
    # allows a browser to send reports back to the host if their security policy was breached
    :report_uri => Rails.application.secrets.report_uri,
    # The quoted string is the Base64 encoded Subject Public Key Information (SPKI) fingerprint. It is possible to specify multiple pins
    # for different public keys. Some browsers might allow other hashing algorithms than SHA-256 in the future.
    :pins => [
      {:sha256 => 'abc'},
      {:sha256 => '123'}
    ]
  }
end
