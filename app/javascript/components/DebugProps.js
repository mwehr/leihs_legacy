import React from 'react'
import cx from 'classnames'
import f from 'lodash'

function stringifyObj(obj) {
  obj = obj === null ? 'null' : obj === undefined ? 'undefined' : obj
  try {
    return JSON.stringify(obj, 0, 2)
  } catch (err) {
    return `Object: ${obj.toString()}; Error: ${f.trim(err)}`
  }
}

const DebugProps = props => {
  return (
    <div className={cx('react-compoent', { 'component-debug-props': true })}>
      <pre
        style={{
          border: '0.15rem solid tomato',
          background: 'papayawhip',
          padding: '1.5rem',
          fontSize: '1.5rem',
          fontFamily: 'Source Code Pro, Menlo, Monaco, monospace',
          whiteSpace: 'pre-wrap'
        }}>
        {f.trim(stringifyObj(props))}
      </pre>
    </div>
  )
}

export default DebugProps
