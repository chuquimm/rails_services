# frozen_string_literal: true

# TranslatorGenerator
class TranslatorGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :languages, type: :array, default: ['es-PE']
  argument :attributes, type: :array, default: [], banner: 'field:type field:type'

  def gen_init
    @modules = Array(regular_class_path)
    options.languages.each do |language|
      @language = language
      locales_types.each do |locales_type|
        dir = "#{locales_dir(locales_type)}/#{language}.yml"
        template_path = "#{locales_type}/#{language}.template"
        template template_path, dir
        ask_labels
      end
    end
  end

  private

  def locales_types
    %w[active_record controller views]
  end

  def locales_dir(type)
    ['config', 'locales', type, @modules, file_name.pluralize.underscore].flatten.compact.join('/')
  end

  def ask_labels
    # a = ask('Holaaa')
  end
end
