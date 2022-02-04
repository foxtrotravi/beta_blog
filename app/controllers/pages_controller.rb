class PagesController < ApplicationController
    def home
    end

    property = Property.last

    property_plans = []
    property.property_plans.each do |property_plan|

        plan_dots = []
        property_plan.property_plan_dots.each do |dot|

          property_material_list = dot.property_materials
          property_materials = []

          property_material_list.each do |property_material|
            o = PropertyMaterial.find_by_id(property_material[:id])
            if o
              o.image_url = (o.image_url.nil? || o.image_url.empty?) ? o.image_url_with_default : o.image_url
              property_materials.push(o.attributes)
            end
          end

          plan_dots << {
            id: dot.id,
            budget_category_name: dot.budget_category_name,
            budget_category_id: dot.budget_category.id,
            x: dot.x,
            y: dot.y,
            annotation: dot.annotation,
            color: dot.budget_category.cost_code.material_color_code,
            property_materials: property_materials
          }
        end
      property_plans << {
        title: property_plan.title,
        description: property_plan.description,
        pic_orig_url: property_plan.pic.url(:original),
        pic_large_url: property_plan.pic.url(:large),
        pic_thumbnail_url: property_plan.pic.url(:thumb),
        dots: plan_dots
      }
    end

    render :json => property_plans

    o = PropertyMaterial.first
    if o
        o.image_url = (o.image_url.nil? || o.image_url.empty?) ? o.image_url_with_default : o.image_url
        property_materials.push(o.attributes)
    end

end
