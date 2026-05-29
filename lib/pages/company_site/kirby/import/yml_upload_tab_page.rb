# frozen_string_literal: true

module CompanySite
  class ImportYMLPage
    class UploadTab < self
      MOVING = %i[none keep delete archive].freeze

      # Текстовая зона для бесплатных компаний на странице загрузки товаров
      div(:star_suggestion_tab_upload, css: '.upload-main-block .star-link-suggestion')
      # Тектовая зона инструкция и помощь по импорту
      div(:text_zone_import, css: '.yml-textzones .yml-import-textzone')
      # Тектовая зона когда включен мультиимпорт
      div(:text_zone_multi_import, css: '.yml-textzones .multi-import-text-zone .attention-message')
      # Текстовая зона когда включено на автообновление
      div(:text_zone_autoupdate, css: '.yml-textzones .text-notification')
      # Текстовая зона когда настроен импорт из 1С
      div(:text_zone_1c, css: '.yml-textzones .text-notification')
      # Текстовая зона когда есть национальная валюта
      div(:text_zone_currency, css: '.yml-textzones .invalid-currency .warning')

      # Загрузка товаров, ссылка на последний загруженный файл
      div(:upload_products_title, xpath: "//div[normalize-space()='Загрузка товаров' and @class='tab-title']")
      div(:upload_products_hint, xpath:
          '//div[normalize-space()="Загрузка товаров"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      link(:download_last_file, css: '.upload-tab-header .custom-yml-link')

      # Включение мультиимпорта
      span(:multi_import_label, css: '.enable-milti-import-text')
      link(:multi_import_toggle, css: '.multi-import-toggler .apress-button')

      # Включение импорта на компании-дубли
      label(:regional_prices_label, css: '.upload-different-pices-label')
      link(:regional_prices_toggle, css: '.regional-prices-toggler-link .apress-button')

      # Элементы источника - Ссылка
      link(:switch_to_source_url, css: '[data-upload-type="url"] a')
      label(:source_url_label, xpath: "//label[normalize-space()='Ссылка']")
      text_field(:source_url, css: '.js-url-field')
      div(:source_url_validation_message, css: '#switcher-tabs-1 .js-validation-message')

      # Элементы источника - Файл
      link(:switch_to_source_file, css: '[data-upload-type="file"] a')
      div(:upload_field, css: '.upload-field')
      div(:icon_file, css: '.aui-admin-file-icon')
      span(:name_file, css: '.yml-file-name')
      span(:size_file, css: '.yml-file-size')
      span(:edit_file, css: '.edit-chosen-file')
      span(:delete_file, css: '.remove-chosen-file')
      file_field(:upload_file, css: '.js-file-field')

      # Информация о последнем импорте
      div(:import_info_url, css: '#switcher-tabs-1 .yml-dates-info')
      div(:irrelevant_feed_url, css: '#switcher-tabs-1 .yml-dates-info .irrelevant-import-message')
      div(:import_info_file, css: '#switcher-tabs-2 .yml-dates-info')
      div(:irrelevant_feed_file, css: '#switcher-tabs-2 .yml-dates-info .irrelevant-import-message')

      # Ошибки импорта
      div(:errors_import_alert, css: '.errors-tab-link-box')
      link(:errors_tab_link, css: '.js-open-errors-tab')

      # Формат
      label(:source_type_label, xpath: "//label[(normalize-space()='Формат:')]")
      select_list(:source_type, css: '#online_store_source_type')

      # Сайт магазина
      label(:store_url_label, xpath: "//label[(text()='Сайт магазина:')]")
      text_field(:store_url, css: '#online_store_store_url')

      # Приоритетность загрузки прайса на компании дубли
      label(:upload_priority_label, xpath: "//label[(text()='Приоритетность загрузки/обновления')]")
      text_field(:upload_priority, css: '#copy_priority')

      # Размещенные на сайте товары
      label(:recent_products_title, xpath: "//label[normalize-space()='Размещённые на сайте товары']")
      div(:recent_products_hint, xpath:
          '//label[normalize-space()="Размещённые на сайте товары"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:current_products_label, xpath: "//label[(text()='Текущие товары на сайте')]")
      link(:moving_no, css: 'a[href="#switcher-tabs-3"]')
      link(:moving_yes, css: 'a[href="#switcher-tabs-4"]')

      MOVING.each do |type|
        select("moving_#{type}", xpath: "//select[@id='moving']//option[@value='#{type}']")
      end

      # Выбор групп
      label(:choice_groups_title, xpath: "//label[normalize-space()='Выбор групп']")
      div(:choice_groups_hint, xpath:
          '//label[normalize-space()="Выбор групп"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:upload_from_groups_label, css: '.yml-groups-settings__toggler-label')
      div(:upload_from_groups_toggle, css: '.js-yml-groups-settings__toggler')

      # Блок кнопок (сохранение, загрузка прайса и товаров)
      button(:save_upload, css: '.js-yml-upload-buttons .js-yml-save')
      button(:upload, css: '.js-yml-upload-buttons .js-yml-upload')
      button(:upload_groups, css: '.js-yml-upload-buttons .js-yml-groups-upload')
      div(:errors_settings_alert, css: '.yml-upload-buttons .autobind-validation-message')

      def upload_yml(file_path)
        upload_file(upload_file_element, file_path)
      end
    end
  end
end
