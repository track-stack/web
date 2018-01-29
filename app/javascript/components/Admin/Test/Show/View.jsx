import React, { Component } from 'react'
import AdminDebugStepViewModel from './AdminDebugViewModel'

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
        <AdminDebugStepViewModel steps={this.props.steps} />
       </div>
    )
  }
}
