# Workflow Examples

Complete example of using Claude Code + Spec-Kit for the TaskBound project.

## Project: TaskBound (Skeuomorphic Todo App)

### Overview
A premium leather-bound journal todo application with rich animations and full accessibility support.

**Tech Stack:**
- HTML5 + CSS3 + Vanilla JavaScript
- Web Animations API
- LocalStorage for persistence
- Spec-Kit for development workflow

### Phase 1: Foundation (001-foundation)

**Constitution Highlights:**
```markdown
# Constitution

## Principles
- Vanilla JS only, no frameworks
- Mobile-first responsive design
- Semantic HTML structure

## Constraints
- Must work without build step
- ES6+ modules
- Max 60fps animations
```

**Spec Highlights:**
```markdown
# Specification

## Features
- Add/edit/delete tasks
- Mark tasks complete
- Filter by status (all/active/completed)
- Priority levels (normal/important/urgent)

## UI Requirements
- Clean, minimal interface
- Touch-friendly (44px min tap targets)
- Works offline
```

**Key Files Created:**
- `index.html` - Semantic structure
- `css/reset.css` - CSS reset
- `js/TaskManager.js` - Core logic
- `js/Storage.js` - LocalStorage wrapper

### Phase 2: Core Features (002-core-features)

**Implementation:**
```javascript
// TaskManager.js
class TaskManager {
  constructor() {
    this.tasks = Storage.load('tasks') || [];
  }
  
  addTask(title, priority = 3) {
    const task = {
      id: Date.now(),
      title,
      priority,
      completed: false,
      createdAt: new Date()
    };
    this.tasks.push(task);
    this.save();
    return task;
  }
  
  // ... toggleComplete, removeTask, etc.
}
```

**Testing:**
```bash
python3 -m http.server 8080
# Manual testing in browser
```

### Phase 3: UI Design (003-ui-design)

**Spec Highlights:**
```markdown
# UI Design Specification

## Visual Theme
- Leather-bound journal (dark brown #3d2817)
- Cream paper (#f5f5dc)
- Red wax seals for priority
- Brass/gold accents

## CSS Architecture
- Modular CSS files per component
- CSS custom properties for theming
- No CSS frameworks
```

**Files Created:**
```
css/
├── leather.css    # Journal cover textures
├── paper.css      # Lined paper background
├── seals.css      # Wax seal styling
├── bookmarks.css  # Bookmark ribbon tabs
└── buttons.css    # 3D pressable buttons
```

### Phase 4: Animations (004-animations)

**Spec Highlights:**
```markdown
# Animation Specification

## Required Animations
1. Page flip (bookmark tab switch)
2. Ink write (new task text)
3. Strikethrough (task complete)
4. Paper tear (task delete)
5. Wax seal stamp (priority marker)

## Technical Requirements
- Use Web Animations API
- Support prefers-reduced-motion
- 60fps performance target
```

**Implementation Pattern:**
```javascript
// Animation.js
export default class Animation {
  static slideIn(element, delay = 0, direction = 'up') {
    const keyframes = {
      up: [{ transform: 'translateY(20px)', opacity: 0 },
           { transform: 'translateY(0)', opacity: 1 }],
      // ... other directions
    };
    
    return element.animate(keyframes[direction], {
      duration: 300,
      delay,
      easing: 'cubic-bezier(0.4, 0, 0.2, 1)',
      fill: 'both'
    });
  }
  
  static inkWrite(element) {
    // Clip-path animation for text reveal
  }
  
  // ... other animation methods
}
```

**PageFlip Controller:**
```javascript
// PageFlip.js
export default class PageFlip {
  constructor(options) {
    this.tabs = document.querySelectorAll(options.tabsSelector);
    this.onTabChange = options.onTabChange;
    this.init();
  }
  
  init() {
    this.tabs.forEach((tab, index) => {
      tab.addEventListener('click', () => this.flipTo(index));
    });
  }
  
  async flipTo(index) {
    // Animate page flip
    await Animation.pageFlip(this.container);
    this.onTabChange(index, this.tabs[index].dataset.filter);
  }
}
```

### Phase 5: Performance & Accessibility (005-performance-accessibility)

**Performance Optimizations:**
```css
/* performance.css */
.task {
  will-change: transform, opacity;
  contain: content;
}

.task-list {
  content-visibility: auto;
  contain-intrinsic-size: auto 500px;
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

**Accessibility Features:**
```javascript
// a11y.js
export default class AccessibilityController {
  constructor() {
    this.setupKeyboardNavigation();
    this.setupLiveRegion();
  }
  
  announce(message, assertive = false) {
    const region = assertive ? 
      this.assertiveRegion : this.liveRegion;
    region.textContent = '';
    setTimeout(() => region.textContent = message, 100);
  }
  
  trapFocus(modal) {
    // Focus trap implementation
  }
}
```

### Integration Example

**main.js:**
```javascript
import TaskManager from './TaskManager.js';
import Animation from './Animation.js';
import PageFlip from './PageFlip.js';
import AccessibilityController from './a11y.js';
import * as Performance from './performance.js';

class App {
  constructor() {
    this.taskManager = new TaskManager();
    this.a11y = new AccessibilityController();
    this.pageFlip = new PageFlip({
      tabsSelector: '.bookmark-tab',
      onTabChange: (filter) => this.renderTasks(filter)
    });
  }
  
  addTask(title, priority) {
    const task = this.taskManager.addTask(title, priority);
    this.renderTasks();
    
    // Animate new task
    const taskEl = document.querySelector(`[data-id="${task.id}"]`);
    Animation.slideIn(taskEl);
    Animation.inkWrite(taskEl.querySelector('.task-title'));
    
    // Announce to screen readers
    this.a11y.announce(`Task ${title} added`);
  }
}
```

## Lessons Learned

1. **Small tasks work best** - 30-60 minute tasks maintain momentum
2. **Test during implementation** - Don't batch all testing to the end
3. **Document constraints early** - Constitution prevents scope creep
4. **Animation needs fallbacks** - Always support prefers-reduced-motion
5. **Commit per phase** - Clean git history helps debugging

## Final Stats

- **5 phases** over 3 days
- **9 CSS files** (3,800 lines)
- **7 JS modules** (2,200 lines)
- **1 HTML file** (semantic structure)
- **0 build steps** - Pure vanilla
- **100% offline capable**
- **Lighthouse scores:** 95+ Performance, 95+ Accessibility
