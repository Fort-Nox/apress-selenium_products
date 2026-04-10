# frozen_string_literal: true

module CompanySite
  module ETI
    class Table
      class SettingsProductsAndGroupsMain < self
        # Попап "Настройка товаров и групп на главной"
        div(:popup, css: '.storefront-popup')

        button(:save, css: '.js-submit-storefront')
        button(:close, css: '.ui-dialog-titlebar-close')

        # Табы переключения между товарами и группами
        button(:products_tab, css: '[aria-controls="tab-product-storefront"]')
        button(:groups_tab, css: '[aria-controls="tab-product-storefront"]')

        # Видимость товаров
        checkbox(:show_products_main, id: '#product-storefront-show')

        # Видимость групп
        checkbox(:show_groups_main, id: '#groups-storefront-show')

        # Вид витрины
        radio_button(:view_list, css: '[value="list"]')
        radio_button(:view_gallery, css: '[value="gallery"]')

        # Видимость цен товаров
        checkbox(:show_products_prices_main, id: '#price-show-storefront')

        def wait_for_visible
          popup_element.when_visible
        end
      end
    end
  end
end
