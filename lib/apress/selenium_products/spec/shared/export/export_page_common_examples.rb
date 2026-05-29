# frozen_string_literal: true

shared_examples 'проверка общих элементов на странице Экспорта YML/XLS' do
  it 'присутствует title в формате "Выгрузить товары в Excel, YML - %название компании% - %основной регион%"' do
    expect(@export_page.has_expected_title?).to be true
  end

  it 'присутствует заголовок страницы "Выгрузить товары в XLS, YML"' do
    expect(@export_page.header).to eq 'Выгрузить товары в XLS, YML'
  end

  it 'присутствуют таб и заголовок "YML"' do
    expect(@export_page.yml_tab_title?).to be true
    expect(@export_page.yml_tab_title).to eq 'YML'
    expect(@export_page.yml_tab?).to be true
  end

  it 'присутствуют таб и заголовок "XLS"' do
    expect(@export_page.xls_tab_title?).to be true
    expect(@export_page.xls_tab_title).to eq 'XLS'
    expect(@export_page.xls_tab?).to be true
  end
end
