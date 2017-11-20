import React from 'react'
import createReactClass from 'create-react-class'

import { SearchMask } from './SearchMask'
import { FieldSwitch } from './FieldSwitch'
import { EnsureDependents } from './util/EnsureDependents'

/* eslint-disable react/prop-types */
export const SearchMaskState = createReactClass({
  propTypes: {},

  _onChangeSelectedValue() {
    this._fireSelectedValuesChanged(this.props.selectedValues)
  },

  _preventSubmit(event) {
    event.preventDefault()
  },

  _onDeselect(event, field) {
    event.preventDefault()

    var selectedValues = this.props.selectedValues
    selectedValues = selectedValues.filter(selectedValue => {
      return selectedValue.field.id != field.id
    })

    this._fireSelectedValuesChanged(selectedValues)
  },

  _determineLeftOrRight() {
    const leftCount = this.props.selectedValues.filter(selectedValue => selectedValue.col == 'left').length
    const rightCount = this.props.selectedValues.filter(selectedValue => selectedValue.col == 'right').length

    if (leftCount <= rightCount) {
      return 'left'
    } else {
      return 'right'
    }
  },

  _onSelect(field) {
    var selectedValues = this.props.selectedValues
    selectedValues.push({
      field: field,
      value: FieldSwitch._createEmptyValue(field),
      col: this._determineLeftOrRight(),
      dependents: []
    })

    this._fireSelectedValuesChanged(selectedValues)
  },

  _fireSelectedValuesChanged(selectedValues) {
    EnsureDependents._ensureDependents(selectedValues, this.props.fields, {
      _hasValue: FieldSwitch._hasValue,
      _createEmptyValue: FieldSwitch._createEmptyValue,
      _isDependencyValue: FieldSwitch._isDependencyValue
    })
    this.props.selectedValuesChanged(selectedValues)
  },

  render() {
    return (
      <SearchMask
        onSelect={this._onSelect}
        fields={this.props.fields}
        selectedValues={this.props.selectedValues}
        preventSubmit={this._preventSubmit}
        _onDeselect={this._onDeselect}
        _onChangeSelectedValue={this._onChangeSelectedValue}
      />
    )
  }
})
