require 'redcarpet'
require 'contentful_model'

require 'contentful_rails/engine'
require 'contentful_rails/development_constraint'
require 'contentful_rails/caching/timestamps'
require 'contentful_rails/markdown_renderer'
require 'contentful_rails/nested_resource'
require 'contentful_rails/sluggable'
require 'contentful_rails/preview'

# A collection of useful things to help make it easier to integrate Contentful into your Rails app.
# It includes view helpers, a Webhook handler, caching, and a Rails Engine to hook it all together.
module ContentfulRails
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Configuration accessors
  class Configuration
    attr_accessor :authenticate_webhooks,
                  :webhooks_username,
                  :webhooks_password,
                  :slug_delimiter,
                  :perform_caching,
                  :access_token,
                  :preview_access_token,
                  :management_token,
                  :environment,
                  :space,
                  :default_locale,
                  :contentful_options,
                  :preview_username,
                  :preview_password,
                  :preview_domain,
                  :enable_preview_domain,
                  :eager_load_entry_mapping

    def initialize
      @authenticate = true
      @slug_delimiter = '-'
      @environment = 'master'
      @default_locale = 'en-US'
      @perform_caching = Rails.configuration.action_controller.perform_caching
      @eager_load_entry_mapping = true
      @contentful_options = {}
    end
  end
end

ActiveRecord::Migration.send(:include, ContentfulModel::Migrations::Migration)
