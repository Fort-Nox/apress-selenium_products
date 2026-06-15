# frozen_string_literal: true

shared_examples 'проверка общих элементов на странице Импорта YML' do
  it 'присутствует title в формате "Загрузка товаров из YML/YRL - %название компании% - %основной регион%"' do
    expect(@import_yml_page.has_expected_title?).to be true
  end

  it 'присутствует заголовок страницы "Загрузить товары в формате Яндекс.Маркет (YML/YRL)"' do
    expect(@import_yml_page.header).to eq 'Загрузить товары в формате Яндекс.Маркет (YML/YRL)'
  end

  it 'присутствуют табы "Загрузить товары" и "Расширенные настройки"' do
    expect(@import_yml_page.upload_tab?).to be true
    expect(@import_yml_page.settings_tab?).to be true
  end
end
