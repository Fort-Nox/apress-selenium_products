# frozen_string_literal: true

require 'spec_helper'
require 'apress/selenium_products/spec/shared/page_common_examples'
require 'apress/selenium_products/spec/shared/upload_tab_examples'
require 'apress/selenium_products/spec/shared/settings_tab_examples'

shared_context 'роль с повышенными правами' do |role, name|
  context "когда роль - #{name}" do
    before(:all) do
      log_in_as(role)
      navigate_to(@import_yml_page.page_url_value,
                  subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    after(:all) do
      log_out
      Page.browser.manage.delete_all_cookies
    end

    include_examples 'проверка общих элементов на странице Импорта YML'
    include_examples 'проверка таба "Загрузка товаров" для редактирующих ролей', role
    include_examples 'проверка таба "Расширенные настройки" для редактирующих ролей', role
  end
end

describe 'Импорт YML: проверка доступа страницы редактирующим ролям',
  feature: 'Импорт YML: проверка доступа страницы редактирующим ролям' do
  before(:all) do
    @import_yml_page = CompanySite::ImportYMLPage.new
    @upload_tab      = CompanySite::ImportYMLPage::UploadTab.new
    @settings_tab    = CompanySite::ImportYMLPage::SettingsTab.new
  end

  include_context 'роль с повышенными правами', :admin, 'Суперюзер'
  include_context 'роль с повышенными правами', :editor, 'Редактор СК'
  include_context 'роль с повышенными правами', :franchise_ru, 'Франшиза (регион компании)'
end
