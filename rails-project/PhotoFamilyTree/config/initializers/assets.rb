# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( relative_tile.scss.css )
Rails.application.config.assets.precompile += %w( relatives.scss.css )
Rails.application.config.assets.precompile += %w( relative_show.scss.css )
Rails.application.config.assets.precompile += %w( relative_event_timeline.scss.css )
Rails.application.config.assets.precompile += %w( memory_tile.scss.css )
Rails.application.config.assets.precompile += %w( memory_show.scss.css )
Rails.application.config.assets.precompile += %w( generic_button.scss.css )
Rails.application.config.assets.precompile += %w( photo_tile.scss.css )
Rails.application.config.assets.precompile += %w( photos.scss.css )
Rails.application.config.assets.precompile += %w( photo_show.scss.css )
