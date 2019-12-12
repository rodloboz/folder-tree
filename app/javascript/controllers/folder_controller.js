import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['tree', 'icon']

  toggle() {
    this.icon.classList.toggle('fa-folder');
    this.icon.classList.toggle('fa-folder-open');

    if (this.tree) {
      this.tree.classList.toggle('closed');
      this.tree.classList.toggle('open');
    }
  }

  get tree() {
    if (this.hasTreeTarget) {
      return this.treeTarget;
    } else {
      return null;
    }
  }

  get icon() {
    if (this.hasIconTarget) {
      return this.iconTarget;
    } else {
      return null;
    }
  }
}
