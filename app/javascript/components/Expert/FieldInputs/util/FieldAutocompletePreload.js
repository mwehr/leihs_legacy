// FIXME: globals
/* global App $ */

import React from 'react'
import createReactClass from 'create-react-class'

import { FieldAutocomplete } from './FieldAutocomplete'

/* eslint-disable react/prop-types */
export const FieldAutocompletePreload = createReactClass({
  propTypes: {},

  getInitialState() {
    return {
      data: null
    }
  },

  componentDidMount() {
    App.Model
      .ajaxFetch({
        url: this.props.preloadUrl,
        data: $.param({
          format: 'json'
        })
      })
      .done(data => {
        this.setState({ data: data })
      })
  },

  render() {
    if (!this.state.data) {
      return <div />
    }

    var doSearch = (term, callback) => {
      this.props.doDelayedSearch(this.state.data, term, callback)
    }

    return (
      <FieldAutocomplete
        label={this.props.label}
        doSearch={doSearch}
        onChange={this.props.onChange}
        initialText={this.props.initialText}
        name={this.props.name}
      />
    )
  }
})
