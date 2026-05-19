# frozen_string_literal: true

module CompanySite
  class ImportYMLPage < Page
    page_url '/admin/import_yml/edit'
    expected_title %r{Загрузка товаров из YML\/YRL - .+-.+}

    h1(:header, css: '.company-admin-page-header h1')
    link(:upload_tab, css: 'a[href="#upload"]')
    link(:settings_tab, css: 'a[href="#settings"]')
    link(:errors_tab, css: 'a[href="#errors"]')
    li(:upload_tab_link, css: '.js-upload-tab-link')
    li(:settings_tab_link, css: '.js-settings-tab-link')

    def wait_for_upload_tab_active
      wait_until(2) { upload_tab_link_element.attribute('class').include?('ui-state-active') }
    end

    def wait_for_settings_tab_active
      wait_until(2) { settings_tab_link_element.attribute('class').include?('ui-state-active') }
    end
  end
end
