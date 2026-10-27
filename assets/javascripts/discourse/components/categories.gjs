import Component from "@glimmer/component";
import { service } from "@ember/service";

export default class Categories extends Component {
  @service site;
  @service siteSettings;

  get categoryKeys() {
    const configuredKeys = this.siteSettings.discourse_categories_category_keys;

    const keys = Array.isArray(configuredKeys)
      ? configuredKeys
      : typeof configuredKeys === "string"
        ? configuredKeys.split("|")
        : [];

    return keys
      .map((key) => key.trim())
      .filter(Boolean);
  }

  get categories() {
    const categoriesList = this.site.categoriesList;

    if (!categoriesList) {
      return [];
    }

    const bySlug = {};

    Object.values(categoriesList).forEach((category) => {
      const key = category.slug.replace(/-/g, "_");
      bySlug[key] = category;
    });

    return this.categoryKeys
      .map((key) => {
        const normalizedKey = key.replace(/-/g, "_");
        const category = bySlug[normalizedKey];

        if (!category) {
          return null;
        }

        return {
          key: normalizedKey,
          label: category.name,
          cssClass: `category-${normalizedKey}`,
          link: `/c/${category.slug}/${category.id}`,
          postCount: category.post_count ?? 0,
        };
      })
      .filter(Boolean);
  }

  <template>
    {{#if this.categories.length}}
      <div class="do-categories">
        <h3>Categories</h3>
        <div class="do-link-categories">
          {{#each this.categories as |category|}}
            <a href={{category.link}} class={{category.cssClass}}>
              <h4>{{category.label}}</h4>
              <span>{{category.postCount}}</span>
            </a>
          {{/each}}
        </div>
      </div>
    {{/if}}
  </template>
}