/* global _ */
/* global _jed */
import React from 'react'
import createReactClass from 'create-react-class'

import { DatePickerWithInput } from '../Components/DatePicker/DatePickerWithInput'

/* eslint-disable react/prop-types */
export const InputDateRange = createReactClass({
  propTypes: {},

  _onChangeFrom(date) {
    this.props.selectedValue.value.from = date
    this.props.onChange()
  },

  _onChangeTo(date) {
    this.props.selectedValue.value.to = date
    this.props.onChange()
  },

  render() {
    const props = this.props
    const selectedValue = props.selectedValue

    return (
      <div className="col1of2" data-type="value">
        <div className="col1of2">
          von:
          <DatePickerWithInput value={selectedValue.value.from} onChange={this._onChangeFrom} />
        </div>
        <div className="col1of2">
          bis:
          <DatePickerWithInput value={selectedValue.value.to} onChange={this._onChangeTo} />
        </div>
      </div>
    )
  }
})
