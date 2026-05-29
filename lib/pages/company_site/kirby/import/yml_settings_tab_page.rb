# frozen_string_literal: true

module CompanySite
  class ImportYMLPage
    class SettingsTab < self
      FIELDS = %w[
        name image_urls announce description price wholesale_price
        wholesale_min_qty exists product_group company_traits
        rubric_url qty_in_stock traits rubric_priority
        article labels service_labels page_title page_description
      ].freeze

      FIELDS_SERVICE_LABELS = FIELDS

      SERVICE_LABELS = %w[
        premium new_unic new_unic_copywriting new_unic_locomotiv
        short_desc long_desc old_unic to_uniqueize to_copywriting
        describe_locomotiv old_locomotive to_be_processed
        description_processed description_processed_and_seo
        product_finalized processed_old_products infographics
        seo_pro_processed seo_pro_processed_2 seo_pro_processed_3
      ].freeze

      NAME_TAGS = %w[
        name typePrefix vendor model
      ].freeze

      # Текстовая зона для бесплатных компаний на странице расширенных настроек
      div(:star_suggestion_tab_settings, css: '.settings-main-block .star-link-suggestion')

      # Выборочное обновление полей
      label(:selected_fields_title, xpath: '//label[normalize-space()="Выборочное обновление полей"]')
      div(:selected_fields_hint, xpath:
          '//label[normalize-space()="Выборочное обновление полей"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      div(:select_all, css: '.js-excluded-fields-option-check-all')
      div(:remove_all, css: '.js-excluded-fields-option-remove-all')

      # Выборочное обновление полей по служебным меткам
      label(:selected_service_labels_title, xpath:
            '//label[normalize-space()="Выборочное обновление полей по служебным меткам"]')
      checkbox(:update_service_labels, css: '.js-selective-update-by-service-labels-enabled')
      div(:service_labels_label, xpath: '//div[normalize-space()="Служебные метки"]')
      div(:service_labels_select_all, css: '.js-selective-update-by-service-labels-check-all')
      div(:service_labels_remove_all, css: '.js-selective-update-by-service-labels-remove-all')
      div(:updated_fields_label, xpath: '//div[normalize-space()="Обновляемые поля"]')
      div(:updated_fields_select_all, css: '.js-selective-update-by-service-labels-fields-check-all')
      div(:updated_fields_remove_all, css: '.js-selective-update-by-service-labels-fields-remove-all')

      # Выборочное обновление товаров
      label(:selected_products_title, xpath: '//label[text()="Выборочное обновление товаров"]')
      div(:selected_products_hint, xpath:
          '//label[normalize-space()="Выборочное обновление товаров"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:update_archived_label, css: 'label[for="online_store_update_archived"]')
      checkbox(:update_archived, css: '#online_store_update_archived')
      label(:update_unpublished_label, css: 'label[for="online_store_update_unpublished"]')
      checkbox(:update_unpublished, css: '#online_store_update_unpublished')
      label(:no_update_declined_label, css: 'label[for="online_store_without_declined"]')
      checkbox(:no_update_declined, css: '#online_store_without_declined')

      # Автообновление
      label(:autoupdate_title, xpath: '//label[text()="Автообновление"]')
      div(:autoupdate_hint, xpath:
          '//label[normalize-space()="Автообновление"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:autoupdate_label, css: 'label[for="online_store_updating_settings_attributes_enabled"]')
      checkbox(:autoupdate, css: '#online_store_updating_settings_attributes_enabled')
      label(:autoupdate_period_label, xpath: '//label[text()="Интервал обновления"]')
      text_field(:autoupdate_period, css: '#online_store_updating_settings_attributes_period')
      checkbox(:autoupdate_set_hour, css: '#online_store_updating_settings_attributes_update_in_specific_hour')
      label(:autoupdate_start_hour_label, xpath: '//label[text()="Точное время обновления (MSK)"]')
      text_field(:autoupdate_start_hour, css: '#online_store_updating_settings_attributes_starting_hour')
      label(:autoupdate_start_date_label, xpath: '//label[text()="Дата начала"]')
      text_field(:autoupdate_start_date, css: '#online_store_updating_settings_attributes_start_date')

      # Отчет
      label(:import_report_title, xpath: '//label[text()="Отчет"]')
      div(:import_report_hint, xpath:
          '//label[normalize-space()="Отчет"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:import_report_label, css: 'label[for="online_store_send_notifications"]')
      checkbox(:import_report, css: '#online_store_send_notifications')
      label(:email_label, xpath: '//label[text()="Адрес почты"]')
      text_field(:email, css: '#online_store_email')

      # Загрузка пользовательских характеристик
      label(:company_traits_title, xpath:
            "//label[text()='Загрузка характеристик для фильтров по товарам на вашем сайте']")
      div(:company_traits_hint, xpath:
          '//label[normalize-space()="Загрузка характеристик для фильтров по товарам на вашем сайте"]
           /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:company_traits_label, css: 'label[for="online_store_update_company_traits"]')
      checkbox(:company_traits, css: '#online_store_update_company_traits')

      # Ограничения импорта
      label(:import_ban_title, xpath: '//label[text()="Ограничения импорта"]')
      label(:min_price_value_label, xpath: '//label[text()="Импортировать товары с ценой от"]')
      text_field(:min_price_value, css: '#online_store_import_min_price')
      label(:images_only_label, css: 'label[for="online_store_with_images_only"]')
      checkbox(:images_only, css: '#online_store_with_images_only')
      label(:exists_only_label, css: 'label[for="online_store_with_exists_only"]')
      checkbox(:exists_only, css: '#online_store_with_exists_only')

      # Изменение цен
      label(:price_changes_title, xpath: '//label[text()="Изменение цен"]')
      div(:price_changes_hint, xpath:
          '//label[normalize-space()="Изменение цен"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:percent_change_label, xpath: '//label[text()="Изменить цену товаров на процент"]')
      text_field(:percent_change, css: '#online_store_price_correction')
      label(:round_prices_label, css: 'label[for="online_store_round_prices"]')
      checkbox(:round_prices, css: '#online_store_round_prices')

      # Установить промо-скидку
      label(:promo_discount_title, xpath: '//label[text()="Установить промо-скидку"]')
      div(:promo_discount_hint, xpath:
          '//label[normalize-space()="Установить промо-скидку"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:discount_percent_change_label, xpath: '//label[text()="Добавить % промо и сгенерировать старую цену"]')
      text_field(:discount_percent_change, css: '#online_store_promo_discount_percent')

      # Настройка названия товара
      label(:setting_product_name_title, xpath: '//label[text()="Настройка названия товара"]')
      div(:setting_product_name_hint, xpath:
          '//label[normalize-space()="Настройка названия товара"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      checkbox(:tag_name, css: '#online_store_product_name_tags_name')
      checkbox(:tag_type_prefix, css: '#online_store_product_name_tags_typePrefix')
      checkbox(:tag_vendor, css: '#online_store_product_name_tags_vendor')
      checkbox(:tag_model, css: '#online_store_product_name_tags_model')

      # Настройка полного описания товара
      label(:setting_product_description_title, xpath: '//label[normalize-space()="Настройка полного описания товара"]')
      div(:setting_product_description_hint, xpath:
          '//label[normalize-space()="Настройка полного описания товара"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      label(:params_to_description_label, css: 'label[for="online_store_write_params_to_description"]')
      checkbox(:params_to_description, css: '#online_store_write_params_to_description')

      # Автопривязка
      label(:autobinding_title, xpath: '//label[text()="Автопривязка"]')
      div(:autobinding_hint, xpath:
          '//label[normalize-space()="Автопривязка"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      link(:autobind_link, css: '.autobind-link')
      label(:autobind_rubrics_label, css: 'label[for="online_store_autobind_rubrics"]')
      checkbox(:autobind_rubrics, css: '#online_store_autobind_rubrics')
      label(:exact_autobind_rubric_label, css: 'label[for="online_store_exact_autobind_rubrics"]')
      checkbox(:exact_autobind_rubric, css: '#online_store_exact_autobind_rubrics')
      label(:trusted_models_label, css: 'label[for="online_store_trusted_models"]')
      checkbox(:trusted_models, css: '#online_store_trusted_models')
      label(:traits_autobinding_label, css: 'label[for="online_store_exclude_name_from_traits_autobinding"]')
      checkbox(:traits_autobinding, css: '#online_store_exclude_name_from_traits_autobinding')
      label(:user_traits_autobinding_label, css:
            'label[for="online_store_exclude_user_traits_from_traits_autobinding"]')
      checkbox(:user_traits_autobinding, css: '#online_store_exclude_user_traits_from_traits_autobinding')
      label(:rubrics_in_groups_label, css: 'label[for="online_store_autobind_rubrics_in_groups"]')
      checkbox(:rubrics_in_groups, css: '#online_store_autobind_rubrics_in_groups')
      div(:tree_groups, css: '.js-import-yml-groups-tree')

      # Премодерация
      label(:pre_moderation_title, xpath: '//label[text()="Премодерация"]')
      label(:pre_moderation_label, css: 'label[for="online_store_premoderation_disabled"]')
      checkbox(:pre_moderation, css: '#online_store_premoderation_disabled')

      # Физическое удаление товаров
      label(:physical_delete_title, xpath: '//label[normalize-space()="Физическое удаление товаров"]')
      div(:physical_delete_hint, xpath:
          '//label[normalize-space()="Физическое удаление товаров"]
          /following-sibling::div[contains(@class,"js-qtip-icon")]')
      link(:physical_delete_products, css: '.destroy-products-form a')

      # Блок кнопок (Сохранение)
      button(:save_settings, css: '.js-yml-settings-buttons .js-yml-save')

      # Выбранные обновляемые поля у товара при импорте
      FIELDS.each do |field|
        checkbox("selected_#{field}", css: "#online_store_selected_fields_#{field}")
      end

      # Настройка обновления полей товара у которого есть служебная метка
      SERVICE_LABELS.each do |label|
        checkbox(label, css: "#online_store_excluded_service_labels_#{label}")
      end

      # Выбранные обновляемые поля у товара при импорте с выбранными служебными метками
      FIELDS_SERVICE_LABELS.each do |field|
        checkbox("selected_service_labels_#{field}", css: "#online_store_updated_fields_for_service_labels_#{field}")
      end

      # Теги, попадающие в название
      NAME_TAGS.each do |field|
        checkbox("tag_#{field}", css: "#online_store_product_name_tags_#{field}")
      end
    end
  end
end
