ActiveAdmin.register Invoice do
  permit_params :legal_date, :number, :paid

  index do
    selectable_column
    id_column
    editable_column :number
    # editable { column :number }
    # bool_column :paid
    # editable { bool_column :paid }
    editable_column :paid
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

  form do |f|
    f.inputs "Details" do
      f.input :legal_date, as: :datepicker
      f.input :number
      f.input :paid
    end
    f.actions
  end
end
