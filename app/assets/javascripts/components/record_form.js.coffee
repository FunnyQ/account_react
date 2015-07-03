@RecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''

  valid: ->
    @state.title && @state.date && @state.amount

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.ajax
      method: 'POST'
      url: '/records'
      data:
        record: @state
      dataType: 'JSON'
      success: (data) =>
        @props.handleNewRecord data
        @setState @getInitialState()

    # $.post '', { record: @state }, (data) =>
    #   @props.handleNewRecord data
    #   @setState @getInitialState()
    # , 'JSON'

  render: ->
    React.DOM.form
      className: 'form'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'row'
        React.DOM.div
          className: 'form-group col-xs-4'
          React.DOM.label
            htmlFor: 'date'
            '日期'
          React.DOM.input
            type: 'text'
            className: 'form-control'
            placeholder: '例：20150701'
            name: 'date'
            value: @state.date
            onChange: @handleChange
        React.DOM.div
          className: 'form-group col-xs-4'
          React.DOM.label
            htmlFor: 'title'
            '標題'
          React.DOM.input
            type: 'text'
            className: 'form-control'
            placeholder: '例：早餐'
            name: 'title'
            value: @state.title
            onChange: @handleChange
        React.DOM.div
          className: 'form-group col-xs-4'
          React.DOM.label
            htmlFor: 'amount'
            '金額'
          React.DOM.input
            type: 'number'
            className: 'form-control'
            placeholder: '例：-50'
            name: 'amount'
            value: @state.amount
            onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        '寫下紀錄'
