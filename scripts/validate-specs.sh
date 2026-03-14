#!/bin/bash
# validate-specs.sh - Validate Spec-Kit specification structure

set -e

SPEC_DIR="${1:-specs}"
ERRORS=0

echo "🔍 Validating Spec-Kit specifications in $SPEC_DIR..."
echo ""

# Check if specs directory exists
if [ ! -d "$SPEC_DIR" ]; then
    echo "❌ Error: $SPEC_DIR directory not found"
    exit 1
fi

# Find all phase directories
for phase_dir in "$SPEC_DIR"/*/; do
    if [ -d "$phase_dir" ]; then
        phase_name=$(basename "$phase_dir")
        echo "Checking $phase_name..."
        
        # Check required files
        for file in constitution.md spec.md plan.md tasks.md; do
            if [ -f "$phase_dir/$file" ]; then
                echo "  ✅ $file"
            else
                echo "  ❌ Missing: $file"
                ((ERRORS++))
            fi
        done
        
        # Validate markdown headers
        if [ -f "$phase_dir/constitution.md" ]; then
            if ! grep -q "^# " "$phase_dir/constitution.md"; then
                echo "  ⚠️  constitution.md: No H1 header found"
            fi
        fi
        
        echo ""
    fi
done

if [ $ERRORS -eq 0 ]; then
    echo "✅ All specifications valid!"
    exit 0
else
    echo "❌ Found $ERRORS error(s)"
    exit 1
fi
