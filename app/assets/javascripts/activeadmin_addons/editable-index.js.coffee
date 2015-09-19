getInputElement = (element) ->
  element.find("input, select").last()

getInputValue = (element) ->
  if element.is(":checkbox")
    if element.is(":checked") then 1 else 0
  else
    element.val()

triggerChange = (element, callback) ->
  if element.is("input[type=text]")
    element.on "keydown", (event) =>
      if event.which == 13
        event.preventDefault()
        callback(event)
  else if element.is("select")
    element.on "change", callback
  else if element.is(":checkbox")
    element.on "change", (event) ->
      event.stopPropagation()
      callback(event)
    element.on "click", (event) ->
      event.stopPropagation()

class EditableCell
  constructor: (@root) ->
    @valueElement = @root.find(".editable-cell-value")
    @textValueElement = @valueElement.find(".editable-cell-show")
    @formElement = @root.find(".editable-cell-form")
    @url = @formElement.data("url")
    @httpMethod = @_getAttributeAndDestroy(@formElement.find("[name=_method]"), "value")
    @authToken = @_getAttributeAndDestroy(@formElement.find("[name=authenticity_token]"), "value")
    @utf8 = @_getAttributeAndDestroy(@formElement.find("[name=utf8]"), "value")
    @inputElement = getInputElement(@formElement)
    @inputName = @inputElement.attr("name")

    @inputElement.attr("autocomplete", false)

  attachEvents: ->
    @root.on "click", ".editable-cell-edit", (event) => @displayForm(event)
    @root.on "click", ".editable-cell-show", (event) => @hideForm(event)

    triggerChange @inputElement, (event) => @submitChange(event)

  displayForm: (event) ->
    @valueElement.hide()
    @formElement.show()
    @inputElement.focus()

  hideForm: (event) ->
    @valueElement.show()
    @formElement.hide()

  submitChange: (_event) ->
    submission = @_buildSubmission()
    submission.done (data) =>
      @afterSave(data)

    submission.fail ({status}) =>
      if status == 422
        @showValidationError()
      else
        @showServerError()

  afterSave: (data) ->
    @textValueElement.text(getInputValue(@inputElement))
    @hideForm()

  showValidationError: ->
    # TODO: Display this nicely
    alert("Invalid data")

  showServerError: ->
    # TODO: Display this nicely
    alert("Server Error")

  _getAttributeAndDestroy: (element, attribute) ->
    value = element.attr(attribute)
    element.remove()
    value

  _buildSubmission: ->
    $.ajax(
      accepts: "application/json",
      url: @url,
      method: @httpMethod,
      data: @_buildPayload()
    )

  _buildPayload: ->
    payload = {
      _method: @httpMethod,
      authenticity_token: @authToken,
      utf8: @utf8
    }
    payload[@inputName] = getInputValue(@inputElement)
    payload


$ ->
  # ActiveAdmin wants to control our checkboxes.
  # This is a hack but it works.
  $(document).off "change", "paginated_collection :checkbox"
  $(document).on "change", ".paginated_collection :checkbox", ->
    return if $(@).closest(".editable-cell").length

    if $(".paginated_collection :checkbox:checked").length
      $(".batch_actions_selector").each -> $(@).aaDropdownMenu("enable")
    else
      $(".batch_actions_selector").each -> $(@).aaDropdownMenu("disable")


  $(".editable-cell").each (i, el) ->
    cell = new EditableCell($(el))
    cell.attachEvents()
