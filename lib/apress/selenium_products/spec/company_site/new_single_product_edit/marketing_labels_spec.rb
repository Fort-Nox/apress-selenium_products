# frozen_string_literal: true

require 'spec_helper'

describe 'Новое единичное редактирование. Маркетинговые метки' do
         feature: 'Маркетинговые метки' do
  before(:all) do
    @product_page          = ProductPage.new
    @product_creation_page = CompanySite::NewSingleProductEditPage.new
    
    log_in_as(:admin)
    navigate_to_product_creation_page
  end

  after(:all) do
    @product_page.product_edit_link
    scroll_into_view(@product_creation_page.documents_title_element)
    @product_creation_page.select_only_site
    @product_creation_page.delete_marketing_label
    @product_creation_page.save
    log_out
  end

  context 'когда проверяем блок "Метки на товар"' do
    before(:all) { scroll_into_view(@product_creation_page.documents_title_element) }

    it 'присутсвует заголовок "Метки на товар" и подсказка (?)' do
      expect(@product_creation_page.marketing_labels_title?).to be true
      expect(@product_creation_page.marketing_labels_title).to eq 'Метки на товар'
      expect(@product_creation_page.marketing_labels_hint?).to be true
    end
  end

  context 'когда создаем новую маркетинговую метку и сохраняем' do
    before(:all) do
      @product_creation_page.name_input = 'Новый товар'
      scroll_into_view(@product_creation_page.documents_title_element)
      @product_creation_page.select_only_site
      @product_creation_page.add_marketing_label
      @product_creation_page.marketing_label_name = 'Новая метка'
      @product_creation_page.check_custom_label
      @product_creation_page.save
    end

    it 'отобразится кастомная метка' do
      expect(@product_page.custom_label?).to be true
    end
  end

  context 'когда создаем новую маркетинговую метку и сохраняем' do
    before(:all) do
      @product_creation_page.name_input = 'Новый товар'
      scroll_into_view(@product_creation_page.documents_title_element)
      @product_creation_page.select_only_site
      @product_creation_page.check_new
      @product_creation_page.check_product_month
      @product_creation_page.add_marketing_label
      @product_creation_page.marketing_label_name = 'Новая метка'
      @product_creation_page.check_custom_label
      @product_creation_page.save
    end
    
    it 'отобразится кастомная метка' do
      expect(@product_page.marketing_labels_elements.size).to eq 3
    end
  end
end

# когда выбираем 1 метку "Для портала и сайта"
# когда выбираем максимальное количество меток "Для портала и сайта"

# когда выбираем 1 метку "Только для сайта"
# когда выбираем максимальное количество меток "Только для сайта"

# когда выбираем 1 метку "Для портала и сайта" и 1 "Только для сайта"