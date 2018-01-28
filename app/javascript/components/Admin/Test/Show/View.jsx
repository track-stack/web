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
    const expandTag = item => {
      if (!item.options) { return item.key }
      if (!item.options.tags) { return item.key }

      const input = item.key
      const tags = item.options.tags

      var str = ""
      tags.forEach((tag, idx) => {
        if (idx !== 0 && tag.range[0] - tags[idx - 1].range[1] > 0) {
          const prevTag = tags[idx - 1]
          const text = input.substr(prevTag.range[1], tag.range[0] - prevTag.range[1])
          str += text
        }
        
        const text = input.substr(tag.range[0], tag.range[1])
        const htmlTag = tag.tag
        const style = tag.style || ""
        
        str += `<${htmlTag} class="${style}">${text}</${htmlTag}>`
      })

      return str
    }

    const steps = this.props.steps.map((item, idx) => {
      const type = Object.prototype.toString.call(item.value)
      const indent = (item.options && item.options.indent) || 0
      const indentClass = `ind-${indent}`

      if (type === '[object Array]') {
        let list = item.value.map((val, idx) => {
          return (
            <li key={idx}>{val}</li>
          )
        })       

        return (
          <div key={idx} className={indentClass}>
            <p key={`${item.key}-${idx}`} dangerouslySetInnerHTML={{__html: `${expandTag(item)}`}} />
            <ul className="">{list}</ul>
          </div>
        )
      } else if (type === '[object Null]') {
        return (
          <div key={idx} className={indentClass}><p dangerouslySetInnerHTML={{__html: `${expandTag(item)}`}} /></div>
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
