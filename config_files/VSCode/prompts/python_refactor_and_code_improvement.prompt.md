---
mode: agent
---

# Task: Improve the provided code. Fix any bugs that you find in the code. Improve interfaces for better clarity. Refactor the code to make it more understandable and for better readability.

## Do:
- **Fix bugs**: Look for and fix any bugs, logic errors, or edge cases
- **Improve readability**: Refactor for clarity and maintainability
- **Make code concise**: Simplify where possible without sacrificing clarity. **Removing code is better than adding code**: Solve the task as clear, concise and efficient as possible.
- **Optimize efficiency**: Improve performance where applicable (but prefer readability over micro-optimizations)
- **Enhance interfaces**: Make APIs more intuitive and consistent
- **Add/improve type hints**: Use PEP 484 type annotations throughout
- **Improve error handling**: Add proper exception handling and validation. But if a true error state is encountered, it is better to throw early. Don't make the code overprepared to catch all errors, only handle errors if this is in fact a recoverable state.  
- **Enhance documentation**: Write clear docstrings (PEP257 and Google style)
- **Follow style guides**: Adhere to PEP 8 > PEP 257 > PEP 484 > Google Python Style Guide
- **Use descriptive names**: Ensure variables, functions, and classes have clear, meaningful names
- **Remove dead code**: Delete unused imports, variables, or functions

## Don't:
- **Change core functionality**: Preserve the fundamental behavior and purpose of the code
- **Over-engineer**: Avoid overly complex or intricate solutions. "KISS - Keep it simple, stupid!"
- **Add unnecessary dependencies**: Don't introduce new libraries unless they significantly improve the code
- **Make breaking changes without noting them**: If you must break compatibility, clearly document why. Don't break public APIs unnecessarily. 
- **Ignore context**: Consider how the code fits into the larger system

## Output Format:
1. **Summary**: Brief overview of changes made
2. **Breaking changes**: Any modifications that affect existing usage (if applicable)
3. **Recommendations**: Suggestions for further improvements (if any)

## Priority:
1. Bug fixes (highest)
2. Code readability, structure and conciseness
3. Type hints and documentation
4. Error handling and edge cases
5. Performance optimizations (lowest, unless critical)