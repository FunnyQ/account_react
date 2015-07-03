@Record = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td
        className: 'row-options',
        React.DOM.a
          className: 'btn btn-default btn-xs'
          onClick: @handleToggle
          '編輯'
        React.DOM.a
          className: 'btn btn-danger btn-xs'
          onClick: @handleDelete
          '刪除'

  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.amount
          ref: 'amount'
      React.DOM.td
        className: 'row-options'
        React.DOM.a
          className: 'btn btn-primary'
          onClick: @handleEdit
          '更新'
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          '取消'

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
