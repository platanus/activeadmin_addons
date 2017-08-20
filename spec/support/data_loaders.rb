module DataLoaders
  def create_items(count = 3)
    1.upto(count).each do |idx|
      item = Item.where(name: "Item ##{idx}", description: "Desc #{idx}").first_or_create!
      instance_variable_set("@item#{idx}", item)
    end
  end

  def create_categories(count = 2)
    1.upto(count).each do |idx|
      cat = Category.where(name: "Cat ##{idx}", description: "Desc #{idx}").first_or_create!
      instance_variable_set("@category#{idx}", cat)
    end
  end

  def create_cities
    @chile = Country.where(name: "Chile").first_or_create!
    @argentina = Country.where(name: "Argentina").first_or_create!

    @metropolitana = Region.where(name: "Metropolitana", country: @chile).first_or_create!
    @antofagasta = Region.where(name: "Antofagasta", country: @chile).first_or_create!
    @cuyo = Region.where(name: "Cuyo", country: @argentina).first_or_create!

    @santiago = City.where(
      name: "Santiago", region: @metropolitana, information: "info1"
    ).first_or_create!
    @colina = City.where(name: "Colina", region: @metropolitana).first_or_create!
    @mejillones = City.where(name: "Mejillones", region: @antofagasta).first_or_create!
    @tocopilla = City.where(name: "Tocopilla", region: @antofagasta).first_or_create!
    @mendoza = City.where(name: "Mendoza", region: @cuyo).first_or_create!
  end

  def create_invoice(data = {})
    @invoice = Invoice.first_or_create!(data)
  end
end
