# Copilot Instructions for Artisan Webpage Project

## Project Overview
This is a Node.js Express application designed to serve static web content for an artisan webpage. The architecture centers around a simple Express server that handles static file serving and basic middleware setup.

## Architecture
- **Main Server**: `app.js` - Express application with middleware stack
- **Static Assets**: Served from `public/` directory using `express.static()`
- **Port**: Default 3000

## Key Patterns
- **Middleware Setup**: Always include `express.json()`, `express.urlencoded({extended: true})`, and `express.static()` in this order
- **Path Handling**: Use `path.join(__dirname, 'public')` for static file directory (note: double underscores in `__dirname`)
- **Server Start**: `app.listen(port, () => console.log(...))` pattern

## Common Issues & Fixes
- **Syntax Errors**: Watch for missing semicolons, incomplete parentheses, and typos like `_dirnamem` instead of `__dirname`
- **Static Serving**: Ensure `public/` directory exists and contains HTML, CSS, JS files

## Development Workflow
- **Run Server**: `node app.js`
- **Add Static Content**: Place HTML files in `public/` directory
- **Debug**: Check console for middleware loading and server start messages

## Dependencies
- `express`: Web framework
- `path`: Built-in Node.js module for path operations

## File Structure
```
app.js          # Main Express server
public/         # Static web assets (HTML, CSS, JS)
  index.html    # Main webpage
  s.css         # Stylesheet
```

## Code Style
- Use `const` for requires and app declaration
- Semicolons optional but recommended for consistency
- Single quotes for strings</content>
<parameter name="filePath">c:\Users\MAX GLOBAL TECH\Desktop\New folder (2)\.github\copilot-instructions.md