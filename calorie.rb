#encoding: utf-8

require 'yaml'

# http://www.mcdonalds.co.jp/quality/allergy_Nutrition/nutrient2.php?id=1
# こぴぺ: $.makeArray($('tr').map(function (){return [$(this).find('td.item').text(), $(this).find('td:nth-child(3)').text()]}))

# 理想
# Order.new('グラころ2つ、ナゲット1個').each {|item, calorie|
#   # 1. グラコロ
#   # 2. グラコロ
#   # 3. ナゲット
# }

# - セット
# - サイズ
# - 個数
# - 味

class FastFood
  class << self
    def calorie_table
      @calorie_table ||= YAML.load_file 'calorie.yaml'
    end

    def menu_names
      @menu_names ||= calorie_table.keys
    end

    def alias_menu_name_table
      @alias_menu_name_table ||= YAML.load_file 'alias.yaml'
    end

    def menu_name(name)
      if menu_names.include? name
        name
      else
        alias_menu_name_table[name]
      end
    end

    def menu_calorie(name)
      calorie_table[name]
    end

    def many_menus?(order)
      order =~ /[、 ]/
    end

    def menu order
      n = menu_name order
      {n => menu_calorie(n)}
    end

    def take_menu orders
      orders.include?(menu_names)
    end

    def menus order
      alias_menu_name_table.keys
      order.split(/[、 ]/).inject({}) {|orders, order|
        orders.merge menu order
      }
    end

    def calorie(order)
      if many_menus? order
        menus order
      else
        menu order
      end
    end
  end
end