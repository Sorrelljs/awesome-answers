class WelcomeController < ApplicationController
    # instance methods inside controllers are called actions
    # "index" is an "action "
    def index
        # Use render to render a template. By default, it looks in the app/views directory.
        # There's no need to append the extension because Rails knows to use erb as our 
        # templating engine
        # The line below is not needed because by default, Rails will render a template
        # within the views directory. It will look for a directory named after 
        # the controller, and look for a file that's named after the action name (index in this case)
        # render "welcome/index"
    end
end
