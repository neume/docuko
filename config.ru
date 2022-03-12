# This file is used by Rack-based servers to start the application.

# Supress ruby deprecation warnings
# This is for these warnings:
# - warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
# - warning: The called method `<method>' is defined here
Warning[:deprecated] = false
# TODO: remove this when all of the gems have caught up with the warnings

require_relative 'config/environment'

run Rails.application
Rails.application.load_server
