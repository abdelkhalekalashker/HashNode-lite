# Use the Ruby 3.0.1 base image
FROM ruby:3.0.1

# Install dependencies
RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g yarn

# Set the working directory
WORKDIR /myapp

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application
COPY . .

# Install JavaScript dependencies
RUN yarn install


# Expose ports for web and Action Cable
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
