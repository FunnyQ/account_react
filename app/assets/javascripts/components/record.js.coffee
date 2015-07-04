@Record = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: React.findDOMNode(@refs.title).value
      date: React.findDOMNode(@refs.date).value
      amount: React.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  recordRow: ->
    <tr>
      <td>{@props.record.date}</td>
      <td>{@props.record.title}</td>
      <td>{amountFormat(@props.record.amount)}</td>
      <td className="row-options">
        <a className="btn btn-default btn-xs" onClick={@handleToggle}>編輯</a>
        <a className="btn btn-danger btn-xs" onClick={@handleDelete}>刪除</a>
      </td>
    </tr>
  recordForm: ->
    <tr>
      <td>
        <input className="form-control" type="text" defaultValue={@props.record.date} ref="date" />
      </td>
      <td>
        <input className="form-control" type="text" defaultValue={@props.record.title} ref="title" />
      </td>
      <td>
        <input className="form-control" type="text" defaultValue={@props.record.amount} ref="amount" />
      </td>
      <td className="row-options">
        <a className="btn btn-primary" onClick={@handleEdit}>更新</a>
        <a className="btn btn-default" onClick={@handleToggle}>取消</a>
      </td>
    </tr>

  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
