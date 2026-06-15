# frozen_string_literal: true

shared_examples 'проверка таба "Расширенные настройки" для редактирующих ролей' do |role|
  context 'когда находимся на табе "Расширенные настройки"' do
    before(:all) do
      @import_yml_page.settings_tab
      @settings_tab.wait_for_settings_tab_active
    end

    context 'когда проверяем блок "Выборочное обновление полей"' do
      it 'присутствует заголовок "Выборочное обновление полей" и текстовая подсказка (?)' do
        expect(@settings_tab.selected_fields_title?).to be true
        expect(@settings_tab.selected_fields_title).to eq 'Выборочное обновление полей'
        expect(@settings_tab.selected_fields_hint?).to be true
      end

      it 'все чекбоксы в блоке "Выборочное обновление полей" доступны' do
        CompanySite::ImportYMLPage::SettingsTab::FIELDS.each do |field|
          expect(@settings_tab.send("selected_#{field}_element").enabled?).to be true
        end
      end

      it 'присутствуют кнопки "Выбрать все" и "Убрать все"' do
        expect(@settings_tab.select_all?).to be true
        expect(@settings_tab.remove_all?).to be true
      end
    end

    context 'когда проверяем блок "Выборочное обновление полей по служебным меткам"' do
      it 'присутствует заголовок "Выборочное обновление полей по служебным меткам"' do
        expect(@settings_tab.selected_service_labels_title?).to be true
      end

      context 'когда включен тумблер в блоке "Выборочное обновление полей по служебным меткам"' do
        before(:all) { @settings_tab.check_update_service_labels }

        it 'присутствует заголовок "Служебные метки" и все чекбоксы доступны' do
          expect(@settings_tab.service_labels_label?).to be true
          CompanySite::ImportYMLPage::SettingsTab::SERVICE_LABELS.each do |label|
            expect(@settings_tab.send("#{label}_element").enabled?).to be true
          end
        end

        it 'присутствуют кнопки "Выбрать все" и "Убрать все"' do
          expect(@settings_tab.service_labels_select_all?).to be true
          expect(@settings_tab.service_labels_remove_all?).to be true
        end

        it 'присутствует заголовок "Обновляемые поля" и все чекбоксы доступны' do
          expect(@settings_tab.updated_fields_label?).to be true
          CompanySite::ImportYMLPage::SettingsTab::FIELDS_SERVICE_LABELS.each do |field|
            expect(@settings_tab.send("selected_service_labels_#{field}_element").enabled?).to be true
          end
        end

        it 'присутствуют кнопки "Выбрать все" и "Убрать все"' do
          expect(@settings_tab.updated_fields_select_all?).to be true
          expect(@settings_tab.updated_fields_remove_all?).to be true
        end
      end
    end

    context 'когда проверяем блок "Выборочное обновление товаров"' do
      it 'присутствует заголовок блока "Выборочное обновление товаров" и текстовая подсказка (?)' do
        expect(@settings_tab.selected_products_title?).to be true
        expect(@settings_tab.selected_fields_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Обновлять товары в статусе «Архивный»"' do
        expect(@settings_tab.update_archived_label).to eq 'Обновлять товары в статусе «Архивный»'
      end

      it 'присутствует чекбокс с названием "Обновлять товары в статусе «Опубликованный на сайте»"' do
        expect(@settings_tab.update_unpublished_label).to eq 'Обновлять товары в статусе «Опубликованный на сайте»'
      end

      it 'присутствует чекбокс с названием "Не менять статус отклоненного товара"' do
        expect(@settings_tab.no_update_declined_label).to eq 'Не менять статус отклоненного товара'
      end
    end

    context 'когда проверяем блок "Отчет"' do
      it 'присутствует заголовок "Отчет" и текстовая подсказка (?)' do
        expect(@settings_tab.import_report_title?).to be true
        expect(@settings_tab.import_report_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Получать отчёт о загрузке товаров и услуг"' do
        expect(@settings_tab.import_report_label).to eq 'Получать отчёт о загрузке товаров и услуг'
      end
    end

    context 'когда проверяем блок "Загрузка характеристик"' do
      it 'присутствует заголовок "Загрузка характеристик для фильтров по товарам на вашем сайте"' \
          'и текстовая подсказка (?)' do
        expect(@settings_tab.company_traits_title?).to be true
        expect(@settings_tab.company_traits_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Загрузка характеристик"' do
        expect(@settings_tab.company_traits_label).to eq 'Загружать характеристики'
      end
    end

    context 'когда проверяем блок "Ограничения импорта"' do
      it 'присутствует заголовок "Ограничения импорта"' do
        expect(@settings_tab.import_ban_title?).to be true
      end

      it 'в блоке присутствует заголовок "Импортировать товары с ценой от" и текстовое поле' do
        expect(@settings_tab.min_price_value_label?).to be true
        expect(@settings_tab.min_price_value_label).to eq 'Импортировать товары с ценой от'
        expect(@settings_tab.min_price_value?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Не импортировать товары без фото"' do
        expect(@settings_tab.images_only_label?).to be true
        expect(@settings_tab.images_only_label).to eq 'Не импортировать товары без фото'
      end

      it 'в блоке присутствует чекбокс с названием "Импортировать только товары «В наличии»"' do
        expect(@settings_tab.exists_only_label?).to be true
        expect(@settings_tab.exists_only_label).to eq 'Импортировать только товары «В наличии»'
      end
    end

    context 'когда проверяем блок "Изменение цен"' do
      it 'присутствует заголовок "Изменение цен" и текстовая подсказка (?)' do
        expect(@settings_tab.price_changes_title?).to be true
        expect(@settings_tab.price_changes_hint?).to be true
      end

      it 'в блоке присутствует заголовок "Изменить цену товаров на процент" и текстовое поле' do
        expect(@settings_tab.percent_change_label?).to be true
        expect(@settings_tab.percent_change_label).to eq 'Изменить цену товаров на процент'
        expect(@settings_tab.percent_change?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Округлять цены до целого числа"' do
        expect(@settings_tab.round_prices_label?).to be true
        expect(@settings_tab.round_prices_label).to eq 'Округлять цены до целого числа'
      end
    end

    context 'когда проверяем блок "Установить промо-скидку"' do
      it 'присутствует заголовок "Установить промо-скидку" и текстовая подсказка (?)' do
        expect(@settings_tab.promo_discount_title?).to be true
        expect(@settings_tab.promo_discount_hint?).to be true
      end

      it 'в блоке присутствует заголовок "Добавить % промо и сгенерировать старую цену" и текстовое поле' do
        expect(@settings_tab.discount_percent_change_label?).to be true
        expect(@settings_tab.discount_percent_change_label).to eq 'Добавить % промо и сгенерировать старую цену'
        expect(@settings_tab.discount_percent_change?).to be true
      end
    end

    context 'когда проверяем блок "Настройка названия товара"' do
      it 'присутствует заголовок "Настройка названия товара" и текстовая подсказка (?)' do
        expect(@settings_tab.setting_product_name_title?).to be true
        expect(@settings_tab.setting_product_name_hint?).to be true
      end

      it 'все чекбоксы в блоке "Настройка названия товара" включены' do
        CompanySite::ImportYMLPage::SettingsTab::NAME_TAGS.each do |field|
          expect(@settings_tab.send("tag_#{field}_element").enabled?).to be true
        end
      end
    end

    context 'когда проверяем блок "Настройка полного описания товара"' do
      it 'присутствует заголовок "Настройка полного описания товара" и текстовая подсказка (?)' do
        expect(@settings_tab.setting_product_description_title?).to be true
        expect(@settings_tab.setting_product_description_hint?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Добавить params в Полное описание"' do
        expect(@settings_tab.params_to_description_label?).to be true
        expect(@settings_tab.params_to_description_label).to eq 'Добавить params в Полное описание'
      end
    end

    context 'когда проверяем блок "Автопривязка"' do
      it 'присутствует заголовок блока "Автопривязка" и текстовая подсказка (?)' do
        expect(@settings_tab.autobinding_title?).to be true
        expect(@settings_tab.autobinding_title).to eq 'Автопривязка'
        expect(@settings_tab.autobinding_hint?).to be true
      end

      it 'в блоке присутствует чекбокс "Использовать автоматическую привязку рубрик"' do
        expect(@settings_tab.autobind_rubrics_label?).to be true
        expect(@settings_tab.autobind_rubrics_label).to eq 'Использовать автоматическую привязку рубрик'
      end

      it 'в блоке присутствует чекбокс "Использовать точную автоматическую привязку рубрик"' do
        expect(@settings_tab.exact_autobind_rubric_label?).to be true
        expect(@settings_tab.exact_autobind_rubric_label).to eq 'Использовать точную автоматическую привязку рубрик'
      end

      it 'в блоке присутствует чекбокс "Использовать в автоматической привязке model+vendor"' do
        expect(@settings_tab.trusted_models_label?).to be true
        expect(@settings_tab.trusted_models_label).to eq 'Использовать в автоматической привязке model+vendor'
      end

      it 'в блоке присутствует чекбокс "Включить автопривязку характеристик по названию и краткому описанию"' do
        expect(@settings_tab.traits_autobinding_label?).to be true
        expect(@settings_tab.traits_autobinding_label)
          .to eq 'Включить автопривязку характеристик по названию и краткому описанию'
        expect(@settings_tab.traits_autobinding_checked?).to be true
      end

      it 'в блоке присутствует чекбокс "Включить автопривязку характеристик по пользовательским характеристикам"' do
        expect(@settings_tab.user_traits_autobinding_label?).to be true
        expect(@settings_tab.user_traits_autobinding_label)
          .to eq 'Включить автопривязку характеристик по пользовательским характеристикам'
        expect(@settings_tab.user_traits_autobinding_checked?).to be true
      end

      if [:admin, :editor].include?(role)
        it 'в блоке присутствуют чекбоксы Включить автопривязку рубрик в выбранных группах' do
          expect(@settings_tab.rubrics_in_groups_label?).to be true
          expect(@settings_tab.rubrics_in_groups_label).to eq 'Включить автопривязку рубрик в выбранных группах'
        end
      else
        it 'в блоке отсутствует чекбокс "Включить автопривязку рубрик в выбранных группах"' do
          expect(@settings_tab.rubrics_in_groups_label?).to be false
        end
      end
    end

    include_examples 'проверка блоков таба "Расширенные настройки" доступных только для суперюзера' if role == :admin

    it('присутствует кнопка "Сохранить"') { expect(@settings_tab.save_settings?).to be true }

    context 'когда источник - Ссылка' do
      before(:all) do
        @import_yml_page.upload_tab
        @upload_tab.switch_to_source_url
        @import_yml_page.settings_tab
      end

      context 'когда проверяем блок "Автообновление"' do
        it 'присутствует заголовок "Автообновление" и текстовая подсказка (?)' do
          expect(@settings_tab.autoupdate_title?).to be true
          expect(@settings_tab.autoupdate_hint?).to be true
        end

        context 'когда отмечен чекбокс "Включить автоматическое обновление"' do
          before(:all) { @settings_tab.check_autoupdate }

          it 'присутствует чекбокс с названием "Включить автоматическое обновление" и он активен' do
            expect(@settings_tab.autoupdate_label).to eq 'Включить автоматическое обновление'
            expect(@settings_tab.autoupdate_checked?).to be true
          end

          it 'отобразится блок с полями "Интервал обновления"' do
            expect(@settings_tab.autoupdate_period_label?).to be true
            expect(@settings_tab.autoupdate_period?).to be true
          end

          it 'отобразится блок с полями "Точное время обновления (MSK)"' do
            expect(@settings_tab.autoupdate_start_hour_label?).to be true
            expect(@settings_tab.autoupdate_start_hour?).to be true
          end

          it 'отобразится блок с полями "Дата начала"' do
            expect(@settings_tab.autoupdate_start_date_label?).to be true
            expect(@settings_tab.autoupdate_start_date?).to be true
          end
        end
      end
    end
  end
end

shared_examples 'проверка блоков таба "Расширенные настройки" доступных только для суперюзера' do
  context 'когда проверяем блок "Премодерация"' do
    it 'присутствует заголовок блока "Премодерация"' do
      expect(@settings_tab.pre_moderation_title?).to be true
      expect(@settings_tab.pre_moderation_title).to eq 'Премодерация'
    end

    it 'в блоке присутствует чекбокс с названием "Не отправлять на премодерацию"' do
      expect(@settings_tab.pre_moderation_label?).to be true
      expect(@settings_tab.pre_moderation_label).to eq 'Не отправлять на премодерацию'
    end
  end

  context 'когда проверяем блок "Физическое удаление товаров"' do
    it 'присутствует заголовок блока и текстовая подсказка (?)' do
      expect(@settings_tab.physical_delete_title?).to be true
      expect(@settings_tab.physical_delete_title).to eq 'Физическое удаление товаров'
      expect(@settings_tab.physical_delete_hint?).to be true
    end

    it 'в блоке присутствует кнопка "Очистить удаленные товары"' do
      expect(@settings_tab.physical_delete_products?).to be true
    end
  end
end

shared_examples 'проверка таба "Расширенные настройки" для владельца (бесплатный пакет)' do
  context 'когда на вкладке "Расширенные настройки"' do
    before(:all) do
      @import_yml_page.settings_tab
      @settings_tab.wait_for_settings_tab_active
    end

    it('отобразится блок с предложением подключить платный пакет') \
      { expect(@settings_tab.star_suggestion_tab_settings?).to be true }

    context 'когда проверяем блок "Выборочное обновление полей"' do
      before(:all) { @settings_tab.select_all_element.click }

      it 'присутствует заголовок "Выборочное обновление полей" и текстовая подсказка (?)' do
        expect(@settings_tab.selected_fields_title?).to be true
        expect(@settings_tab.selected_fields_title).to eq 'Выборочное обновление полей'
        expect(@settings_tab.selected_fields_hint?).to be true
      end

      it 'все чекбоксы в блоке "Выборочное обновление полей" заблокированы' do
        CompanySite::ImportYMLPage::SettingsTab::FIELDS.each do |field|
          next if %w[service_labels page_title page_description].include?(field)

          expect(@settings_tab.send("selected_#{field}_element").disabled?).to be true
        end
      end

      it 'присутствуют кнопки "Выбрать все" и "Убрать все"' do
        expect(@settings_tab.select_all?).to be true
        expect(@settings_tab.remove_all?).to be true
      end
    end

    context 'когда проверяем блок "Выборочное обновление товаров"' do
      it 'присутствует заголовок блока "Выборочное обновление товаров" и текстовая подсказка (?)' do
        expect(@settings_tab.selected_products_title?).to be true
        expect(@settings_tab.selected_fields_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Обновлять товары в статусе «Архивный»"' do
        expect(@settings_tab.update_archived_label).to eq 'Обновлять товары в статусе «Архивный»'
      end

      it 'присутствует чекбокс с названием "Обновлять товары в статусе «Опубликованный на сайте»"' do
        expect(@settings_tab.update_unpublished_label).to eq 'Обновлять товары в статусе «Опубликованный на сайте»'
      end

      it 'отсутствует чекбокс с названием "Не менять статус отклоненного товара"' do
        expect(@settings_tab.no_update_declined_label?).to be false
      end
    end

    context 'когда проверяем блок "Отчет"' do
      it 'присутствует заголовок "Отчет" и текстовая подсказка (?)' do
        expect(@settings_tab.import_report_title?).to be true
        expect(@settings_tab.import_report_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Получать отчёт о загрузке товаров и услуг" и заблокирован' do
        expect(@settings_tab.import_report_label).to eq 'Получать отчёт о загрузке товаров и услуг'
        expect(@settings_tab.import_report_element.disabled?).to be true
      end
    end

    context 'когда проверяем блок "Загрузка характеристик"' do
      it 'присутствует заголовок "Загрузка характеристик для фильтров по товарам на вашем сайте"' \
          'и текстовая подсказка (?)' do
        expect(@settings_tab.company_traits_title?).to be true
        expect(@settings_tab.company_traits_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Загрузка характеристик"' do
        expect(@settings_tab.company_traits_label).to eq 'Загружать характеристики'
      end
    end

    context 'когда проверяем блок "Ограничения импорта"' do
      it 'присутствует заголовок "Ограничения импорта"' do
        expect(@settings_tab.import_ban_title?).to be true
      end

      it 'в блоке присутствует заголовок "Импортировать товары с ценой от" и текстовое поле заблокировано' do
        expect(@settings_tab.min_price_value_label?).to be true
        expect(@settings_tab.min_price_value_label).to eq 'Импортировать товары с ценой от'
        expect(@settings_tab.min_price_value_element.disabled?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Не импортировать товары без фото" и заблокирован' do
        expect(@settings_tab.images_only_label?).to be true
        expect(@settings_tab.images_only_label).to eq 'Не импортировать товары без фото'
        expect(@settings_tab.images_only_element.disabled?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Импортировать только товары «В наличии»" и заблокирован' do
        expect(@settings_tab.exists_only_label?).to be true
        expect(@settings_tab.exists_only_label).to eq 'Импортировать только товары «В наличии»'
        expect(@settings_tab.exists_only_element.disabled?).to be true
      end
    end

    context 'когда проверяем блок "Изменение цен"' do
      it 'присутствует заголовок "Изменение цен" и текстовая подсказка (?)' do
        expect(@settings_tab.price_changes_title?).to be true
        expect(@settings_tab.price_changes_hint?).to be true
      end

      it 'в блоке присутствует заголовок "Изменить цену товаров на процент" и текстовое поле' do
        expect(@settings_tab.percent_change_label?).to be true
        expect(@settings_tab.percent_change_label).to eq 'Изменить цену товаров на процент'
        expect(@settings_tab.percent_change?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Округлять цены до целого числа"' do
        expect(@settings_tab.round_prices_label?).to be true
        expect(@settings_tab.round_prices_label).to eq 'Округлять цены до целого числа'
      end
    end

    context 'когда проверяем блок "Настройка названия товара"' do
      it 'присутствует заголовок "Настройка названия товара" и текстовая подсказка (?)' do
        expect(@settings_tab.setting_product_name_title?).to be true
        expect(@settings_tab.setting_product_name_hint?).to be true
      end

      it 'все чекбоксы в блоке "Настройка названия товара" заблокированы' do
        CompanySite::ImportYMLPage::SettingsTab::NAME_TAGS.each do |field|
          expect(@settings_tab.send("tag_#{field}_element").disabled?).to be true
        end
      end
    end

    context 'когда проверяем что блок "Выборочное обновление полей по служебным меткам" отсутствует' do
      it 'отсутствует заголовок "Выборочное обновление полей по служебным меткам"' do
        expect(@settings_tab.selected_service_labels_title?).to be false
      end
    end

    context 'когда проверяем что блок "Установить промо-скидку" отсутствует' do
      it 'отсутствует заголовок "Установить промо-скидку"' do
        expect(@settings_tab.promo_discount_title?).to be false
      end
    end

    context 'когда проверяем что блок "Настройка полного описания товара" отсутствует' do
      it 'отсутствует заголовок "Настройка полного описания товара"' do
        expect(@settings_tab.setting_product_description_title?).to be false
      end
    end

    context 'когда проверяем что блок "Автопривязка" отсутствует' do
      it 'отсутствует заголовок блока "Автопривязка"' do
        expect(@settings_tab.autobinding_title?).to be false
      end
    end

    context 'когда проверяем что блок "Премодерация" отсутствует' do
      it 'отсутствует заголовок блока "Премодерация"' do
        expect(@settings_tab.pre_moderation_title?).to be false
      end
    end

    context 'когда проверяем что блок "Физическое удаление товаров" отсутствует' do
      it 'отсутствует заголовок блока "Физическое удаление товаров"' do
        expect(@settings_tab.physical_delete_title?).to be false
      end
    end

    it('присутствует кнопка "Сохранить"') { expect(@settings_tab.save_settings?).to be true }

    context 'когда источник - Ссылка' do
      before do
        @import_yml_page.upload_tab
        @upload_tab.switch_to_source_url
        @settings_tab.settings_tab
        @import_yml_page.upload_tab
      end

      context 'когда проверяем что блок "Автообновление" отсутствует' do
        it 'отсутствует заголовок "Автообновление"' do
          expect(@settings_tab.autoupdate_title?).to be false
        end
      end
    end
  end
end

shared_examples 'проверка таба "Расширенные настройки" для владельца (платный пакет)' do
  context 'когда на вкладке "Расширенные настройки"' do
    before(:all) do
      @import_yml_page.settings_tab
      @settings_tab.wait_for_settings_tab_active
    end

    it('отсутствует блок с предложением подключить платный пакет') \
      { expect(@settings_tab.star_suggestion_tab_settings?).to be false }

    context 'когда проверяем блок "Выборочное обновление полей"' do
      before(:all) { @settings_tab.select_all_element.click }

      it 'присутствует заголовок "Выборочное обновление полей" и текстовая подсказка (?)' do
        expect(@settings_tab.selected_fields_title?).to be true
        expect(@settings_tab.selected_fields_title).to eq 'Выборочное обновление полей'
        expect(@settings_tab.selected_fields_hint?).to be true
      end

      it 'все чекбоксы в блоке "Выборочное обновление полей" включены' do
        CompanySite::ImportYMLPage::SettingsTab::FIELDS.each do |field|
          next if %w[service_labels page_title page_description].include?(field)

          expect(@settings_tab.send("selected_#{field}_element").enabled?).to be true
        end
      end

      it 'присутствуют кнопки "Выбрать все" и "Убрать все"' do
        expect(@settings_tab.select_all?).to be true
        expect(@settings_tab.remove_all?).to be true
      end
    end

    context 'когда проверяем блок "Выборочное обновление товаров"' do
      it 'присутствует заголовок блока "Выборочное обновление товаров" и текстовая подсказка (?)' do
        expect(@settings_tab.selected_products_title?).to be true
        expect(@settings_tab.selected_fields_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Обновлять товары в статусе «Архивный»"' do
        expect(@settings_tab.update_archived_label).to eq 'Обновлять товары в статусе «Архивный»'
      end

      it 'присутствует чекбокс с названием "Обновлять товары в статусе «Опубликованный на сайте»"' do
        expect(@settings_tab.update_unpublished_label).to eq 'Обновлять товары в статусе «Опубликованный на сайте»'
      end

      it 'отсутствует чекбокс с названием "Не менять статус отклоненного товара"' do
        expect(@settings_tab.no_update_declined_label?).to be false
      end
    end

    context 'когда проверяем блок "Отчет"' do
      it 'присутствует заголовок "Отчет" и текстовая подсказка (?)' do
        expect(@settings_tab.import_report_title?).to be true
        expect(@settings_tab.import_report_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Получать отчёт о загрузке товаров и услуг" и разблокирован' do
        expect(@settings_tab.import_report_label).to eq 'Получать отчёт о загрузке товаров и услуг'
        expect(@settings_tab.import_report_element.enabled?).to be true
      end
    end

    context 'когда проверяем блок "Загрузка характеристик"' do
      it 'присутствует заголовок "Загрузка характеристик для фильтров по товарам на вашем сайте"' \
          'и текстовая подсказка (?)' do
        expect(@settings_tab.company_traits_title?).to be true
        expect(@settings_tab.company_traits_hint?).to be true
      end

      it 'присутствует чекбокс с названием "Загрузка характеристик"' do
        expect(@settings_tab.company_traits_label).to eq 'Загружать характеристики'
      end
    end

    context 'когда проверяем блок "Ограничения импорта"' do
      it 'присутствует заголовок "Ограничения импорта"' do
        expect(@settings_tab.import_ban_title?).to be true
      end

      it 'в блоке присутствует заголовок "Импортировать товары с ценой от" и текстовое поле разблокировано' do
        expect(@settings_tab.min_price_value_label?).to be true
        expect(@settings_tab.min_price_value_label).to eq 'Импортировать товары с ценой от'
        expect(@settings_tab.min_price_value_element.enabled?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Не импортировать товары без фото"' do
        expect(@settings_tab.images_only_label?).to be true
        expect(@settings_tab.images_only_label).to eq 'Не импортировать товары без фото'
        expect(@settings_tab.images_only_element.enabled?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Импортировать только товары «В наличии»" и разблокирован' do
        expect(@settings_tab.exists_only_label?).to be true
        expect(@settings_tab.exists_only_label).to eq 'Импортировать только товары «В наличии»'
        expect(@settings_tab.exists_only_element.enabled?).to be true
      end
    end

    context 'когда проверяем блок "Изменение цен"' do
      it 'присутствует заголовок "Изменение цен" и текстовая подсказка (?)' do
        expect(@settings_tab.price_changes_title?).to be true
        expect(@settings_tab.price_changes_hint?).to be true
      end

      it 'в блоке присутствует заголовок "Изменить цену товаров на процент" и текстовое поле' do
        expect(@settings_tab.percent_change_label?).to be true
        expect(@settings_tab.percent_change_label).to eq 'Изменить цену товаров на процент'
        expect(@settings_tab.percent_change?).to be true
      end

      it 'в блоке присутствует чекбокс с названием "Округлять цены до целого числа"' do
        expect(@settings_tab.round_prices_label?).to be true
        expect(@settings_tab.round_prices_label).to eq 'Округлять цены до целого числа'
      end
    end

    context 'когда проверяем блок "Настройка названия товара"' do
      it 'присутствует заголовок "Настройка названия товара" и текстовая подсказка (?)' do
        expect(@settings_tab.setting_product_name_title?).to be true
        expect(@settings_tab.setting_product_name_hint?).to be true
      end

      it 'все чекбоксы в блоке "Настройка названия товара" разблокированы' do
        CompanySite::ImportYMLPage::SettingsTab::NAME_TAGS.each do |field|
          expect(@settings_tab.send("tag_#{field}_element").enabled?).to be true
        end
      end
    end

    context 'когда проверяем что блок "Выборочное обновление полей по служебным меткам" отсутствует' do
      it 'отсутствует заголовок "Выборочное обновление полей по служебным меткам"' do
        expect(@settings_tab.selected_service_labels_title?).to be false
      end
    end

    context 'когда проверяем что блок "Установить промо-скидку" отсутствует' do
      it 'отсутствует заголовок "Установить промо-скидку"' do
        expect(@settings_tab.promo_discount_title?).to be false
      end
    end

    context 'когда проверяем что блок "Настройка полного описания товара" отсутствует' do
      it 'отсутствует заголовок "Настройка полного описания товара"' do
        expect(@settings_tab.setting_product_description_title?).to be false
      end
    end

    context 'когда проверяем что блок "Автопривязка" отсутствует' do
      it 'отсутствует заголовок блока "Автопривязка"' do
        expect(@settings_tab.autobinding_title?).to be false
      end
    end

    context 'когда проверяем что блок "Премодерация" отсутствует' do
      it 'отсутствует заголовок блока "Премодерация"' do
        expect(@settings_tab.pre_moderation_title?).to be false
      end
    end

    context 'когда проверяем что блок "Физическое удаление товаров" отсутствует' do
      it 'отсутствует заголовок блока "Физическое удаление товаров"' do
        expect(@settings_tab.physical_delete_title?).to be false
      end
    end

    it('присутствует кнопка "Сохранить"') { expect(@settings_tab.save_settings?).to be true }

    context 'когда источник - Ссылка' do
      before do
        @import_yml_page.upload_tab
        @upload_tab.switch_to_source_url
        @import_yml_page.settings_tab
      end

      context 'когда проверяем что блок "Автообновление" отсутствует' do
        it 'отсутствует заголовок "Автообновление"' do
          expect(@settings_tab.autoupdate_title?).to be false
        end
      end
    end
  end
end
