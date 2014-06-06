ActiveAdmin.register Invoice do
  permit_params :legal_date, :number, :paid

  index do
    selectable_column
    id_column
    bool_column :paid
    actions
  end

  show do
    attributes_table do
      row :id
      row :legal_date
      row :number
      bool_row :paid
    end
  end
end
