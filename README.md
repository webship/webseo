# Web SEO

Most needed contributed modules and configurations for search engine optimization.

## Default recipe

`recipes/default` sets up:

- Meta tags, Schema.org metatags, XML sitemap, Yoast SEO, Google Analytics and
  Google Tag.
- The description meta tag of a node is its `field_summary`, the summary field
  of the Webship content types.
- Breadcrumbs (Easy Breadcrumb) with Schema.org `BreadcrumbList` markup.
- URL aliases with Pathauto and the "Menu Path" pattern.
- Redirects, the redirects admin view and redirect 404 handling. Content
  editors can administer redirects.
- Page caching for 15 minutes and aggregated CSS and JavaScript.
