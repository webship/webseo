<?php

declare(strict_types=1);

namespace Drupal\webseo\Hook;

use Drupal\Core\Hook\Attribute\Hook;
use Drupal\Core\State\StateInterface;

/**
 * XML sitemap hook implementations for Web SEO.
 */
final class XmlSitemapHooks {

  /**
   * The path of the Drupal installer script.
   */
  private const INSTALLER_PATH = '/core/install.php';

  public function __construct(
    protected StateInterface $state,
  ) {}

  /**
   * Implements hook_cron().
   *
   * XML sitemap stores its base URL when it is installed. Installed from the
   * Drupal installer, that URL ends with /core/install.php, and the sitemap
   * links are built under it. Remove the installer path and rebuild the
   * sitemap. Any other base URL is left as it is.
   */
  #[Hook('cron')]
  public function cron(): void {
    $base_url = $this->state->get('xmlsitemap_base_url');
    if (!is_string($base_url)) {
      return;
    }
    $position = strpos($base_url, self::INSTALLER_PATH);
    if ($position === FALSE) {
      return;
    }
    $this->state->set('xmlsitemap_base_url', substr($base_url, 0, $position));
    $this->state->set('xmlsitemap_regenerate_needed', TRUE);
  }

}
