import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["button"];

	toggle = (ev) => {
		this.buttonTarget.classList.toggle("active");
		this.data.set("open", !(this.data.get("open") === "true"));
		if (this.data.get("open") === "true")
			this.element.addEventListener("mouseleave", this.toggle);
		else this.element.removeEventListener("mouseleave", this.toggle);
	};
}
