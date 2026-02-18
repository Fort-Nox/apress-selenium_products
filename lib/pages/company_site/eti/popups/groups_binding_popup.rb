# frozen_string_literal: true

module CompanySite
  module ETI
    class Table
      class GroupsBindingPopup < self
        div(:popup, css: '.groups-popup__title')
        elements(:groups_tree, css: '.js-group-item')
        button(:save, css: '.groups-popup__save-button')

        def wait_for_visible
          popup_element.when_visible
        end

        def select_group(name)
          groups_tree_elements.find { |group| group.text.gsub(/\s+|\(\d+\)/, '') == name.gsub(/\s+/, '') }.click
          save
        end
      end
    end
  end
end
