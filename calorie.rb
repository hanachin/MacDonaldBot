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
      order =~ /[、 x×*0-9とを]/
    end

    def menu order
      if n = menu_name(order)
        [n, menu_calorie(n)]
      end
    end

    def take_menu orders
      orders.include?(menu_names)
    end

    def menus order
      alias_menu_name_table.keys
      prev_order = ''
      result = []
      order.split(/([、 x×*0-9とを]+)/).map {|order|
        if menu order
          prev_order = order
          result.push menu order
        else
          order =~ /([0-9]+)/
          if $1 && $1.to_i >= 1
            ($1.to_i - 1).times { result.push menu(prev_order) }
          end
        end
      }
      result
    end

    def calorie(order)
      if many_menus? order
        menus(order).map(&:last).inject(&:+)
      else
        menu(order).last
      end
    end

    def name(order)
      if many_menus? order
        ns = menus(order).map(&:first)
        ns.uniq.map {|n|
          if (c = ns.count(n)) > 1
            "#{n}x#{c}"
          else
            n
          end
        }.join("、")
      else
        menu(order).last
      end
    end
  end
end
