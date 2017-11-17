import React from 'react'
import createReactClass from 'create-react-class'

import { DatePickerWithInput } from '../Components/DatePicker/DatePickerWithInput'

/* eslint-disable react/prop-types */
export const InputDate = createReactClass({
  propTypes: {},

  _onChange(date) {
    this.props.selectedValue.value.at = date
    this.props.onChange()
  },

  render() {
    const props = this.props
    const selectedValue = props.selectedValue

    return (
      <div className="col1of2" data-type="value">
        <DatePickerWithInput
          value={selectedValue.value.at}
          name={'item[' + selectedValue.field.id + ']'}
          onChange={this._onChange}
        />
      </div>
    )
  }
})
