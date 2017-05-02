FROM ruby:2.3-slim
# Docker images can start off with nothing, but it's extremely
# common to pull in from a base image. In our case we're pulling
# in from the slim version of the official Ruby 2.3 image.
#
# Details about this image can be found here:
# https://hub.docker.com/_/ruby/
#
# Slim is pulling in from the official Debian Jessie image.
#
# You can tell it's using Debian Jessie by clicking the
# Dockerfile link next to the 2.3-slim bullet on the Docker hub.
#
# The Docker hub is the standard place for you to find official
# Docker images. Think of it like GitHub but for Docker images.

# originally by Nick Janetakis from the orats project
MAINTAINER Simon Bacquie <simonblah@gmail.com>

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      curl git tmux python-pip python-dev
      # curl software-properties-common python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash
# RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev postgresql-client-9.4
RUN pip install pgcli
# make sure we have the latest Bundler to avoid coderay issues
RUN gem install bundler

# Ensure that our apt package list is updated and install a few
# packages to ensure that we can compile assets (nodejs) and
# communicate with PostgreSQL (libpq-dev).

ENV INSTALL_PATH /railstraining2
# The name of the application is railstraining2 and while there
# is no standard on where your project should live inside of the Docker
# image, I like to put it in the root of the image and name it
# after the project.
#
# We don't even need to set the INSTALL_PATH variable, but I like
# to do it because we're going to be referencing it in a few spots
# later on in the Dockerfile.
#
# The variable could be named anything you want.

RUN mkdir -p $INSTALL_PATH
# This just creates the folder in the Docker image at the
# install path we defined above.

WORKDIR $INSTALL_PATH
# We're going to be executing a number of commands below, and
# having to CD into the /railstraining2 folder every time would be
# lame, so instead we can set the WORKDIR to be /railstraining2.
#
# By doing this, Docker will be smart enough to execute all
# future commands from within this directory.

COPY Gemfile Gemfile.lock ./
# This is going to copy in the Gemfile and Gemfile.lock from our
# work station at a path relative to the Dockerfile to the
# railstraining2/ path inside of the Docker image.
#
# It copies it to /railstraining2 because of the WORKDIR being set.
#
# We copy in our Gemfile before the main app because Docker is
# smart enough to cache "layers" when you build a Docker image.
#
# You see, each command we have in the Dockerfile is going to be
# ran and then saved as a separate layer. Docker is smart enough
# to only re-build pieces that change, in order from top to bottom.
#
# This is an advanced concept but it means that we'll be able to
# cache all of our gems so that if we make an application code
# change, it won't re-run bundle install unless a gem changed.

RUN bundle install --binstubs
# We want binstubs to be available so we can directly call sidekiq and
# potentially other binaries as command overrides without depending on
# bundle exec.
# This is mainly due for production compatibility assurance.

COPY . .
# This might look a bit alien but it's copying in everything from
# the current directory relative to the Dockerfile, over to the
# /railstraining2 folder inside of the Docker image.
#
# We can get away with using the . for the second argument because
# this is how the unix command cp (copy) works. It stands for the
# current directory.

# RUN (cd frontend && bower install && npm install)

RUN bundle exec rake RAILS_ENV=development DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname ACTION_CABLE_ALLOWED_REQUEST_ORIGINS=foo,bar SECRET_TOKEN=dummytoken assets:precompile
# Provide a dummy DATABASE_URL and more to Rails so it can pre-compile
# assets. The values do not need to be real, just valid syntax.
#
# If you're saving your assets to a CDN and are working with multiple
# app instances, you may want to remove this step and deal with asset
# compilation at a different stage of your deployment.

VOLUME ["$INSTALL_PATH/public"]
# In production you will very likely reverse proxy Rails with nginx.
# This sets up a volume so that nginx can read in the assets from
# the Rails Docker image without having to copy them to the Docker host.

# *** THIS IS CONFUSING, MOVE IT INTO DOCKER COMPOSE WEB COMMAND ***
CMD puma -C config/puma.rb
# This is the command that's going to be ran by default if you run the
# Docker image without any arguments.
#
# In our case, it will start the Puma app server while passing in
# its config file.
