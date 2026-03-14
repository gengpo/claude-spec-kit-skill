---
name: claude-spec-kit
description: Use Claude Code with Spec-Kit CLI for spec-driven development. Trigger when user wants to develop software using Spec-Kit methodology with Claude Code as the AI engine. Covers initialization, constitution writing, specification, planning, task generation, and implementation phases.
---

# Claude Code + Spec-Kit Workflow

Complete workflow for spec-driven development using Spec-Kit CLI with Claude Code as the AI implementation engine.

## Quick Start

```bash
# 1. Initialize project with Spec-Kit
specify init --here --ai claude

# 2. Create constitution (principles)
/speckit.constitution

# 3. Create specification
/speckit.specify

# 4. Create implementation plan
/speckit.plan

# 5. Generate tasks
/speckit.tasks

# 6. Execute implementation
/speckit.implement
```

## Prerequisites

- Node.js and npm
- Spec-Kit CLI: `npm install -g @spec-kit/cli`
- OpenRouter API key for Claude Code access
- Git for version control

## Workflow Overview

### Phase 0: Environment Setup

**Configure Spec-Kit for Claude Code:**

```bash
# Set AI provider
specify config set ai.provider claude
specify config set ai.apiKey $OPENROUTER_API_KEY
specify config set ai.baseUrl https://openrouter.ai/api/v1
```

**Environment variables:**
```bash
export HTTPS_PROXY=http://your-proxy:port  # If behind firewall
export OPENROUTER_API_KEY=sk-or-v1-...
```

### Phase 1: Project Initialization

```bash
cd your-project-directory
specify init --here --ai claude
```

This creates:
- `.specify/` - Spec-Kit configuration and scripts
- `.claude/commands/` - Claude slash commands for each phase

### Phase 2: Constitution (Foundation)

Read `.claude/commands/speckit.constitution.md` and follow instructions.

**Key outputs:**
- `specs/XXX-phase-name/constitution.md` - Project principles and constraints

**Tips:**
- Define non-negotiable constraints early
- Include tech stack decisions
- Document performance requirements

### Phase 3: Specification

Read `.claude/commands/speckit.specify.md` and follow instructions.

**Key outputs:**
- `specs/XXX-phase-name/spec.md` - Detailed feature specification

**Tips:**
- Be specific about acceptance criteria
- Include visual/UX requirements
- Define edge cases

### Phase 4: Planning

Read `.claude/commands/speckit.plan.md` and follow instructions.

**Key outputs:**
- `specs/XXX-phase-name/plan.md` - Implementation roadmap

**Tips:**
- Break into small, testable chunks
- Identify dependencies between tasks
- Estimate complexity

### Phase 5: Task Generation

Read `.claude/commands/speckit.tasks.md` and follow instructions.

**Key outputs:**
- `specs/XXX-phase-name/tasks.md` - Detailed task list with acceptance criteria

**Tips:**
- Each task should be implementable in 30-60 minutes
- Include file paths and expected changes
- Define clear success criteria

### Phase 6: Implementation

Read `.claude/commands/speckit.implement.md` and follow instructions.

**Process:**
1. Create feature branch: `git checkout -b XXX-phase-name`
2. Implement tasks one by one
3. Test after each task
4. Commit: `git add . && git commit -m "Phase X: description"`

## Advanced Topics

### Multi-Phase Development

For large projects, create sequential phases:

```
specs/
├── 001-foundation/
├── 002-core-features/
├── 003-ui-design/
├── 004-animations/
└── 005-performance/
```

Each phase has its own constitution, spec, plan, and tasks.

### Working with Claude Code

**API Configuration:**
```json
{
  "ai": {
    "provider": "claude",
    "model": "claude-3-5-sonnet-20241022",
    "apiKey": "${OPENROUTER_API_KEY}",
    "baseUrl": "https://openrouter.ai/api/v1"
  }
}
```

**Proxy Settings:**
If behind a firewall, set proxy via environment variables, NOT in config file.

### Scripts and Utilities

See `scripts/` directory for helper scripts:
- `validate-specs.sh` - Validate spec file structure
- `generate-report.sh` - Generate implementation report

### Reference Materials

See `references/` directory for detailed guides:
- `workflow-examples.md` - Real project examples
- `troubleshooting.md` - Common issues and solutions
- `best-practices.md` - Tips for effective spec-driven development

## Best Practices

1. **Always commit after each phase** - Keep history clean
2. **Test during implementation** - Don't wait until the end
3. **Update constitution as needed** - Project constraints evolve
4. **Keep tasks small** - Easier to implement and review
5. **Document decisions** - Why > What in commit messages

## Example: Complete Project Flow

See `references/workflow-examples.md` for a complete walkthrough of the TaskBound project (skeuomorphic todo app).
