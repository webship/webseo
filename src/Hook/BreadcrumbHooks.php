<?php

declare(strict_types=1);

namespace Drupal\webseo\Hook;

use Drupal\Core\Cache\CacheableMetadata;
use Drupal\Core\Config\ConfigFactoryInterface;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Extension\ModuleHandlerInterface;
use Drupal\Core\Hook\Attribute\Hook;
use Drupal\Core\Routing\AdminContext;
use Drupal\Core\Routing\RouteMatchInterface;
use Symfony\Component\DependencyInjection\Attribute\Autowire;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Breadcrumb hook implementations for Web SEO.
 */
final class BreadcrumbHooks {

  /**
   * The key Easy Breadcrumb attaches its BreadcrumbList JSON-LD with.
   */
  private const JSON_LD_KEY = 'easy_breadcrumb_structured_data_json_ld';

  public function __construct(
    protected ModuleHandlerInterface $moduleHandler,
    protected EntityTypeManagerInterface $entityTypeManager,
    protected ConfigFactoryInterface $configFactory,
    protected AdminContext $adminContext,
    #[Autowire(service: 'current_route_match')]
    protected RouteMatchInterface $routeMatch,
    #[Autowire(service: 'service_container')]
    protected ContainerInterface $container,
  ) {}

  /**
   * Implements hook_page_attachments().
   *
   * Easy Breadcrumb adds the BreadcrumbList JSON-LD of the page when the
   * template of the breadcrumb block runs (its hook_preprocess_block()). A
   * Display Builder page layout renders the breadcrumb block plugin as a
   * source, without that template, so the pages it draws lost the JSON-LD.
   * When the page layout drawing the page holds the breadcrumb, attach it
   * here, with the key of Easy Breadcrumb: a page where the block template
   * runs as well still prints it once.
   */
  #[Hook('page_attachments')]
  public function pageAttachments(array &$attachments): void {
    if (!$this->moduleHandler->moduleExists('easy_breadcrumb') || !$this->moduleHandler->moduleExists('display_builder_page_layout')) {
      return;
    }
    $settings = $this->configFactory->get('easy_breadcrumb.settings');
    $cacheability = CacheableMetadata::createFromObject($settings);
    if ($settings->get('add_structured_data_json_ld') && !$this->adminContext->isAdminRoute()) {
      // The page layout Display Builder draws the page with: the first one
      // that applies, as its page variant picks it. Page layouts draw no
      // administration page.
      /** @var \Drupal\display_builder_page_layout\AccessControlHandler $access */
      $access = $this->entityTypeManager->getAccessControlHandler('page_layout');
      $page_layout = $access->loadCurrentPageLayout($cacheability);
      if ($page_layout) {
        $cacheability->addCacheableDependency($page_layout);
        if (self::holdsBreadcrumb($page_layout->getSources())) {
          // The breadcrumb the JSON-LD is made of, for the cache contexts of
          // the page.
          $breadcrumb = $this->container->get('easy_breadcrumb.breadcrumb')->build($this->routeMatch);
          $cacheability->addCacheableDependency($breadcrumb);
          $json_ld = $this->container->get('easy_breadcrumb.structured_data_json_ld')->value();
          if (\is_string($json_ld) && $json_ld !== '') {
            $attachments['#attached']['html_head'][] = [
              [
                '#tag' => 'script',
                '#attributes' => ['type' => 'application/ld+json'],
                '#value' => $json_ld,
              ],
              self::JSON_LD_KEY,
            ];
          }
        }
      }
    }
    $cacheability->applyTo($attachments);
  }

  /**
   * Tells whether page layout sources hold the breadcrumb block.
   *
   * @param array $sources
   *   The sources of a page layout, at any depth: components hold sources in
   *   their slots.
   *
   * @return bool
   *   TRUE when a block source renders the system breadcrumb block.
   */
  private static function holdsBreadcrumb(array $sources): bool {
    if (($sources['source_id'] ?? NULL) === 'block' && ($sources['source']['plugin_id'] ?? NULL) === 'system_breadcrumb_block') {
      return TRUE;
    }
    foreach ($sources as $value) {
      if (\is_array($value) && self::holdsBreadcrumb($value)) {
        return TRUE;
      }
    }
    return FALSE;
  }

}
