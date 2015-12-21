ActiveAdmin.register Invoice do
  permit_params :legal_date, :number, :paid, :state, :attachment, :photo, :category_id,
    :city_id

  index do
    selectable_column
    id_column
    tag_column :state
    bool_column :paid
    image_column :photo, style: :thumb
    attachment_column :attachment
    number_column :number, as: :currency, unit: "$", separator: ","
    actions
  end

  show do
    attributes_table do
      row :id
      tag_row :state
      bool_row :paid
      image_row("Mi foto", :photo, style: :big, &:photo)
      attachment_row("Mi documento", :attachment, truncate: false, &:attachment)
      row :legal_date
      number_row("Número", :number, as: :human, &:number)
      row :city
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :state
      f.input :category_id, as: :search_select, url: admin_categories_path,
                            fields: [:name], display_name: 'name',
                            minimum_input_length: 1
      f.input :paid
      f.input :number, as: :tags, collection: ["value 1", "value 2"]
      f.input :attachment
      f.input :photo

      f.input :city_id, as: :nested_select,
                        fields: [:name], display_name: 'name',
                        minimum_input_length: 1,
                        parents: [:region_id, :country_id]
    end
    f.actions
  end
end
