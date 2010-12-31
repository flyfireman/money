# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_money_session',
  :secret      => '657e786688631b58508fcd147895b04feee7ef46907bf347509bd22beb216fc8c1b95a7d75c06e7a79d40f786a37b6d8ee98c71dd2a97fe099ab26f5c4d3b77e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
