class StyleguideController < ActionController::Base
  before_action do
    @sections = {}
    Dir.entries(Rails.root.join('app', 'views', 'styleguide')).reject { |p| p.match(/[_\.]/) }
      .each do |section|
      @sections[section] =
        Dir.entries(Rails.root.join('app', 'views', 'styleguide', section)).reject do |p|
          p.match(/^_/).nil?
        end
          .map { |p| p[/(?<=_)\w*?(?=\.)/] }
    end
    @current_section = (params[:section] ? params[:section] : 'general')
  end
end
