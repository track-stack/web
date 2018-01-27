import React, { Component } from 'react'

export default class View extends React.Component {

  constructor(props) {
    super(props)

    this.state = { answer: ""}

    this.handleKeyPress = this.handleKeyPress.bind(this)
    this.onAnswerChange = this.onAnswerChange.bind(this)
  }

  onAnswerChange(e) {
      const value = e.currentTarget.value
      this.setState({ answer: value })
  }

  handleKeyPress(e) {
    if (e.key === "Enter") {
      const {answer} = this.state
      if (answer.trim() == "") { return }

      this.props.reset()
      this.props.submitAnswer(answer)

      this.refs.answerField.value = ""
      this.setState({ answer: "" })
    }
  }

  render() {
    const steps = this.props.steps.map((item, idx) => {
      const type = Object.prototype.toString.call(item.value)
      const indent = (item.options && item.options.indent) || 0
      const indentClass = `ind-${indent}`

      if (type === '[object Array]') {
        let list = item.value.map((val, idx) => {
          return (
            <li key={idx} dangerouslySetInnerHTML={{__html: `${val}`}} />
          )
        })       

        return (
          <div key={idx} className={indentClass}>
            <p key={`${item.key}-${idx}`} dangerouslySetInnerHTML={{__html: `${item.key}`}} />
            <ul className="">{list}</ul>
          </div>
        )
      } else if (type === '[object Null]') {
        return (
          <div key={idx} className={indentClass}><p dangerouslySetInnerHTML={{__html: `${item.key}`}} /></div>
        )
      }
    })

    return (
      <div>
        <div className="form-group" style={{paddingTop: 40}}>
          <input 
            type="text" 
            ref="answerField" 
            className="form-control" 
            onKeyPress={this.handleKeyPress} 
            onChange={this.onAnswerChange} 
          />
        </div>
        <div className="steps">
          {steps}
        </div>
      </div>
    )
  }
}
