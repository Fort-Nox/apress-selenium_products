# frozen_string_literal: true

require 'spec_helper'
require 'apress/selenium_products/spec/shared/import/import_yml_page_common_examples'

describe 'Импорт YML: проверка доступа страницы пользователям',
         feature: 'Импорт YML: проверка доступа страницы пользователям' do
  before(:all) do
    @import_yml_page = CompanySite::ImportYMLPage.new
    @upload_tab      = CompanySite::ImportYMLPage::UploadTab.new
  end

  context 'когда авторизованный пользователь' do
    before do
      log_in_as(:empty_user)
      navigate_to(@import_yml_page.page_url_value, subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    after(:all) do
      log_out
      Page.browser.manage.delete_all_cookies
    end

    it('нет доступа к просмотру и редактированию - 403 код') do
      expect(error_403?).to be true
      expect(@import_yml_page.text).to include 'У Вас недостаточно прав для просмотра данной страницы.'
    end
  end

  context 'когда неавторизованный пользователь' do
    before do
      Page.browser.manage.delete_all_cookies
      navigate_to(@import_yml_page.page_url_value, subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    it('произойдет редирект на страницу авторизации') { expect(Page.current_url).to include '/users/session/new' }
  end

  context 'когда роль - Франшиза (из другого региона)' do
    before(:all) do
      log_in_as(:franchise_kz)
      navigate_to(@import_yml_page.page_url_value, subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    after(:all) do
      log_out
      Page.browser.manage.delete_all_cookies
    end

    context 'когда на вкладке "Загрузить товары"' do
      before(:all) { @import_yml_page.upload_tab }

      it 'не отобразятся кнопки сохранения и загрузки' do
        expect(@upload_tab.save_upload_not_exists?).to be true
        expect(@upload_tab.upload_not_exists?).to be true
        expect(@upload_tab.upload_groups_not_exists?).to be true
      end
    end
  end
end
