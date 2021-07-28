ActiveAdmin.register Item do
  permit_params :name, :description

  form do |f|
    f.inputs do
      f.input :created_at
    end
    f.actions
  end
end
