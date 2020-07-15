import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['input'];

    connect() {
        this.inputTargets.forEach( input => {
            if(input.checked === true || input.selected === true)
                this.clear_others(input)
            input.addEventListener('input', ev => {
                this.clear_others(ev.target)
            })
        })
    }

    clear_others = (modified_input) => {
        this.inputTargets.forEach( input => {
            if (input === modified_input) return
            input.checked = false
            input.selected = false
            input.value = null
        })
    }
}
