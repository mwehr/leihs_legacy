import React from 'react'
import createReactClass from 'create-react-class'

import { FieldAutocompleteWrapper } from '../../Components/Autocomplete/FieldAutocompleteWrapper'

/* eslint-disable react/prop-types */
export const FieldAutocomplete = createReactClass({
  propTypes: {},

  _onChange(result) {
    if (this.props.onChange) {
      this.props.onChange(result)
    }
  },

  _makeCall(term, callback) {
    this.props.doSearch(term, result => {
      callback(result)
    })
  },

  render() {
    return (
      <div className="col1of2" data-type="value">
        <FieldAutocompleteWrapper
          inputClassName="has-addon width-full ui-autocomplete-input ui-autocomplete-loading"
          element="label"
          inputId={null}
          dropdownWidth="216px"
          label={this.props.label}
          _makeCall={this._makeCall}
          onChange={this._onChange}
          initialText={this.props.initialText}
          name={this.props.name}
        />
      </div>
    )
  }
})
