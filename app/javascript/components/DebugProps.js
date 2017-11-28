import React from 'react'
import createReactClass from 'create-react-class'
import PropTypes from 'prop-types'
import cx from 'classnames'

const stringifyObj = obj => {
  let res
  try {
    res = JSON.stringify(props)
  } catch (e) {}
  return res || props.toString()
}

const DebugProps = props => (
  <div
    style={{
      border: '1px solid tomato',
      background: 'papayawhip',
      padding: '1.5rem',
      fontSize: '1.5rem'
    }}>
    <pre>{JSON.stringify(props) || props.toString()}</pre>
  </div>
)

export default DebugProps
