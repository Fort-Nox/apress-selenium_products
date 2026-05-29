# frozen_string_literal: true

require 'spec_helper'
require 'apress/selenium_products/spec/shared/import/import_yml_page_common_examples'
require 'apress/selenium_products/spec/shared/import/yml_upload_tab_examples'
require 'apress/selenium_products/spec/shared/import/yml_settings_tab_examples'

describe 'Импорт YML: проверка доступа страницы владельцу (платный пакет)',
         feature: 'Импорт YML: проверка доступа страницы владельцу (платный пакет)' do
  before(:all) do
    @import_yml_page = CompanySite::ImportYMLPage.new
    @upload_tab      = CompanySite::ImportYMLPage::UploadTab.new
    @settings_tab    = CompanySite::ImportYMLPage::SettingsTab.new
  end

  context 'когда роль - Владелец' do
    before(:all) { log_in_as(:user) }

    after(:all) do
      log_out
      Page.browser.manage.delete_all_cookies
    end

    context 'когда компания с платным пакетом' do
      before(:all) do
        navigate_to(@import_yml_page.page_url_value,
                    subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
      end

      include_examples 'проверка общих элементов на странице Импорта YML'
      include_examples 'проверка таба "Загрузка товаров" для владельца'
      include_examples 'проверка таба "Расширенные настройки" для владельца (платный пакет)'
    end
  end
end
