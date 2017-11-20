/* global _jed */
import React from 'react'
import createReactClass from 'create-react-class'

import { FieldAutocomplete } from './util/FieldAutocomplete'
import { FieldAutocompletePreload } from './util/FieldAutocompletePreload'

/* eslint-disable react/prop-types */
export const InputAutocomplete = createReactClass({
  propTypes: {},

  _onChange(result) {
    this.props.selectedValue.value = {
      text: result.term,
      id: result.id
    }
    this.props.onChange()
  },

  render() {
    const props = this.props
    const selectedValue = props.selectedValue

    var field = selectedValue.field

    let url, doSearch
    let initialText = null
    if (selectedValue.value.id) {
      initialText = selectedValue.value.text
    }

    const transformResult = result => {
      return result.map(entry => {
        return {
          label: entry.label,
          id: entry.value
        }
      })
    }
    const searchInData = (data, term) => {
      return data.filter(field => {
        return field.name.toLowerCase().indexOf(term.toLowerCase()) >= 0
      })
    }

    if (field.values_dependency_field_id) {
      url = field.values_url.replace('$$$parent_value$$$', props.dependencyValue.value.id)

      doSearch = (data, term, callback) => {
        callback(transformResult(searchInData(data, term)))
      }

      return (
        <FieldAutocompletePreload
          label={_jed(field.label)}
          preloadUrl={url}
          doDelayedSearch={doSearch}
          onChange={this._onChange}
          name={'item[' + selectedValue.field.id + ']'}
          initialText={initialText}
        />
      )
    } else {
      doSearch = (term, callback) => {
        callback(transformResult(searchInData(term)))
      }

      return (
        <FieldAutocomplete
          label={_jed(field.label)}
          initialText={initialText}
          doSearch={doSearch}
          onChange={this._onChange}
          name={'item[' + selectedValue.field.id + ']'}
        />
      )
    }
  }
})
