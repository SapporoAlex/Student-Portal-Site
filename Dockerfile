# Use the official Ruby image
FROM ruby:3.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn

# Set the working directory in the container
WORKDIR /app

# Add Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN bundle install

RUN apt-get update && apt-get install -y postgresql-client

# Copy the application code
COPY . .

# Precompile assets for production
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Expose port 3000 to run the Rails server
EXPOSE 3000

# Run the server (entrypoint is overridden in docker-compose.yml)
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]