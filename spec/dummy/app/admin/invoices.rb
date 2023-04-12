ActiveAdmin.register Invoice do
  permit_params :legal_date, :number, :paid, :state, :category_id, :city_id,
                :amount, :color, :updated_at, :picture, :active, :description,
                item_ids: [], other_item_ids: []

  filter :id, as: :numeric_range_filter

  filter :category_id, as: :search_select_filter,
                       url: "/admin/categories",
                       fields: [:name],
                       minimum_input_length: 0

  filter :created_at, as: :date_time_picker_filter

  index do
    selectable_column
    id_column
    tag_column :state, interactive: true
    bool_column :paid
    image_column :picture, style: :jpg_small
    number_column :amount, as: :currency, unit: "$", separator: ","
    toggle_bool_column :active
    markdown_column :description
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      tag_row :state
      state_row :aasm_state
      bool_row :paid
      list_row :skills, list_type: :ol
      list_row :contact, localize: true
      list_row :details, localize: true
      image_row("Mi picture", :picture, image_options: { width: 100 }, &:picture)
      row :legal_date
      number_row("Monto", :amount, as: :human, &:amount)
      row :city
      markdown_row(:description)
      bool_row :active
    end

    panel "Formtastic form" do
      render partial: "formtastic_form"
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :updated_at, as: :date_time_picker,
                           picker_options: {
                             min_date: Date.current - 2.days,
                             allow_times: [
                               '12:10', '13:10', '15:10',
                               '17:10', '18:10', '19:10'
                             ]
                           }

      f.input :state, as: :select

      f.input :category_id, as: :search_select,
                            url: proc { "/admin/categories" },
                            fields: [:name],
                            display_name: 'name',
                            minimum_input_length: 1,
                            width: '50%'
      f.input :paid

      f.input :amount

      f.input :number, as: :tags,
                       collection: ["0002-00000001", "0002-00004684"],
                       width: "400px"

      f.input :item_ids, as: :selected_list,
                         width: "40%",
                         fields: [:name],
                         display_name: :name,
                         minimum_input_length: 1

      f.input :other_item_ids, as: :tags, collection: Item.all.limit(5)

      f.input :description

      f.input :legal_date

      f.input :picture, as: :file

      f.input :color, as: :color_picker,
                      palette: Invoice.colors

      f.input :city_id, as: :nested_select,
                        width: "50%",
                        fields: [:name],
                        display_name: 'name',
                        minimum_input_length: 0,
                        level_1: {
                          attribute: :country_id,
                          collection: Country.all
                        },
                        level_2: {
                          attribute: :region_id
                        },
                        level_3: {
                          attribute: :city_id,
                          minimum_input_length: 1,
                          fields: [:name, :information],
                          predicate: :start
                        }
    end

    f.actions
  end
end
