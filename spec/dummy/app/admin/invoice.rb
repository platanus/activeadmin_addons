ActiveAdmin.register Invoice do
  permit_params :legal_date, :number, :paid

  index do
    selectable_column
    id_column
    bool_column :paid
    actions
  end  
end
