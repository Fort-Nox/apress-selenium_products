# frozen_string_literal: true

require 'spec_helper'

describe 'Новая форма создания товара', feature: 'Редактирование товара' do
  before(:all) do
    @product_page          = ProductPage.new
    @product_creation_page = CompanySite::ProductCreationPage.new

    log_in_as(:admin)
  end

  context 'когда изменяем название и цену' do
    before(:all) do
      @options = {
        name: CONFIG['product_creation']['name']['valid'],
        price: CONFIG['product_creation']['price']['exact']
      }
      
      navigate_to_product_creation_page
      @product_creation_page.fill_attributes(@options)
      @product_page.product_edit_link
      @product_creation_page.clear_string(@options)
      @options[:name] = 'Новое название товара'
      @options[:price] = '200'
      @product_creation_page.fill_attributes(@options)
    end

    it 'на карточке товара отобразится новое название' do
      expect(@product_page.product_name).to eq 'Новое название товара'
    end

    it 'на карточке товара отобразится новая цена' do
      expect(@product_page.product_price).to include '200'
    end
  end
end
