/* global _ */
/* global _jed */
import React from 'react'
import createReactClass from 'create-react-class'

/* eslint-disable react/prop-types */
export const InputSelectWithIndex = createReactClass({
  propTypes: {},

  _onChange(event) {
    event.preventDefault()
    this.props.selectedValue.value.selection = this.props.selectedValue.field.values[parseInt(event.target.value)].value
    this.props.onChange()
  },

  _renderSelectValues(selectedValue) {
    return selectedValue.field.values.map((value, index) => {
      return (
        <option key={'' + index} value={'' + index}>
          {_jed(value.label)}
        </option>
      )
    })
  },

  render() {
    const props = this.props
    const selectedValue = props.selectedValue

    var index = -1
    for (var i = 0; i < selectedValue.field.values.length; i++) {
      if (selectedValue.field.values[i].value === selectedValue.value.selection) {
        index = i
      }
    }

    return (
      <div className="col1of2">
        <select className="width-full" onChange={this._onChange} value={'' + index}>
          {this._renderSelectValues(selectedValue)}
        </select>
      </div>
    )
  }
})
