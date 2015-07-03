@Records = React.createClass

  getInitialState: ->
    records: @props.data

  getDefaultProps: ->
    records: []

  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  balance: ->
    @debits() + @credits()

  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        '記帳簿'

      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', amount: @credits(), text: '總收入'
        React.createElement AmountBox, type: 'danger', amount: @debits(), text: '總支出'
        React.createElement AmountBox, type: 'info', amount: @balance(), text: '結餘'

      React.DOM.hr null

      # 表單
      React.createElement RecordForm, handleNewRecord: @addRecord

      React.DOM.hr null

      # 所有 records
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, '日期'
            React.DOM.th null, '標題'
            React.DOM.th null, '金額'
            React.DOM.th null, '選項'
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord
