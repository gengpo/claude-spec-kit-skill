# Troubleshooting

Common issues when using Claude Code with Spec-Kit.

## Connection Issues

### OpenRouter 403 Error

**Symptom:**
```
Error: 403 Forbidden
{"error":{"message":"Country blocked"}}
```

**Solution:**
Set proxy via environment variables:
```bash
export HTTPS_PROXY=http://192.168.0.3:7890
export HTTP_PROXY=http://192.168.0.3:7890
```

**Do NOT** add proxy to `openclaw.json` - it breaks Gateway startup.

### Git Push TLS Error

**Symptom:**
```
fatal: GnuTLS recv error (-110): The TLS connection was non-properly terminated
```

**Solutions:**

1. **Try without proxy:**
```bash
unset HTTPS_PROXY HTTP_PROXY
git push origin main
```

2. **Use SSH instead:**
```bash
git remote set-url origin git@github.com:user/repo.git
git push
```

3. **Increase buffer size:**
```bash
git config http.postBuffer 524288000
```

## Spec-Kit Issues

### Command Not Found

**Symptom:**
```
specify: command not found
```

**Solution:**
```bash
# Install via npm
npm install -g @spec-kit/cli

# Or use npx
npx @spec-kit/cli init --here --ai claude
```

### Feature Directory Not Recognized

**Symptom:**
```
Error: Feature directory not found
```

**Solution:**
Ensure directory structure:
```
specs/
└── XXX-phase-name/
    ├── constitution.md
    ├── spec.md
    ├── plan.md
    └── tasks.md
```

Run check script:
```bash
bash .specify/scripts/bash/check-prerequisites.sh
```

## Claude Code Issues

### Model Fallback

**Symptom:**
Model falls back to alternative in usage stats.

**Causes:**
- API rate limiting
- maxTokens too high
- Region restrictions

**Solution:**
```bash
# Check current config
openclaw config get models

# Reduce maxTokens
openclaw config set models.openrouter.maxTokens 4096

# Check proxy
openclaw gateway status
```

### JSON Parse Error

**Symptom:**
```
SyntaxError: Unexpected token in JSON
```

**Solution:**
Always validate after editing:
```bash
python3 -c "import json; json.load(open('openclaw.json'))" && echo "Valid JSON"
```

Common errors:
- Trailing commas
- Missing closing brackets
- Comments in JSON (not allowed)

## Performance Issues

### Slow Animations

**Symptom:**
Animations stutter or lag.

**Solutions:**

1. **Add will-change:**
```css
.animated-element {
  will-change: transform, opacity;
}
```

2. **Use transform instead of position:**
```css
/* Bad */
left: 100px;

/* Good */
transform: translateX(100px);
```

3. **Debounce event handlers:**
```javascript
const debouncedHandler = debounce(handler, 100);
element.addEventListener('scroll', debouncedHandler, { passive: true });
```

### Large Bundle Size

**Symptom:**
App loads slowly.

**Solutions:**

1. **Code splitting:**
```javascript
// Dynamic imports
const heavyModule = await import('./heavy-module.js');
```

2. **Lazy loading:**
```javascript
const lazyLoader = createLazyLoader();
lazyLoader.observe(element, callback);
```

3. **Tree shaking:**
Use ES6 modules and avoid importing entire libraries.

## Git Issues

### Merge Conflicts

**Symptom:**
```
CONFLICT (content): Merge conflict in file.js
```

**Solution:**
```bash
# See conflicts
git status

# Resolve manually, then
git add .
git commit -m "Resolve merge conflicts"

# Or abort
git merge --abort
```

### Detached HEAD

**Symptom:**
```
You are in 'detached HEAD' state
```

**Solution:**
```bash
# Create branch from current state
git checkout -b recovery-branch

# Or go back to main
git checkout main
```

## Browser Issues

### CORS Errors

**Symptom:**
```
Access to fetch at '...' has been blocked by CORS policy
```

**Solutions:**

1. **Use local server:**
```bash
python3 -m http.server 8080
```

2. **Add CORS headers (dev only):**
```javascript
// In your server
response.setHeader('Access-Control-Allow-Origin', '*');
```

### localStorage Not Working

**Symptom:**
Data not persisted between sessions.

**Causes:**
- Private browsing mode
- Storage quota exceeded
- Cookies disabled

**Solution:**
```javascript
// Check availability
function isLocalStorageAvailable() {
  try {
    const test = '__storage_test__';
    localStorage.setItem(test, test);
    localStorage.removeItem(test);
    return true;
  } catch (e) {
    return false;
  }
}
```

## Best Practices Checklist

Before asking for help, verify:

- [ ] Proxy set via environment variables (not config file)
- [ ] JSON config validated
- [ ] Feature directory structure correct
- [ ] Git branch created for phase
- [ ] Changes committed before switching branches
- [ ] Browser console shows no errors
- [ ] Local server running (not file://)

## Getting Help

If issue persists:

1. **Check logs:**
```bash
openclaw logs
```

2. **Verify environment:**
```bash
openclaw status
```

3. **Create minimal reproduction:**
Strip down to smallest code that shows the issue.

4. **Check documentation:**
- OpenClaw docs: `~/.npm-global/lib/node_modules/openclaw/docs`
- Spec-Kit docs: `specify --help`
