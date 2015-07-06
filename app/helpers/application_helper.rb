# Common helper, remember that we have avoid that each controller loads all existent helpers
# this could be a problem when you try to segment your helper methods, however the app
# always loads both ApplicationHelper and <Current>Helper
module ApplicationHelper
  #
  # Devise anywhere session stuff
  #
  def resource_name
    :user
  end

  #
  # expose devise resource for using in another controller
  #
  def resource
    @resource ||= User.new
  end

  #
  # trick for expose devise resource
  #
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
