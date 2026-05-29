# frozen_string_literal: true

module CompanySite
  class ExportPage
    class XLSTab < self
      # Выгрузка товаров
      h4(:xls_products_title, xpath: "//h4[normalize-space()='Выгрузить товары в формате Excel (XLS)']")
      link(:sample_products, css: 'a[href="/help/import/xls/sample.xlsx"]')
      div(:status_products_label, xpath: "//div[normalize-space()='Выгрузить товары с сайта:']")
      select(:status_products, css: '.js-export-xls-type')
      div(:from_date_products_label, xpath:
          "//form[contains(@class, 'js-export-xls-form')]//div[normalize-space()='С даты создания:']")
      select(:from_date_product, css: '.js-export-xls-created-since')
      div(:by_date_products_label, xpath:
          "//form[contains(@class, 'js-export-xls-form')]//div[normalize-space()='По дату создания:']")
      select(:by_date_product, css: '.js-export-xls-created-till')
      #   Группы
      checkbox(:products_from_groups, css: '#export_filtered_group')
      checkbox(:exception_groups, css: '.js-export-xls-exclude-product-group-ids-checkbox')
      div(:groups_tree, css: '.js-export-xls-groups-tree')
      #   Рубрики
      checkbox(:products_from_rubrics, css: '#export_filtered_rubric')
      checkbox(:exception_rubrics, css: '.js-export-xls-exclude-rubric-ids-checkbox')
      div(:rubrics_tree, css: '.js-export-rubrics-tree')
      checkbox(:images_from_portal, css: '#portal_img_url')
      checkbox(:expired_discount, css: '#expired_discounts')
      button(:unload_products, css: '[value="Выгрузить товары"]')

      # Выгрузка групп
      h4(:xls_groups_title, xpath: "//h4[normalize-space()='Выгрузить группы в формате Excel (XLS)']")
      link(:sample_groups, css: 'a[href="/help/import/xls/sample_groups.xlsx"]')
      div(:status_groups_label, xpath: "//div[normalize-space()='Выгрузить группы с сайта']")
      div(:from_date_groups_label, xpath:
          "//form[contains(@class, 'js-export-xls-categories-form')]//div[normalize-space()='С даты создания:']")
      div(:by_date_groups_label, xpath:
          "//form[contains(@class, 'js-export-xls-categories-form')]//div[normalize-space()='По дату создания:']")
      button(:unload_groups, css: '[value="Выгрузить группы"]')
    end
  end
end
