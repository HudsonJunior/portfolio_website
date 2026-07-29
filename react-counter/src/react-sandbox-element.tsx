import { createRoot, type Root } from 'react-dom/client';

import { Counter } from './components/Counter';
import React from 'react';

class ReactSandboxElement extends HTMLElement {
  private reactRoot?: Root;

  static get observedAttributes(): string[] {
    return ['initial-value'];
  }

  connectedCallback(): void {
    if (this.reactRoot) {
      return;
    }

    const shadowRoot =
      this.shadowRoot ?? this.attachShadow({ mode: 'open' });
    const mountPoint = document.createElement('div');
    const styles = document.createElement('style');

    styles.textContent = `
      :host {
        display: block;
        width: 100%;
        height: 100%;
      }

      #react-root {
        width: 100%;
        height: 100%;
      }
    `;
    mountPoint.id = 'react-root';

    shadowRoot.replaceChildren(styles, mountPoint);
    this.reactRoot = createRoot(mountPoint);
    this.renderReactComponent();
  }

  attributeChangedCallback(): void {
    if (this.reactRoot) {
      this.renderReactComponent();
    }
  }

  disconnectedCallback(): void {
    this.reactRoot?.unmount();
    this.reactRoot = undefined;
  }

  private renderReactComponent(): void {
    const parsedValue = Number.parseInt(
      this.getAttribute('initial-value') ?? '',
      10,
    );
    const initialValue = Number.isNaN(parsedValue) ? 0 : parsedValue;

    this.reactRoot?.render(
      <Counter
        key={initialValue}
        initialValue={initialValue}
        onChange={(value) => {
          this.dispatchEvent(
            new CustomEvent('counter-change', {
              bubbles: true,
              composed: true,
              detail: { value },
            }),
          );
        }}
      />,
    );
  }
}

if (!customElements.get('react-sandbox')) {
  customElements.define(
    'react-sandbox',
    ReactSandboxElement,
  );
}
