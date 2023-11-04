# AASM Integration

## State Row

```ruby
show do
  attributes_table do
    state_row :state
  end
end
```
<img src="./images/aasm-integration-row.png" height="150" />

## State Column

```ruby
index do
  state_column :state
end
```

<img src="./images/aasm-integration-column.png" height="200" />

The name of the state will be the class name (rejected, approved, etc.), but you can pass a hash of options to map different states with tag colors.

```ruby
state_column(:state, states: { destroyed: "rejected" })
```

You will need to define inside `your_app/app/assets/stylesheets/active_admin.css.scss` the following:

```scss
.status_tag {
  &.rejected { background: $rejected-color; }
  &.approved { background: $approved-color; }
}
```

## Named state machines support

When the state machine name is different from `:default`, you must provide it in the `machine` attribute. This is needed when using multiple state machines in the same class.

For example, if the machine is defined like the AASM multiple states per class sample:

```ruby
class SimpleMultipleExample
  include AASM
  aasm :move, column: :moving_state do
    ...
  end

  aasm :work, column: :working_state do
    ...
  end
end
```

Then you should define your admin like this:

```ruby
index do
  state_column :moving_state, machine: :move
  state_column :working_state, machine: :work
end

show do
  attributes_table do
    state_row :moving_state, machine: :move
    state_row :working_state, machine: :work
  end
end
```

## Adding a title

You can add a static text title to the state column:

```ruby
state_column :state, title: "Changes when ..."
state_row :state, title: "Changes when ..."
```

You can use model field as a title:

```ruby
state_column :state, title: :state_changed_at
state_row :state, title: :state_changed_at
```

You can use a proc as a title:

```ruby
state_column :state, title: ->(model) { model.change_reason && "Reason: #{model.change_reason}" }
state_row :state, title: ->(model) { model.change_reason && "Reason: #{model.change_reason}" }
```
