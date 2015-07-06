# Controller for testing purpose
class WelcomeController < ApplicationController
  # Index page for the app
  def index
  end

  # Ping action for testing purpose, also it could be used in new relic monitoring
  def ping
    respond_to do |format|
      format.html { render text: 'pong!' }
    end
  end
end
