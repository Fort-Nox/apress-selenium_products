# frozen_string_literal: true

require 'spec_helper'
require 'apress/selenium_products/spec/shared/export/export_page_common_examples'
require 'apress/selenium_products/spec/shared/export/export_yml_tab_examples'

shared_context 'роль с повышенными правами' do |role, name|
  context "когда роль - #{name}" do
    before(:all) do
      log_in_as(role)
      navigate_to(@export_page.page_url_value,
                  subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    after(:all) do
      log_out
      Page.browser.manage.delete_all_cookies
    end

    context 'когда проверяем страницу экспорта' do
      include_examples 'проверка общих элементов на странице Экспорта YML/XLS'
      include_examples 'проверка таба "YML" для редактирующих ролей', role
    end
  end
end

shared_context 'роль с повышенными правами в расширенном экспорте' do |role, name|
  context "когда роль - #{name}" do
    before(:all) do
      log_in_as(role)
      navigate_to(@export_page.page_url_value,
                  subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    after(:all) do
      log_out
      Page.browser.manage.delete_all_cookies
    end

    context 'когда проверяем страницу экспорта' do
      include_examples 'проверка общих элементов на странице Экспорта YML/XLS'
      include_examples 'проверка таба "YML" для редактирующих ролей. Расширенный экспорт', role
    end
  end
end

describe 'Экспорт YML: проверка доступа страницы редактирующим ролям',
         feature: 'Экспорт YML: проверка доступа страницы редактирующим ролям' do
  before(:all) do
    @admin_menu           = Admin::Menu.new
    @admin_companies_page = Admin::CompaniesPage.new
    @export_page          = CompanySite::ExportPage.new
    @yml_tab              = CompanySite::ExportPage::YMLTab.new
  end

  include_context 'роль с повышенными правами', :admin, 'Суперюзер'
  include_context 'роль с повышенными правами', :editor, 'Редактор СК'
  include_context 'роль с повышенными правами', :franchise_ru, 'Франшиза (регион компании)'

  context 'когда переходим в админку и в свойствах пакета подключаем расширенный экспорт' do
    before(:all) do
      log_in_as(:admin)
      navigate_to_admin_page
      @admin_menu.companies
      @admin_companies_page.extended_export_on
    end

    after(:all) do
      log_in_as(:admin)
      navigate_to_admin_page
      @admin_menu.companies
      @admin_companies_page.extended_export_off
    end

    it 'чекбокс "Расширенный экспорт" активен' do
      expect(@admin_companies_page.extended_export_checked?).to be true
    end

    context 'когда после включения расширенного экспорта' do
      include_context 'роль с повышенными правами в расширенном экспорте', :admin, 'Суперюзер'
      include_context 'роль с повышенными правами в расширенном экспорте', :editor, 'Редактор СК'
      include_context 'роль с повышенными правами в расширенном экспорте', :franchise_ru, 'Франшиза (регион компании)'
    end
  end
end
