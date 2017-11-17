import React from 'react'
import createReactClass from 'create-react-class'

import { DatePicker } from './DatePicker'

/* eslint-disable react/prop-types */
export const DatePickerWithInput = createReactClass({
  _renderPicker() {
    return (
      <DatePicker
        value={CreateItemFieldSwitch._parseDayMonthYear(this.state.value)}
        visible={this.state.visible}
        onSelect={this._onSelect}
        onClose={this._onClose}
      />
    )
  }
})
