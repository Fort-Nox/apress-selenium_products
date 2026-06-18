# frozen_string_literal: true

require 'spec_helper'

describe 'Новое единичное редактирование. Служебные метки',
         feature: 'Новое единичное редактирование. Служебные метки' do
  before(:all) do
    @product_page          = ProductPage.new
    @product_creation_page = CompanySite::NewSingleProductEditPage.new
  end

  shared_context 'роль с повышенными правами' do |role, name|
    context "когда роль - #{name}" do
      before(:all) do
        log_in_as(role)
        navigate_to_product_creation_page
      end
      
      after(:all) do
        log_out
        Page.browser.manage.delete_all_cookies
        reload_page
      end

      include_examples 'проверка блока "Служебные метки"', role
    end
  end

  shared_context 'роль с ограниченными правами' do |role, name|
    context "когда роль - #{name}" do
      before(:all) do
        log_in_as(role)
        navigate_to_product_creation_page
      end
      
      after(:all) do
        log_out
        Page.browser.manage.delete_all_cookies
        reload_page
      end

      include_examples 'проверка блока "Служебные метки"', role
    end
  end
  
  shared_examples 'проверка блока "Служебные метки"' do |role|
    if[:admin, :editor, :franchise_ru].include?(role)
      it 'присутсвует заголовок "Служебные метки" и подсказка (?)' do
        expect(@product_creation_page.service_labels_title?).to be true
        expect(@product_creation_page.service_labels_title).to eq 'Служебные метки'
        expect(@product_creation_page.service_labels_hint?).to be true
      end
    else
      it 'отсутсвует заголовок "Служебные метки" и подсказка (?)' do
        expect(@product_creation_page.service_labels_title?).to be false
      end
    end

    if[:admin, :editor, :franchise_ru].include?(role)
      it 'присутствуют все служебные метки' do
        CompanySite::NewSingleProductEditPage::SERVICE_LABELS.each do |label|
          expect(@product_creation_page.send("#{label}_element").present?).to be true
        end
      end
    end
  end

  describe 'Доступность блока "Служебные метки"' do
    context 'когда проверяем блок "Служебные метки"' do
      include_context 'роль с повышенными правами', :admin, 'Суперюзер'
      include_context 'роль с повышенными правами', :editor, 'Редактор СК'
      include_context 'роль с повышенными правами', :franchise_ru, 'Франшиза (регион компании)'
      include_context 'роль с ограниченными правами', :user, 'Владелец'
    end
  end

  describe 'Простановка служебных меток' do
    before(:all) { log_in_as(:admin) }
    
    after(:all) { log_out }
    
    context 'когда добавляем одну служебную метку и сохраняем' do
      before do
        navigate_to_product_creation_page
        @product_creation_page.name_input = 'Премиум-блок'
        @product_creation_page.set_service_labels(:premium)
        @product_creation_page.save
        @product_page.product_edit_link
      end

      after do
        @product_creation_page.delete
        @product_creation_page.edit_yes
      end

      it 'чекбокс "Премиум-блок" активен' do
        expect(@product_creation_page.premium_checked?).to be true
      end
    end

    context 'когда редактируем на другую служебную метку' do
      before(:all) do
        navigate_to_product_creation_page
        @product_creation_page.name_input = 'Проработано SEO PRO 3'
        @product_creation_page.set_service_labels(:premium)
        @product_creation_page.save
        @product_page.product_edit_link
        @product_creation_page.set_service_labels(:seo_pro_processed_3)
        @product_creation_page.save
        @product_page.product_edit_link
      end

      after(:all) do
        @product_creation_page.delete
        @product_creation_page.edit_yes
      end

      it 'чекбокс "Премиум-блок" неактивен' do
        expect(@product_creation_page.premium_checked?).to be false
      end
      
      it 'чекбокс "Проработано SEO PRO 3" активен' do
        expect(@product_creation_page.seo_pro_processed_3_checked?).to be true
      end
    end

    context 'когда удаляем служебную метку' do
      before do
        navigate_to_product_creation_page
        @product_creation_page.name_input = 'Нет служебной метки'
        @product_creation_page.set_service_labels(:premium)
        @product_creation_page.save
        @product_page.product_edit_link
        @product_creation_page.set_service_labels([])
        @product_creation_page.save
        @product_page.product_edit_link
      end

      it 'чекбокс "Премиум-блок" неактивен' do
        expect(@product_creation_page.premium_checked?).to be false
      end
    end
  end
end
