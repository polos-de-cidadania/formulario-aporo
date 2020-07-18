import { Controller } from 'stimulus';

export default class extends Controller {
    static targets = ['input'];

    connect() {
        if (!this.data.has('fieldName'))
            this.data.set('fieldName', this.inputTargets[0].name)

        this.inputTargets.forEach(input => {
            if (input.checked === true || input.selected === true)
                this.clear_others(input)
            input.addEventListener('input', ev => {
                this.clear_others(ev.target)
            })
        })
    }

    clear_others = (modified_input) => {
        modified_input.name = this.data.get('fieldName')

        this.inputTargets.forEach(input => {
            if (input === modified_input) return

            input.removeAttribute('name')
            if (input.type === 'radio')
                input.checked = false
            else if (input.type === 'checkbox')
                input.selected = false
            else
                input.value = null
        })
    }
}
