#!/bin/bash
# init-phase.sh - Initialize a new development phase

set -e

PHASE_NUMBER="$1"
PHASE_NAME="$2"

if [ -z "$PHASE_NUMBER" ] || [ -z "$PHASE_NAME" ]; then
    echo "Usage: init-phase.sh <number> <name>"
    echo "Example: init-phase.sh 004 animations"
    exit 1
fi

DIR="specs/${PHASE_NUMBER}-${PHASE_NAME}"

if [ -d "$DIR" ]; then
    echo "❌ Directory $DIR already exists"
    exit 1
fi

mkdir -p "$DIR"

# Create constitution.md
cat > "$DIR/constitution.md" << 'EOF'
# Constitution - Phase ${PHASE_NUMBER}

## Principles
- Principle 1
- Principle 2

## Constraints
- Constraint 1
- Constraint 2

## Definition of Done
- [ ] All tasks completed
- [ ] Code reviewed
- [ ] Tests passing
EOF

# Create spec.md
cat > "$DIR/spec.md" << 'EOF'
# Specification - Phase ${PHASE_NUMBER}

## Overview
Brief description of this phase.

## Features

### Feature 1
**Given** context
**When** action
**Then** result

## Technical Requirements
- Requirement 1
- Requirement 2

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
EOF

# Create plan.md
cat > "$DIR/plan.md" << 'EOF'
# Implementation Plan - Phase ${PHASE_NUMBER}

## Approach
High-level approach description.

## Milestones
1. Milestone 1
2. Milestone 2
3. Milestone 3

## Dependencies
- Dependency 1
- Dependency 2

## Risk Mitigation
- Risk 1: Mitigation strategy
EOF

# Create tasks.md
cat > "$DIR/tasks.md" << 'EOF'
# Tasks - Phase ${PHASE_NUMBER}

## Task 1: Task Name
- [ ] Subtask 1
- [ ] Subtask 2
- [ ] Subtask 3

**Files:** `js/file.js`, `css/file.css`

**Acceptance Criteria:**
- Criterion 1
- Criterion 2

---

## Task 2: Task Name
- [ ] Subtask 1
- [ ] Subtask 2

**Files:** `js/file.js`

**Acceptance Criteria:**
- Criterion 1
EOF

echo "✅ Created phase: $DIR"
echo ""
echo "Next steps:"
echo "1. Edit $DIR/constitution.md"
echo "2. Run: /speckit.constitution"
