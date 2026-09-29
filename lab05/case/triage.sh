#!/bin/bash

CASE_DIR="case"
REPORT="triage-report-auto.txt"

read -p "Enter your analyst name: " ANALYST
read -p "Enter the case reference: " CASE_REF

{
    echo "===================================="
    echo " AUTOMATED INCIDENT TRIAGE REPORT"
    echo "===================================="
    echo " Analyst   : $ANALYST"
    echo " Case Ref  : $CASE_REF"
    echo " Date      : $(date)"
    echo ""
    
    echo "Total Files:"
    find "$CASE_DIR" -type f | wc -l
    
    echo "Total Directories:"
    find "$CASE_DIR" -type d | wc -l
    
    PYTHON_FILES=$(find "$CASE_DIR" -name "*.py" | wc -l)
    SHELL_SCRIPTS=$(find "$CASE_DIR" -name "*.sh" | wc -l)
    LOG_FILES=$(find "$CASE_DIR" -name "*.log" -o -path "*/logs/*" | wc -l)
    CONFIG_FILES=$(find "$CASE_DIR" -name "*.txt" -o -name "*.conf" | wc -l)
    
    echo "Python Files:"
    echo "$PYTHON_FILES"
    
    echo "Shell Scripts:"
    echo "$SHELL_SCRIPTS"
    
    echo "Log Files:"
    echo "$LOG_FILES"
    
    echo "Configuration Files:"
    echo "$CONFIG_FILES"
    
    echo "Empty Files:"
    find "$CASE_DIR" -type f -empty | wc -l
    
    echo "Archives:"
    find "$CASE_DIR" -name "*.tar" -o -name "*.gz" -o -name "*.zip" | wc -l
    
    echo ""
    echo "Files containing 'admin':"
    grep -rl "admin" "$CASE_DIR" 2>/dev/null
    
    echo ""
    echo "Detected file types in evidence folder:"
    file "$CASE_DIR"/evidence/*
    
    TOTAL_SCRIPTS=$((PYTHON_FILES + SHELL_SCRIPTS))
    echo ""
    echo "Scripts (Python + shell): $TOTAL_SCRIPTS"
} > "$REPORT"

echo "Triage complete. Report saved to $REPORT."
