#!/bin/bash
# generate-report.sh - Generate implementation report

OUTPUT_FILE="IMPLEMENTATION_REPORT.md"
SPEC_DIR="${1:-specs}"

echo "# Implementation Report" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "Generated: $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Git information
echo "## Git Status" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
git log --oneline -10 >> "$OUTPUT_FILE" 2>/dev/null || echo "No git history" >> "$OUTPUT_FILE"
echo "\`\`\`" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Phase summary
echo "## Phases" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for phase_dir in "$SPEC_DIR"/*/; do
    if [ -d "$phase_dir" ]; then
        phase_name=$(basename "$phase_dir")
        echo "### $phase_name" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        
        # Count tasks
        if [ -f "$phase_dir/tasks.md" ]; then
            total_tasks=$(grep -c "^- \[\|^- \[x\]" "$phase_dir/tasks.md" 2>/dev/null || echo "0")
            completed_tasks=$(grep -c "^- \[x\]" "$phase_dir/tasks.md" 2>/dev/null || echo "0")
            echo "- Tasks: $completed_tasks / $total_tasks completed" >> "$OUTPUT_FILE"
        fi
        
        # Show spec summary
        if [ -f "$phase_dir/spec.md" ]; then
            summary=$(grep -A 5 "^## Overview" "$phase_dir/spec.md" | tail -n +2 | head -n 3)
            if [ -n "$summary" ]; then
                echo "- Summary: $summary" >> "$OUTPUT_FILE"
            fi
        fi
        
        echo "" >> "$OUTPUT_FILE"
    fi
done

# File statistics
echo "## Code Statistics" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

if [ -d "js" ]; then
    js_lines=$(find js -name "*.js" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')
    echo "- JavaScript: $js_lines lines" >> "$OUTPUT_FILE"
fi

if [ -d "css" ]; then
    css_lines=$(find css -name "*.css" -exec wc -l {} + 2>/dev/null | tail -1 | awk '{print $1}')
    echo "- CSS: $css_lines lines" >> "$OUTPUT_FILE"
fi

if [ -f "index.html" ]; then
    html_lines=$(wc -l < index.html)
    echo "- HTML: $html_lines lines" >> "$OUTPUT_FILE"
fi

echo "" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "Report saved to $OUTPUT_FILE"
