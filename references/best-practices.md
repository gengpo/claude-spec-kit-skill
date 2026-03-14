# Best Practices

Effective patterns for spec-driven development with Claude Code.

## Project Structure

### Recommended Layout

```
my-project/
├── specs/                    # Spec-Kit specifications
│   ├── 001-foundation/
│   │   ├── constitution.md
│   │   ├── spec.md
│   │   ├── plan.md
│   │   └── tasks.md
│   ├── 002-core-features/
│   └── 003-ui-polish/
├── src/ or js/              # Source code
├── css/                     # Stylesheets
├── assets/                  # Images, fonts, etc.
├── .specify/               # Spec-Kit configuration
├── .claude/commands/       # Claude slash commands
└── README.md
```

### Git Branching Strategy

```bash
# Main branch for stable code
git checkout main

# Feature branch per phase
git checkout -b 004-animations

# Commit after each phase complete
git add .
git commit -m "Phase 4: Animation system"

# Merge to main when stable
git checkout main
git merge 004-animations
```

## Writing Effective Specifications

### Constitution (Phase Foundation)

**Good:**
```markdown
## Constraints
- Vanilla JavaScript only, no frameworks
- Must support IE11 (ES5 transpile if needed)
- All animations must respect prefers-reduced-motion
```

**Bad:**
```markdown
## Constraints
- Use modern tech
- Make it fast
- Consider accessibility
```

### Specification (What to Build)

Use Given-When-Then format:
```markdown
## Feature: Task Completion

### Scenario: Mark task complete
**Given** a task exists in the list
**When** user clicks the complete button
**Then** the task shows strikethrough
**And** a completion sound plays
**And** the task moves to completed section
```

### Tasks (How to Build)

Break into small, verifiable chunks:

**Good task:**
```markdown
- [ ] Create TaskManager.addTask() method
  - Accepts title and priority
  - Returns task object with id
  - Saves to localStorage
  - File: js/TaskManager.js
```

**Bad task:**
```markdown
- [ ] Implement task system
```

## Working with Claude Code

### Effective Prompts

**Context setting:**
```
We're building a [type] application using [tech stack].
Current phase: [phase name]
See specs/XXX-phase-name/ for requirements.
```

**Specific requests:**
```
Implement the Animation.slideIn() method according to 
specs/004-animations/spec.md section 3.2.

Requirements:
- Duration: 300ms
- Easing: cubic-bezier(0.4, 0, 0.2, 1)
- Support reduced motion preference
```

**Code review:**
```
Review this implementation against the spec:
[paste code]

Check:
1. Follows constitution constraints
2. Meets acceptance criteria
3. Has proper error handling
```

### Iteration Patterns

**Incremental refinement:**
```
1. Generate initial implementation
2. Test manually
3. Identify issues
4. Request specific fixes
5. Verify and commit
```

**Example:**
```
User: "Generate the animation controller"
[Claude generates code]
User: "Add reduced-motion support"
[Claude updates code]
User: "Use CSS custom properties for timing"
[Claude refactors]
```

## Code Quality

### Modular Architecture

```javascript
// Good: Single responsibility
// Storage.js - Only handles persistence
export default class Storage {
  static save(key, data) { ... }
  static load(key) { ... }
}

// TaskManager.js - Only handles task logic
export default class TaskManager {
  addTask(title) { ... }
  completeTask(id) { ... }
}

// Animation.js - Only handles animations
export default class Animation {
  static slideIn(el) { ... }
}
```

### Defensive Programming

```javascript
// Check browser support
if (!('animate' in HTMLElement.prototype)) {
  console.warn('Web Animations API not supported');
  // Provide CSS fallback
}

// Validate inputs
function addTask(title, priority = 3) {
  if (!title || typeof title !== 'string') {
    throw new Error('Title must be a non-empty string');
  }
  if (priority < 1 || priority > 3) {
    throw new Error('Priority must be 1-3');
  }
  // ...
}

// Feature detection
const supportsPassive = (() => {
  let passive = false;
  try {
    window.addEventListener('test', null, 
      Object.defineProperty({}, 'passive', {
        get() { passive = true; }
      })
    );
  } catch (e) {}
  return passive;
})();
```

## Performance Optimization

### CSS Performance

```css
/* Good: Promote to compositor layer */
.animated {
  will-change: transform, opacity;
  transform: translateZ(0);
}

/* Good: Contain paint */
.card {
  contain: layout style paint;
}

/* Good: Content visibility for off-screen */
.list-item {
  content-visibility: auto;
  contain-intrinsic-size: auto 100px;
}

/* Bad: Triggers layout */
.animated {
  width: 100px;  /* Avoid animating width */
  left: 100px;   /* Avoid animating position */
}
```

### JavaScript Performance

```javascript
// Good: Debounce expensive operations
const debouncedSearch = debounce((query) => {
  performSearch(query);
}, 300);

// Good: RAF for visual updates
function updateProgress(percent) {
  requestAnimationFrame(() => {
    progressBar.style.transform = `scaleX(${percent / 100})`;
  });
}

// Good: Lazy load non-critical content
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      loadContent(entry.target);
    }
  });
});
```

## Accessibility

### Essential Checks

- [ ] All interactive elements keyboard accessible
- [ ] Focus indicators visible
- [ ] Screen reader announcements for dynamic content
- [ ] Color contrast meets WCAG AA (4.5:1)
- [ ] Reduced motion preferences respected
- [ ] Touch targets minimum 44x44px

### Implementation Pattern

```javascript
class AccessibleComponent {
  constructor(element) {
    this.element = element;
    this.setupKeyboardNav();
    this.setupScreenReader();
  }
  
  setupKeyboardNav() {
    this.element.addEventListener('keydown', (e) => {
      switch (e.key) {
        case 'Enter':
        case ' ':
          this.activate();
          break;
        case 'Escape':
          this.close();
          break;
      }
    });
  }
  
  announce(message) {
    const liveRegion = document.getElementById('live-region');
    liveRegion.textContent = message;
  }
}
```

## Testing Strategy

### Manual Testing Checklist

**Functionality:**
- [ ] All user stories work as specified
- [ ] Edge cases handled (empty input, max length, etc.)
- [ ] Error states display correctly

**Cross-browser:**
- [ ] Chrome/Edge (Chromium)
- [ ] Firefox
- [ ] Safari (if targeting Mac/iOS)

**Responsive:**
- [ ] Mobile (320px+)
- [ ] Tablet (768px+)
- [ ] Desktop (1024px+)

**Accessibility:**
- [ ] Keyboard-only navigation
- [ ] Screen reader tested
- [ ] High contrast mode

### Automated Testing

```javascript
// Unit test example
import { describe, it, expect } from 'vitest';
import TaskManager from './TaskManager.js';

describe('TaskManager', () => {
  it('adds task with correct properties', () => {
    const tm = new TaskManager();
    const task = tm.addTask('Test', 1);
    
    expect(task.title).toBe('Test');
    expect(task.priority).toBe(1);
    expect(task.completed).toBe(false);
    expect(task.id).toBeDefined();
  });
});
```

## Documentation

### Code Comments

```javascript
/**
 * Animates element sliding in from specified direction
 * @param {HTMLElement} element - Element to animate
 * @param {number} delay - Delay in milliseconds
 * @param {string} direction - 'up' | 'down' | 'left' | 'right'
 * @returns {Animation} Web Animation instance
 * @throws {Error} If element is not a valid HTMLElement
 * 
 * @example
 * Animation.slideIn(taskEl, 100, 'right');
 */
static slideIn(element, delay = 0, direction = 'up') {
  // Implementation
}
```

### README Structure

```markdown
# Project Name

> One-line description

![Screenshot](screenshot.png)

## Features
- Feature 1
- Feature 2

## Quick Start
```bash
npm install
npm start
```

## Documentation
- [API Reference](./docs/api.md)
- [Contributing](./CONTRIBUTING.md)

## License
MIT
```

## Common Pitfalls

### Don't

1. **Skip the constitution** - Leads to tech debt
2. **Write vague tasks** - Hard to implement and verify
3. **Batch all testing** - Find issues late
4. **Ignore accessibility** - Hard to retrofit
5. **Commit directly to main** - Lose rollback ability

### Do

1. **Start with constraints** - Prevents wrong turns
2. **Make tasks concrete** - Clear acceptance criteria
3. **Test as you go** - Catch issues early
4. **Build in a11y from start** - Easier than retrofit
5. **Use feature branches** - Safe experimentation
