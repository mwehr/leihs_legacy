// FIXME: globals
/* global _ */

import React from 'react'
import createReactClass from 'create-react-class'

import { FieldAutocompleteWrapper } from './Components/Autocomplete/FieldAutocompleteWrapper'
import { FieldsDropdownData } from './util/FieldsDropdownData'

/* eslint-disable react/prop-types */
export const FieldSelection = createReactClass({
  propTypes: {},

  _onChange(result) {
    if (!result.id) {
      return
    }
    var field = _.find(this.props.fields, field => field.id == result.id)
    if (this.props._onSelect) {
      this.props._onSelect(field)
    }
  },

  _makeCall(term, callback) {
    callback(FieldsDropdownData._determineData(this.props.fields, this.props.selectedValues, term))
  },

  render() {
    return (
      <div className="col1of3">
        <label className="row margin-bottom-xxs">Feld auswählen</label>
        <FieldAutocompleteWrapper
          inputClassName="has-addon width-full ui-autocomplete-input"
          element="div"
          inputId="field-input"
          dropdownWidth="312px"
          label={null}
          _makeCall={this._makeCall}
          onChange={this._onChange}
          resetAfterSelection={true}
        />
      </div>
    )
  }
})
