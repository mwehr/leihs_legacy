// compat: modules used in legacy code via globals:

// vendor-type deps (from npm)
import React from 'react'
import ReactDOM from 'react-dom'
window.React = React
window.ReactDOM = ReactDOM

// // own stuff
import { HandoverAutocomplete } from '../components/HandoverAutocomplete.js'
window.HandoverAutocomplete = HandoverAutocomplete

// import { DebugProps } from '../components/DebugProps.js'
// window.DebugProps = DebugProps

// console.log('JS pack: loaded `globals`!')
