# frozen_string_literal: true

module CompanySite
  class ExportPage < Page
    page_url '/admin/export'
    expected_title(/Выгрузить товары в Excel, YML - .+-.+/)

    # YML
    h1(:header, css: '.company-admin-page-header h1')
    div(:yml_text_zone, css: '.export-yml-hint-text')
    h3(:yml_tab_title, css: '.company-admin-form-links-block_yml h3')
    div(:count_yml_export, css: '.company-admin-form-links-block-title div')
    div(:yml_tab, css: '.js-show-yml-export')
    div(:add_yml_export, css: '.js-new-yml-export')

    # XLS
    div(:xls_text_zone, css: '.export-xls-hint-text')
    h3(:xls_tab_title, css: '.company-admin-form-links-block_xls h3')
    div(:xls_tab, css: '.js-show-xls-export')

    div(:progressbar, css: '.progress-bar-container')

    def wait_export_progressbar
      wait_until?(10) { progressbar_not_exists? }
    end
  end
end
