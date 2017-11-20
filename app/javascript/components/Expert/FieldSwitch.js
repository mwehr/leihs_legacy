import React from 'react'

import { InputCurrency } from '../Expert/FieldInputs/InputCurrency'
import { InputText } from '../Expert/FieldInputs/InputText'
import { InputTextarea } from '../Expert/FieldInputs/InputTextarea'
import { InputSelectWithIndex } from '../Expert/FieldInputs/InputSelectWithIndex'
import { InputRadio } from '../Expert/FieldInputs/InputRadio'
import { InputAutocomplete } from '../Expert/FieldInputs/InputAutocomplete'
import { InputAutocompleteSearch } from '../Expert/FieldInputs/InputAutocompleteSearch'
import { InputDateRange } from '../Expert/FieldInputs/InputDateRange'

export const FieldSwitch = {
  _hasValue(selectedValue) {
    switch (selectedValue.field.type) {
      case 'text':
        if (selectedValue.field.currency) {
          return selectedValue.value.from.trim().length > 0 && selectedValue.value.to.trim().length > 0
        } else {
          return selectedValue.value.text.trim().length > 0
        }

      case 'autocomplete-search':
        return selectedValue.value.id != null

      case 'autocomplete':
        return selectedValue.value.id != null

      case 'textarea':
        return selectedValue.value.text.trim().length > 0

      case 'select':
        return true

      case 'radio':
        return true

      case 'date':
        return selectedValue.value.from.trim().length > 0 && selectedValue.value.to.trim().length > 0

      default:
        throw 'Unexpected type: ' + selectedValue.field.type
    }
  },

  _createEmptyValue(field) {
    switch (field.type) {
      case 'text':
        if (field.currency) {
          return { from: '', to: '' }
        } else {
          return { text: '' }
        }

      case 'autocomplete-search':
        return {
          text: '',
          id: null
        }

      case 'autocomplete':
        return {
          text: '',
          id: null
        }

      case 'textarea':
        return { text: '' }

      case 'attachment':
        break
      case 'select':
        return { selection: field.default }

      case 'radio':
        return { selection: field.default }

      case 'date':
        return { from: '', to: '' }

      default:
        throw 'Unexpected type: ' + field.type
    }
  },

  _isDependencyValue(selectedValue, fieldDependencyValue) {
    switch (selectedValue.field.type) {
      case 'text':
        if (selectedValue.field.currency) {
          throw 'Not implemented yet.'
        } else {
          return selectedValue.value.text == fieldDependencyValue
        }

      case 'autocomplete-search':
        return selectedValue.value.text == fieldDependencyValue

      case 'autocomplete':
        return selectedValue.value.id == fieldDependencyValue

      case 'textarea':
        return selectedValue.value.text == fieldDependencyValue

      case 'select':
        return '' + selectedValue.value.selection == fieldDependencyValue

      case 'radio':
        return '' + selectedValue.value.selection == fieldDependencyValue

      case 'date':
        throw 'Not implemented yet.'

      default:
        throw 'Unexpected type: ' + selectedValue.field.type
    }
  },

  _inputByType(selectedValue, onChangeSelectedValue, dependencyValue) {
    switch (selectedValue.field.type) {
      case 'text':
        if (selectedValue.field.currency) {
          return <InputCurrency selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        } else {
          return <InputText selectedValue={selectedValue} onChange={onChangeSelectedValue} />
        }

      case 'autocomplete-search':
        return <InputAutocompleteSearch onChange={onChangeSelectedValue} selectedValue={selectedValue} />

      case 'autocomplete':
        return (
          <InputAutocomplete
            selectedValue={selectedValue}
            dependencyValue={dependencyValue}
            onChange={onChangeSelectedValue}
          />
        )

      case 'textarea':
        return <InputTextarea selectedValue={selectedValue} onChange={onChangeSelectedValue} />

      case 'select':
        return <InputSelectWithIndex selectedValue={selectedValue} onChange={onChangeSelectedValue} />

      case 'radio':
        return <InputRadio selectedValue={selectedValue} onChange={onChangeSelectedValue} />

      case 'date':
        return <InputDateRange selectedValue={selectedValue} onChange={onChangeSelectedValue} />

      default:
        throw 'Unexpected type: ' + selectedValue.field.type
    }
  }
}
