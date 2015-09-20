ActiveAdmin.register Invoice do
  permit_params :legal_date, :number, :paid

  index do
    selectable_column
    id_column
    editable_column :number, :as => :string
    # TODO: bool_column :paid, editable: { :as => :checkbox }
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

  form do |f|
    f.inputs "Details" do
      f.input :legal_date, as: :datepicker
      f.input :number
      f.input :paid
    end
    f.actions
  end
end
