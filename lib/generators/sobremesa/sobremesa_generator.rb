# frozen_string_literal: true

# SobremesaGenerator
# Generate locales to active_record, views and controllers
class SobremesaGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :languages, type: :array, default: ['es-PE']
  argument :attributes, type: :array, default: [], banner: 'field:type field:type'

  def gen_init
    @modules = Array(regular_class_path)
    options.languages.each do |language|
      @language = language
      ask_labels unless behavior == :revoke
      locales_types.each do |locales_type|
        create_locales(locales_type, language)
      end
    end
  end

  private

  def create_locales(locales_type, language)
    dir = "#{locales_dir(locales_type)}/#{language}.yml"
    template_path = "#{locales_type}/#{language}.template"
    template template_path, dir
  end

  def locales_types
    %w[active_record controller views]
  end

  def locales_dir(type)
    ['config', 'locales', type, @modules, file_name.pluralize.underscore].flatten.compact.join('/')
  end

  def ask_labels
    @dic = {
      singular: ask('[singular_model]:'),
      plural: ask('[plural_model]:'),
      art: ask('[art]:'),
      dart: ask('[dart]:'),
      termination: ask('[a/o/e]')
    }
    @dic[:art_singular] = "#{@dic[:art]} #{@dic[:singular]}"
    @dic[:dart_singular] = "#{@dic[:dart]} #{@dic[:singular]}"
    ask_attributes
  end

  def ask_attributes
    @dic[:attributes] = {}
    attributes.each do |attribute|
      @dic[:attributes][attribute.name] = ask("#{attribute.name}: ")
    end
    @dic[:attributes]
  end
end
