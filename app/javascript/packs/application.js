// This file is the (new) main entry point for client-side JavaScript.
// It is automatically compiled by Webpack.

// vendor-type deps (from npm)
import React from 'react'
import ReactDOM from 'react-dom'

// `react-rails` setup
import { ReactRailsUJS } from '../react-rails.js'

//
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//

// compat: exports from this file are exposed as window.Packs.application.FOO,
//         so they can be used from old sprockets-compiled `application.coffee`
// vendor modules
export { React, ReactDOM }

// react components bundle, when used *directly* from non-webpack code:
const componentRequireContext = ReactRailsUJS
export { componentRequireContext as requireComponent }
