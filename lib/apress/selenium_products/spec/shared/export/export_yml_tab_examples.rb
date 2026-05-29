# frozen_string_literal: true

shared_examples 'проверка таба "YML" для редактирующих ролей' do |role|
  context 'когда находимся на табе YML' do
    it 'присутствует текстовая зона' do
      expect(@yml_tab.yml_text_zone?).to be true
    end

    it 'присутствует заголовок страницы конфигурации "Экспорт YML"' do
      expect(@yml_tab.export_yml_title?).to be true
      expect(@yml_tab.export_yml_title).to eq 'Экспорт YML'
    end

    context 'когда проверяем блок "Ссылка на файл"' do
      before(:all) do
        @yml_tab.update_yml_file
        @export_page.wait_export_progressbar
      end

      it 'присутствует дата обновления экспорта' do
        expect(@yml_tab.updated_at?).to be true
      end

      it 'присутствует заголовок блока' do
        expect(@yml_tab.url_title?).to be true
        expect(@yml_tab.url_title).to eq 'Ссылка на файл'
      end

      it 'присутствует ссылка' do
        expect(@yml_tab.url_yml?).to be true
        expect(@yml_tab.url_yml_element.attribute('value')).to match(/^(http|https).*\.xml$/)
      end

      it 'присутствует счётчик товаров в файле' do
        expect(@yml_tab.count_products?).to be true
      end

      it 'присутствует кнопка копирования ссылки файла' do
        expect(@yml_tab.copy_url_yml?).to be true
      end
    end

    context 'когда проверяем блок "Название"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.name_title?).to be true
        expect(@yml_tab.name_title).to eq 'Название'
      end

      it 'присутствует текстовое поле для названия экспорта' do
        expect(@yml_tab.name?).to be true
      end
    end

    context 'когда проверяем блок "Тип выгрузки"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.type_unload_title?).to be true
        expect(@yml_tab.type_unload_title).to eq 'Тип выгрузки'
      end

      it 'присутствует чекбокс "Выгружать товары с внешними id"' do
        expect(@yml_tab.unload_products_external_ids?).to be true
      end

      it 'присутствует чекбокс "Выгружать группы с внутренними id"' do
        expect(@yml_tab.unload_groups_internal_ids?).to be true
      end

      it 'присутствует чекбокс "Выгружать дополнительные теги' do
        expect(@yml_tab.unload_additional_tags?).to be true
      end

      if [:admin].include?(role)
        it 'присутствует чекбокс "Выгружать краткие описания в тег description"' do
          expect(@yml_tab.unload_announce_to_description?).to be true
        end
      else
        it 'присутствует чекбокс "Выгружать краткие описания в тег description" и заблокирован' do
          expect(@yml_tab.unload_announce_to_description?).to be true
          expect(@yml_tab.unload_announce_to_description_element.disabled?).to be true
        end
      end

      it 'присутствует чекбокс "Выгружать краткие описания в тег shortDescription' do
        expect(@yml_tab.unload_announce_to_short_description?).to be true
      end

      it 'присутствует чекбокс "Выгружать товары с точной розничной ценой' do
        expect(@yml_tab.unload_exact_price?).to be true
      end

      it 'присутствует чекбокс "Выгружать товары с розничной ценой и без цены' do
        expect(@yml_tab.unload_different_price?).to be true
      end

      it 'присутствует чекбокс "Выгружать товары с оптовой ценой' do
        expect(@yml_tab.unload_wholesale_price?).to be true
      end

      it 'присутствует чекбокс "Выгружать ссылку на ПКТ в тег <url>' do
        expect(@yml_tab.unload_pct_to_url?).to be true
      end

      it 'присутствует чекбокс "Выгружать товары с уникальными фото' do
        expect(@yml_tab.unload_unique_photo?).to be true
      end

      it 'присутствует чекбокс "Не выгружать отклоненные товары' do
        expect(@yml_tab.not_unload_declined?).to be true
      end

      it 'присутствует чекбокс "Не выгружать товары на рассмотрении' do
        expect(@yml_tab.not_unload_undecided?).to be true
      end

      it 'присутствует чекбокс "Не выгружать товары без фото"' do
        expect(@yml_tab.not_unload_with_photo?).to be true
      end

      it 'присутствует чекбокс "Не выгружать теги <store> и <pickup>"' do
        expect(@yml_tab.not_unload_store_pickup_tags?).to be true
      end

      it 'присутствует чекбокс "Не выгружать тег <delivery>"' do
        expect(@yml_tab.not_unload_delivery_tag?).to be true
      end

      if [:admin, :editor].include?(role)
        it 'присутствует чекбокс "Выгружать товары от имени портала"' do
          expect(@yml_tab.unload_name_portal?).to be true
        end
      else
        it 'отсутствует чекбокс "Выгружать товары от имени портала"' do
          expect(@yml_tab.unload_name_portal?).to be false
        end
      end

      it 'присутствует чекбокс "Выгружать товары с фото без инфографики"' do
        expect(@yml_tab.unload_with_infographics?).to be true
      end
    end

    context 'когда проверяем блок "Наличие товаров"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.exists_title?).to be true
        expect(@yml_tab.exists_title).to eq 'Наличие товаров'
      end

      it 'присутствует чекбокс "В наличии"' do
        expect(@yml_tab.available?).to be true
      end

      it 'присутствует чекбокс "Нет в наличии"' do
        expect(@yml_tab.not_available?).to be true
      end

      it 'присутствует чекбокс "Под заказ"' do
        expect(@yml_tab.order?).to be true
      end

      it 'присутствует чекбокс "Ожидает поступления"' do
        expect(@yml_tab.awaiting?).to be true
      end

      it 'присутствует чекбокс "Наличие не указано"' do
        expect(@yml_tab.not_specified?).to be true
      end
    end

    context 'когда проверяем блок "Экспортировать"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.export_title?).to be true
        expect(@yml_tab.export_title).to eq 'Экспортировать'
      end

      it 'присутствует режим "Все группы"' do
        expect(@yml_tab.all_groups?).to be true
      end

      it 'присутствует режим "Выбранные группы"' do
        expect(@yml_tab.selected_groups?).to be true
      end

      it 'присутствует режим "Выбранные рубрики"' do
        expect(@yml_tab.selected_rubrics?).to be true
      end

      context 'когда проверяем режим "Выбранные группы"' do
        before(:all) { @yml_tab.selected_groups_element.click }

        it 'присутствует примечание для выгрузки товаров из выбранных групп' do
          expect(@yml_tab.notice_groups?).to be true
        end

        it 'присутствует чекбокс для настройки исключения групп' do
          expect(@yml_tab.exception_groups?).to be true
        end

        it 'присутствует дерево групп' do
          expect(@yml_tab.groups_tree?).to be true
        end
      end

      context 'когда проверяем режим "Выбранные рубрики"' do
        before(:all) { @yml_tab.selected_rubrics_element.click }

        it 'присутствует примечание для выгрузки товаров из выбранных рубрик' do
          expect(@yml_tab.notice_rubrics?).to be true
        end

        it 'присутствует чекбокс для настройки исключения рубрик' do
          expect(@yml_tab.exception_rubrics?).to be true
        end

        it 'присутствует дерево рубрик' do
          expect(@yml_tab.rubrics_tree?).to be true
        end
      end
    end

    context 'когда проверяем блок "Служебные метки"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.service_labels_title?).to be true
        expect(@yml_tab.service_labels_title).to eq 'Служебные метки'
      end

      it 'присутствует режим "Все товары"' do
        expect(@yml_tab.all_products?).to be true
      end

      it 'присутствует режим "С метками"' do
        expect(@yml_tab.with_service_labels?).to be true
      end

      context 'когда проверяем режим "C метками"' do
        before(:all) { @yml_tab.with_service_labels_element.click }

        it 'присутствуют все чекбоксы служебных меток' do
          CompanySite::ExportPage::YMLTab::SERVICE_LABELS.each do |field|
            expect(@yml_tab.send("#{field}_element").present?).to be true
          end
        end
      end
    end

    if [:admin, :editor].include?(role)
      include_examples 'проверка блоков таба "YML" доступных только для суперюзера и редактора'
    end

    include_examples 'проверка блоков таба "YML" доступных только для суперюзера' if role == :admin
  end
end

shared_examples 'проверка блоков таба "YML" доступных только для суперюзера и редактора' do
  context 'когда проверяем блок "Автообновление"' do
    it 'присутствует заголовок блока' do
      expect(@yml_tab.autoupdate_title?).to be true
      expect(@yml_tab.autoupdate_title).to eq 'Автообновление'
    end

    context 'когда автообновление включено' do
      before(:all) { @yml_tab.enable_autoupdate_element.click }

      it 'присутствует заголовок блока "Интервал обновления" и селектор с периодом обновления' do
        expect(@yml_tab.autoupdate_period_label?).to be true
        expect(@yml_tab.autoupdate_period_label).to eq 'Интервал обновления'
        expect(@yml_tab.autoupdate_period?).to be true
      end

      it 'присутствует чекбокс "Обновлять в заданный час"' do
        expect(@yml_tab.autoupdate_set_hour?).to be true
      end

      it 'присутствует заголовок блока "Точное время обновления (MSK)" и текстовое поле' do
        expect(@yml_tab.autoupdate_start_hour_label?).to be true
        expect(@yml_tab.autoupdate_start_hour_label).to eq 'Точное время обновления (MSK)'
        expect(@yml_tab.autoupdate_start_hour?).to be true
      end
    end
  end
end

shared_examples 'проверка блоков таба "YML" доступных только для суперюзера' do
  context 'когда проверяем блок "Выбор формата"' do
    it 'присутствует заголовок блока' do
      expect(@yml_tab.format_title?).to be true
      expect(@yml_tab.format_title).to eq 'Выбор формата'
    end

    it 'присутствует тип выгрузки "Яндекс Маркет"' do
      expect(@yml_tab.xml_type_options).to include('Яндекс.Маркет')
    end

    it 'присутствует тип выгрузки "Google Merchant"' do
      expect(@yml_tab.xml_type_options).to include('Google Merchant')
    end
  end
end

shared_examples 'проверка таба "YML" для редактирующих ролей. Расширенный экспорт' do |role|
  context 'когда находимся на табе YML' do
    before(:all) do
      navigate_to(@export_page.page_url_value,
                  subdomain: CONFIG['kirby']['import']['paid_company']['subdomain'])
    end

    context 'когда проверяем блок "Тип выгрузки"' do
      it 'присутствует чекбокс "Не выгружать пустые группы"' do
        expect(@yml_tab.not_unload_empty_groups?).to be true
      end
    end

    context 'когда проверяем блок "Характеристики"' do
      it 'присутствует заголовок блока "Характеристики"' do
        expect(@yml_tab.user_traits_title?).to be true
        expect(@yml_tab.user_traits_title).to eq 'Характеристики'
      end

      it 'присутствует кнопка "Добавить фильтр"' do
        expect(@yml_tab.add_user_traits_filter?).to be true
      end

      context 'когда проверяем добавление фильтра характеристики' do
        before(:all) { @yml_tab.add_user_traits_filter_element.click }

        it 'отобразится блок "Название характеристики" и тектовое поле' do
          expect(@yml_tab.traits_name_label?).to be true
          expect(@yml_tab.trait_name?).to be true
        end

        it 'отобразится блок "Значение характеристики" и тектовое поле' do
          expect(@yml_tab.traits_value_label?).to be true
          expect(@yml_tab.trait_value?).to be true
        end
      end
    end

    context 'когда проверяем блок "Розничная цена"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.price_title?).to be true
        expect(@yml_tab.price_title).to eq 'Розничная цена'
      end

      it 'присутствует заголовок блока "Минимальная цена" и текстовое поле' do
        expect(@yml_tab.price_min_label?).to be true
        expect(@yml_tab.price_min_label).to eq 'Минимальная цена'
        expect(@yml_tab.price_min?).to be true
      end

      it 'присутствует заголовок блока "Максимальная цена" и текстовое поле' do
        expect(@yml_tab.price_max_label?).to be true
        expect(@yml_tab.price_max_label).to eq 'Максимальная цена'
        expect(@yml_tab.price_max?).to be true
      end
    end

    context 'когда проверяем блок "Структура экспорта"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.structure_title?).to be true
        expect(@yml_tab.structure_title).to eq 'Структура экспорта'
      end

      it 'присутствует режим "Рубрики"' do
        expect(@yml_tab.rubrics?).to be true
      end

      it 'присутствует режим "Товарные группы"' do
        expect(@yml_tab.groups?).to be true
      end
    end

    context 'когда проверяем блок "Выгружать все дерево групп"' do
      it 'присутствует заголовок блока' do
        expect(@yml_tab.tree_group_title?).to be true
        expect(@yml_tab.tree_group_title).to eq 'Выгружать все дерево групп'
      end

      it 'присутствует режим "Да"' do
        expect(@yml_tab.yes_all_groups?).to be true
      end

      it 'присутствует режим "Нет"' do
        expect(@yml_tab.no_all_groups?).to be true
      end
    end
  end
end
