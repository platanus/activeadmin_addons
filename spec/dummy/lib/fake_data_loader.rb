require '../../spec/support/data_loaders'

module FakeDataLoader
  extend DataLoaders

  def self.load_data
    create_categories(5)
    create_items(10)
    create_cities

    Invoice.create!(
      attachment: File.new('../../spec/assets/entradas_para_dragon_ball_z.pdf'),
      number: "0002-00000001,0002-00004684,4684",
      aasm_state: :accepted,
      color: '#C6A300',
      city: @santiago,
      paid: true,
      category: @category3,
      amount: 34000,
      items: [@item1, @item3],
      legal_date: Date.current - 5.days
    )

    Invoice.create!(
      photo: File.new('../../spec/assets/Rails.png'),
      number: "0002-00004684",
      color: '#D94000',
      city: @mendoza,
      state: :rejected,
      category: @category2,
      amount: 50000,
      items: [@item1, @item4, @item5],
      legal_date: Date.current
    )
  end
end
