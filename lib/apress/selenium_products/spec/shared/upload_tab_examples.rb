# frozen_string_literal: true

shared_examples 'проверка таба "Загрузка товаров" для редактирующих ролей' do |role|
  context 'когда находимся на табе "Загрузить товары"' do
    before(:all) do
      @import_yml_page.upload_tab
      @import_yml_page.wait_for_upload_tab_active
    end

    it('присутствует текстовая зона "Инструкция и помощь по импорту"') \
      { expect(@upload_tab.text_zone_import?).to be true }

    context 'когда проверяем блок "Загрузка товаров"' do
      it 'присутствует заголовок "Загрузка товаров" и текстовая подсказка (?)' do
        expect(@upload_tab.upload_products_title?).to be true
        expect(@upload_tab.upload_products_title).to eq 'Загрузка товаров'
        expect(@upload_tab.upload_products_hint?).to be true
      end

      it('присутствует ссылка на последний загруженный файл') \
        { expect(@upload_tab.download_last_file?).to be true }

      context 'когда источник - Ссылка' do
        before(:all) { @upload_tab.switch_to_source_url }

        it 'присутствует заголовок "Ссылка" и поле ввода' do
          expect(@upload_tab.source_url_label?).to be true
          expect(@upload_tab.source_url_label).to eq 'Ссылка'
          expect(@upload_tab.source_url?).to be true
        end
      end

      context 'когда источник - Файл' do
        before(:all) do
          @upload_tab.switch_to_source_file
          @upload_tab.delete_file_element.click
        end

        context 'когда файл не загружен' do
          it 'присутствует область для загрузки файла и кнопка "загрузите"' do
            expect(@upload_tab.upload_field?).to be true
            expect(@upload_tab.upload_file_element.exists?).to be true
          end
        end

        context 'когда файл загружен' do
          before(:all) do
            @upload_tab.upload_yml(YAML_FILE_PATH)
            @upload_tab.save_upload
          end

          it('отобразится иконка файла') { expect(@upload_tab.icon_file?).to be true }
          it('отобразится название выбранного файла') { expect(@upload_tab.icon_file?).to be true }
          it('отобразится вес файла') { expect(@upload_tab.size_file?).to be true }
          it('отобразится иконка редактирования файла') { expect(@upload_tab.edit_file?).to be true }
          it('отобразится иконка удаления файла') { expect(@upload_tab.delete_file?).to be true }
        end
      end

      it 'присутствует заголовок "Формат" и выпадающий список со значениями YML, YRL и EDIFACT' do
        expect(@upload_tab.source_type_label?).to be true
        expect(@upload_tab.source_type_options).to eq %w[YML YRL EDIFACT]
      end

      it 'присутствует заголовок "Сайт магазина" и текстовое поле с ссылкой сайта' do
        expect(@upload_tab.store_url_label?).to be true
        expect(@upload_tab.store_url?).to be true
      end
    end

    context 'когда проверяем блок "Размещённые на сайте товары"' do
      it 'присутствует заголовок "Размещённые на сайте товары" и текстовая подсказка (?)' do
        expect(@upload_tab.recent_products_title?).to be true
        expect(@upload_tab.recent_products_title).to eq 'Размещённые на сайте товары'
        expect(@upload_tab.recent_products_hint?).to be true
      end

      it('доступен режим "Товаров нет"') { expect(@upload_tab.moving_no?).to be true }

      context 'когда выбран режим "Товары есть"' do
        before(:all) { @upload_tab.moving_yes }

        it('доступен режим "Оставить опубликованными"') { expect(@upload_tab.moving_keep?(2)).to be true }
        it('доступен режим "Удалить"') { expect(@upload_tab.moving_delete?(2)).to be true }
        it('доступен режим "Перенести в архив"') { expect(@upload_tab.moving_archive?(2)).to be true }
      end
    end

    context 'когда проверяем блок "Выбор групп"' do
      it 'присутствует заголовок "Выбор групп" и текстовая подсказка (?)' do
        expect(@upload_tab.choice_groups_title?).to be true
        expect(@upload_tab.choice_groups_title).to eq 'Выбор групп'
        expect(@upload_tab.choice_groups_hint?).to be true
      end
    end

    it('присутствует кнопка "Сохранить"') { expect(@upload_tab.save_upload?).to be true }
    it('присутствует кнопка "Загрузить"') { expect(@upload_tab.upload?).to be true }
    it('присутствует кнопка "Загрузить группы"') { expect(@upload_tab.upload_groups?).to be true }
  end
end

shared_examples 'проверка таба "Загрузка товаров" для владельца' do
  context 'когда находимся на табе "Загрузить товары"' do
    before(:all) do
      @import_yml_page.upload_tab
      @import_yml_page.wait_for_upload_tab_active
    end

    it('присутствует текстовая зона "Инструкция и помощь по импорту"') \
      { expect(@upload_tab.text_zone_import?).to be true }

    context 'когда проверяем блок "Загрузка товаров"' do
      it 'присутствует заголовок "Загрузка товаров" и текстовая подсказка (?)' do
        expect(@upload_tab.upload_products_title?).to be true
        expect(@upload_tab.upload_products_title).to eq 'Загрузка товаров'
        expect(@upload_tab.upload_products_hint?).to be true
      end

      it('присутствует ссылка на последний загруженный файл') \
        { expect(@upload_tab.download_last_file?).to be true }

      context 'когда источник - Ссылка' do
        before(:all) { @upload_tab.switch_to_source_url }

        it 'присутствует заголовок "Ссылка" и поле ввода' do
          expect(@upload_tab.source_url_label?).to be true
          expect(@upload_tab.source_url_label).to eq 'Ссылка'
          expect(@upload_tab.source_url?).to be true
        end
      end

      context 'когда источник - Файл' do
        before(:all) do
          @upload_tab.switch_to_source_file
          @upload_tab.delete_file_element.click
        end

        context 'когда файл не загружен' do
          it 'присутствует область для загрузки файла и кнопка "загрузите"' do
            expect(@upload_tab.upload_field?).to be true
            expect(@upload_tab.upload_file_element.exists?).to be true
          end
        end

        context 'когда файл загружен' do
          before(:all) do
            @upload_tab.upload_yml(YAML_FILE_PATH)
            @import_yml_page.settings_tab
            @settings_tab.save_settings
            @import_yml_page.upload_tab
          end

          it('отобразится иконка файла') { expect(@upload_tab.icon_file?).to be true }
          it('отобразится название выбранного файла') { expect(@upload_tab.icon_file?).to be true }
          it('отобразится вес файла') { expect(@upload_tab.size_file?).to be true }
          it('отобразится иконка редактирования файла') { expect(@upload_tab.edit_file?).to be true }
          it('отобразится иконка удаления файла') { expect(@upload_tab.delete_file?).to be true }
        end
      end

      it 'присутствует заголовок "Формат" и выпадающий список со значениями YML, YRL и EDIFACT' do
        expect(@upload_tab.source_type_label?).to be true
        expect(@upload_tab.source_type_options).to eq %w[YML YRL EDIFACT]
      end

      it 'присутствует заголовок "Сайт магазина" и текстовое поле с ссылкой сайта' do
        expect(@upload_tab.store_url_label?).to be true
        expect(@upload_tab.store_url?).to be true
      end
    end

    context 'когда проверяем блок "Размещённые на сайте товары"' do
      it 'присутствует заголовок "Размещённые на сайте товары" и текстовая подсказка (?)' do
        expect(@upload_tab.recent_products_title?).to be true
        expect(@upload_tab.recent_products_title).to eq 'Размещённые на сайте товары'
        expect(@upload_tab.recent_products_hint?).to be true
      end

      it('доступен режим "Товаров нет"') { expect(@upload_tab.moving_no?).to be true }

      context 'когда выбран режим "Товары есть"' do
        before(:all) { @upload_tab.moving_yes }

        it('доступен режим "Оставить опубликованными"') { expect(@upload_tab.moving_keep?(2)).to be true }
        it('доступен режим "Удалить"') { expect(@upload_tab.moving_delete?(2)).to be true }
        it('не доступен режим "Перенести в архив"') { expect(@upload_tab.moving_archive_not_exists?(2)).to be true }
      end
    end

    context 'когда проверяем блок "Выбор групп"' do
      it 'присутствует заголовок "Выбор групп" и текстовая подсказка (?)' do
        expect(@upload_tab.choice_groups_title?).to be true
        expect(@upload_tab.choice_groups_title).to eq 'Выбор групп'
        expect(@upload_tab.choice_groups_hint?).to be true
      end
    end

    it('присутствует кнопка "Загрузить"') { expect(@upload_tab.upload?).to be true }
  end
end
