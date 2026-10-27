# name: discourse-categories
# about: Info about count posts in topics categories
# version: 0.4
# authors: Ascensio System SIA

enabled_site_setting :discourse_categories_enabled

PLUGIN_NAME ||= "onlyoffice-discourse-categories".freeze

after_initialize do
    module ::OnlyofficeDiscourseCategories
        class Engine < ::Rails::Engine
            engine_name PLUGIN_NAME
            isolate_namespace OnlyofficeDiscourseCategories
        end
    end
end