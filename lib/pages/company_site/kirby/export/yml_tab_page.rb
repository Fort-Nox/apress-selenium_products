# frozen_string_literal: true

module CompanySite
  class ExportPage
    class YMLTab < self
      SERVICE_LABELS = %w[
        premium new_unic new_unic_copywriting new_unic_locomotiv
        short_desc long_desc old_unic to_uniqueize to_copywriting
        describe_locomotiv old_locomotive to_be_processed
        description_processed description_processed_and_seo
        product_finalized processed_old_products infographics
        seo_pro_processed seo_pro_processed_2 seo_pro_processed_3
      ].freeze

      span(:export_yml_title, css: '.export-yml-form-title-name')
      span(:updated_at, css: '.export-yml-form-title span:last-child')

      # Ссылка на файл
      div(:url_title, xpath: "(//div[@class='export-yml-form-row-left']//div[normalize-space()='Ссылка на файл'])[1]")
      text_field(:url_yml, xpath: "(//input[contains(@class, 'js-export-yml-file-link')])[1]")
      div(:count_products, xpath: "(//div[@class='yml-exported-products-count'])[1]")
      div(:copy_url_yml, xpath: "(//div[contains(@class, 'js-export-yml-file-clipboard')])[1]")

      # Название
      div(:name_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Название']")
      text_field(:name, css: '#name')
      div(:error, css: 'export-yml-name-input-warning')

      # Тип выгрузки
      div(:type_unload_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Тип выгрузки']")
      element(:label, xpath: "//input[@id='use_product_yml_ids']/../text()[normalize-space()]")
      checkbox(:unload_products_external_ids, css: '#use_product_yml_ids')
      checkbox(:unload_groups_internal_ids, css: '#use_internal_ids')
      checkbox(:unload_additional_tags, css: '#use_additional_tags')
      checkbox(:unload_announce_to_description, css: '#export_short_description')
      checkbox(:unload_announce_to_short_description, css: '#export_yamaps_description')
      checkbox(:unload_exact_price, css: '#only_exact_or_discount_price')
      checkbox(:unload_different_price, css: '#export_without_price')
      checkbox(:unload_wholesale_price, css: '#export_with_wholesale_price')
      checkbox(:unload_pct_to_url, css: '#export_with_portal_url')
      checkbox(:unload_unique_photo, css: '#export_with_unique_photo')
      checkbox(:not_unload_declined, css: '#export_without_declined')
      checkbox(:not_unload_undecided, css: '#export_without_undecided')
      checkbox(:not_unload_with_photo, css: '#export_with_photo')
      checkbox(:not_unload_empty_groups, css: '#export_without_empty_groups')
      checkbox(:not_unload_store_pickup_tags, css: '#export_without_store_pickup')
      checkbox(:not_unload_delivery_tag, css: '#export_without_delivery')
      checkbox(:unload_name_portal, css: '#export_behalf_of_portal')
      checkbox(:unload_with_infographics, css: '#export_without_infographics')

      # Наличие товаров
      div(:exists_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Наличие товаров']")
      checkbox(:available, css: '#exists_available')
      checkbox(:not_available, css: '#exists-not-available')
      checkbox(:order, css: '#exists-order')
      checkbox(:awaiting, css: '#exists-awaiting')
      checkbox(:not_specified, css: '#exists-not-specified')

      # Экспортировать
      div(:export_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Экспортировать']")
      div(:all_groups, css: '.js-export-yml-group-tree-all')

      div(:selected_groups, css: '.js-export-yml-group-tree-checked')
      div(:notice_groups, css: '.export-yml-form-group-hint-text')
      checkbox(:exception_groups, css: '.js-export-yml-exclude-product-group-ids')
      div(:groups_tree, css: '.js-export-yml-groups-tree')

      div(:selected_rubrics, css: '.js-export-yml-rubric-tree-checked')
      div(:notice_rubrics, css: '.export-yml-form-rubric-hint-text')
      checkbox(:exception_rubrics, css: '.js-export-yml-exclude-rubric-ids')
      div(:rubrics_tree, css: '.js-export-yml-rubrics-tree')

      # Служебные метки
      div(:service_labels_title, xpath:
          "//div[@class='export-yml-form-row-left']//div[normalize-space()='Служебные метки']")
      div(:all_products, xpath: "//div[normalize-space()='Все товары']")
      div(:with_service_labels, xpath: "//div[normalize-space()='С метками']")

      # Характеристики
      div(:user_traits_title, xpath:
          "//div[@class='export-yml-form-row-left']//div[normalize-space()='Характеристики']")
      div(:add_user_traits_filter, css: '.export-yml-form-add-filter-plus')
      div(:traits_name_label, css: '.company-traits-filter-titles-name')
      text_field(:trait_name, css: '.js-yml-company-trait')
      div(:traits_value_label, css: '.company-traits-filter-titles-value')
      text_field(:trait_value, css: '.js-yml-company-trait-values')
      span(:delete_user_traits_filter, css: '.js-delete-company-trait-filter')

      # Розничная цена
      div(:price_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Розничная цена']")
      div(:price_min_label, xpath: "//div[normalize-space()='Минимальная цена']/div[1]")
      text_field(:price_min, css: '#price_filter_price_min')
      div(:price_max_label, xpath: "//div[normalize-space()='Максимальная цена']/div[1]")
      text_field(:price_max, css: '#price_filter_price_max')

      # Структура экспорта
      div(:structure_title, xpath:
          "//div[@class='export-yml-form-row-left']//div[normalize-space()='Структура экспорта']")
      div(:rubrics, xpath: "//div[normalize-space()='Рубрики']")
      div(:groups, xpath: "//div[normalize-space()='Товарные группы']")

      # Выгружать все дерево групп
      div(:tree_group_title, xpath:
          "//div[@class='export-yml-form-row-left']//div[normalize-space()='Выгружать все дерево групп']")
      div(:yes_all_groups, xpath: "//div[normalize-space()='Да']")
      div(:no_all_groups, xpath: "//div[normalize-space()='Нет']")
      checkbox(:yes_no_groups, css: '#export_full_groups_tree')

      # Автообновление
      div(:autoupdate_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Автообновление']")
      div(:enable_autoupdate, css: '.js-export-yml-form-auto-export.js-export-yml-form_options-true')
      div(:disable_autoupdate, css: '.js-export-yml-form-auto-export.js-export-yml-form_options-false')
      div(:autoupdate_period_label, css: '.export-yml-form-auto-export-label')
      select(:autoupdate_period, css: '#period')
      checkbox(:autoupdate_set_hour, css: '#update_in_specific_hour')
      div(:autoupdate_start_hour_label, xpath: "//div[normalize-space()='Точное время обновления (MSK)']")
      text_field(:autoupdate_start_hour, css: '#starting_hour')

      # Выбор формата
      div(:format_title, xpath: "//div[@class='export-yml-form-row-left']//div[normalize-space()='Выбор формата']")
      select(:xml_type, css: '#xml_type')

      # Кнопки
      span(:save_settings, css: '.js-save-auto-export')
      button(:update_yml_file, css: '.js-export-yml-button')
      link(:clear_filters, css: '.export-yml-clear-button')
      link(:delete_yml_export, css: '.export-yml-remove-button')

      SERVICE_LABELS.each do |label|
        checkbox(label, css: "input[id='service_labels_'][value='#{label}']")
      end
    end
  end
end
