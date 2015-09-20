module ActiveAdminAddons
  module EditableColumn
    class EditableBuilder < CustomBuilder
      def render
        builder = self

        context.div "class" => "editable-cell" do
          context.div "class" => "editable-cell-value" do
            context.a(
              "href" => "javascript:void(0);",
              "class" => "editable-cell-edit"
            ) do
              context.i "class" => "fa fa-pencil-square-o"
            end
            context.span("class" => "editable-cell-data") { builder.send(:data) }
          end

          context.div({
            "class" => "editable-cell-form",
            "data-url" => context.url_for([:admin, builder.send(:model), :format => :json])
          }) do
            context.a(
              "href" => "javascript:void(0);",
              "class" => "editable-cell-show"
            ) do
              context.i "class" => "fa fa-eye"
            end

            context.active_admin_form_for([:admin, model]) do |f|
              f.input builder.send(:attribute), {
                label: false
              }.merge(builder.send(:options))
            end
          end
        end
      end
    end

    module ::ActiveAdmin
      module Views
        class TableFor
          def editable_column(*args, &block)
            column(*args) { |model| EditableBuilder.render(self, model, *args, &block) }
          end
        end
      end
    end
  end
end
