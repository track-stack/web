# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    js: :js,
    html: :html,
  }

  rails_view_exts = %w(erb)

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end

guard :rspec, cmd: "bundle exec rspec", all_after_pass: false do
  # with Minitest::Unit
  watch(%r{^spec/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "spec/#{m[1]}spec_#{m[2]}.rb" }
  watch(%r{^spec/spec_helper\.rb$})      { 'spec' }

  # Rails 4
  watch(%r{^app/(.+)\.rb$})                               { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'spec/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "spec/integration/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "spec/mailers/#{m[1]}_mailer_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
end
