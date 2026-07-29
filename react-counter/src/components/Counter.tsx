import React from 'react';
import { useState } from 'react';

type CounterProps = {
  initialValue?: number;
  onChange?: (value: number) => void;
};

export function Counter({
  initialValue = 0,
  onChange,
}: CounterProps) {
  const [count, setCount] = useState(initialValue);

  function increment(): void {
    const nextValue = count + 1;

    setCount(nextValue);
    onChange?.(nextValue);
  }

  function decrement(): void {
    const nextValue = count - 1;

    setCount(nextValue);
    onChange?.(nextValue);
  }

  return (
    <div style={styles.container}>
      <h2 style={styles.title}>
        React Counter
      </h2>

      <p style={styles.description}>
        This React component is embedded inside Flutter Web.
      </p>

      <div style={styles.count}>
        {count}
      </div>

      <div style={styles.actions}>
        <button
          type="button"
          style={styles.button}
          onClick={decrement}
        >
          −
        </button>

        <button
          type="button"
          style={styles.button}
          onClick={increment}
        >
          +
        </button>
      </div>
    </div>
  );
}

const styles: Record<string, React.CSSProperties> = {
  container: {
    width: '100%',
    height: '100%',
    boxSizing: 'border-box',
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    gap: '16px',
    padding: '24px',
    fontFamily: 'Arial, sans-serif',
    background: '#f8fafc',
    borderRadius: '12px',
  },

  title: {
    margin: 0,
    fontSize: '24px',
  },

  description: {
    margin: 0,
    textAlign: 'center',
    color: '#475569',
  },

  count: {
    fontSize: '48px',
    fontWeight: 700,
  },

  actions: {
    display: 'flex',
    gap: '12px',
  },

  button: {
    width: '52px',
    height: '42px',
    border: 'none',
    borderRadius: '8px',
    fontSize: '24px',
    cursor: 'pointer',
    background: '#2563eb',
    color: '#ffffff',
  },
};
