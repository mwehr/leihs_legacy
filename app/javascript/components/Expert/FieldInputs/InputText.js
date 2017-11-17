/* global _ */
/* global _jed */
import React from 'react'
import createReactClass from 'create-react-class'

/* eslint-disable react/prop-types */
export const InputText = createReactClass({
  propTypes: {},

  _onChange(event) {
    event.preventDefault()
    this.props.selectedValue.value.text = event.target.value
    this.props.onChange()
  },

  render() {
    const props = this.props
    const selectedValue = props.selectedValue

    return (
      <div className="col1of2" data-type="value">
        <input
          autoComplete="off"
          className="width-full"
          name={'item' + BackwardTestCompatibility._getFormName(selectedValue)}
          type="text"
          value={selectedValue.value.text}
          onChange={this._onChange}
        />
      </div>
    )
  }
})
