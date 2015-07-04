@Records = React.createClass
  displayName: 'Records'

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

  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records

  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records

  render: ->
    <div className="records">
      <h2 className="title">記帳簿</h2>

      {# 資訊面板}
      <div className="row">
        <AmountBox type="success" amount={@credits()} text="總收入"></AmountBox>
        <AmountBox type="success" amount={@debits()} text="總支出"></AmountBox>
        <AmountBox type="success" amount={@balance()} text="結餘"></AmountBox>
      </div>

      <hr />

      {# 表單}
      <RecordForm handleNewRecord={@addRecord} ></RecordForm>

      <hr />

      <table className="table table-bordered">
        <thead>
          <tr>
            <th>日期</th>
            <th>標題</th>
            <th>金額</th>
            <th>選項</th>
          </tr>
        </thead>
        <tbody>
          {
            # 迴圈之類的要放在大括號中，讓 coffeescript 先生效後再於 block 內插入 JSX 語法
            for record in @state.records
              <Record key={record.id} record={record} handleDeleteRecord={@deleteRecord} handleEditRecord={@updateRecord} ></Record>
          }
        </tbody>
      </table>
    </div>
