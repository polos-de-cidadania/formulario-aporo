import {Controller} from 'stimulus';

export default class extends Controller {
    static targets = ['depended', 'depends'];

    connect() {
        this.dependedTargets.forEach(depended => {
            this.updateDependants(depended)
            depended.addEventListener('input', ev => this.updateDependants(ev.target))
        })
    }

    updateDependants = (depended) => {
        let enabled = false

        if (depended.type === 'radio') {
            if (depended.checked) {
                if (this.data.has('enableValue'))
                    enabled = depended.value === this.data.get('enableValue')
                else if (this.data.has('enableValueNot'))
                    enabled = depended.value !== this.data.get('enableValueNot')
            }
        } else if (this.data.has('enableValue'))
            enabled = depended.value === this.data.get('enableValue')
        else if (this.data.has('enableValueNot'))
            enabled = depended.value !== this.data.get('enableValueNot')
        else
            enabled = parseInt(depended.value) > 0

        this.data.set('enabled', enabled)
        if (enabled) return

        this.dependsTargets.forEach(input => {
            if (input.type === 'radio') return

            input.value = enabled ? '' : null;
        })
    }
}
