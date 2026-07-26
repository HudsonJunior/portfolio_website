# SPA hosting for deep links

This site uses path-based URLs (`/blog`, `/blog/my-slug`). The host must serve `index.html` for unknown paths so Flutter can handle routing client-side.

## Firebase Hosting

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

## Netlify (`public/_redirects` or `build/web/_redirects`)

```
/*    /index.html   200
```

## GitHub Pages / nginx

Configure a fallback rewrite so all non-file requests return `index.html` with status 200.
