<?php

declare(strict_types=1);

namespace Drupal\webseo\Hook;

use Drupal\Core\Controller\TitleResolverInterface;
use Drupal\Core\Hook\Attribute\Hook;
use Drupal\Core\Routing\RouteObjectInterface;
use Symfony\Component\DependencyInjection\Attribute\Autowire;
use Symfony\Component\HttpFoundation\RequestStack;

/**
 * Meta tag hook implementations for Web SEO.
 */
final class MetatagHooks {

  public function __construct(
    protected RequestStack $requestStack,
    #[Autowire(service: 'title_resolver')]
    protected TitleResolverInterface $titleResolver,
  ) {}

  /**
   * Implements hook_metatags_alter().
   *
   * Pages whose route has no title, like the log out confirmation page, give
   * an empty [current-page:title] token. Drop the token and its separator, so
   * the browser title does not start with "|".
   */
  #[Hook('metatags_alter')]
  public function metatagsAlter(array &$metatags, array &$context): void {
    $pattern = $metatags['title'] ?? '';
    if (!is_string($pattern) || !str_contains($pattern, '[current-page:title]')) {
      return;
    }
    $request = $this->requestStack->getCurrentRequest();
    $route = $request?->attributes->get(RouteObjectInterface::ROUTE_OBJECT);
    if (!$request || !$route) {
      return;
    }
    $title = $this->titleResolver->getTitle($request, $route);
    if (is_array($title)) {
      return;
    }
    $printable = is_scalar($title) || $title instanceof \Stringable;
    if ($printable && trim((string) $title) !== '') {
      return;
    }
    $separator = '\s*[|:\-–—]\s*';
    $pattern = preg_replace([
      '/\[current-page:title\]' . $separator . '/u',
      '/' . $separator . '\[current-page:title\]/u',
      '/\[current-page:title\]/u',
    ], '', $pattern);
    $metatags['title'] = trim($pattern) !== '' ? trim($pattern) : '[site:name]';
  }

}
