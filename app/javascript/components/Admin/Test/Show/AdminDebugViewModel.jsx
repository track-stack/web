import React, { Component } from 'react'
import AttributedStringViewModel from './AttributedStringViewModel'

export default class AdminDebugStepViewModel extends React.Component {
    steps() {
      return this.props.steps.map((item, idx) => {
        const indent = (item.options && item.options.indent) || 0
        const indentClass = `ind-${indent}`

        return (
          <div key={idx} className={indentClass}>
            <AttributedStringViewModel string={item.key} attributes={item.options} />
          </div>
        )
      })
    }

    render() {
      return (
        <div>
          <div className="steps">
            {this.steps()}
          </div>
        </div>
      )
    }
}