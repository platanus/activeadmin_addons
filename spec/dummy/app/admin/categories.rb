ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
