import { Controller } from 'stimulus';

export default class extends Controller {
	static targets = ['page', 'section'];

	connect() {
		const first_error = document.getElementsByClassName('field_with_errors')[0]
		first_error && first_error.scrollIntoView()
	}

	back(ev) {
		const page = parseInt(this.pageTarget.value) - 1
		this.pageTarget.value = page
		this.sectionTargets.forEach((section, i) => {
			if (i == page || i == page + 1)
				section.classList.toggle('active')
		});
		if (page == 0) {
			ev.target.disabled = true
		}

		ev.stopPropagation()
		ev.preventDefault()
	}
}
