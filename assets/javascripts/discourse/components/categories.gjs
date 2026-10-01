import Component from "@glimmer/component";
import { service } from "@ember/service";

const CATEGORY_CONFIG = [
  { key: "suggestions", label: "Suggestions", cssClass: "suggestions" },
  { key: "aiglobal", label: "AI", cssClass: "aiglobal" },
  { key: "docspace", label: "DocSpace", cssClass: "docspace" },
  { key: "documents", label: "Docs", cssClass: "documents" },
  { key: "document_api", label: "API", cssClass: "document_api" },
  { key: "plugins", label: "Plugins", cssClass: "plugins" },
  { key: "pdf", label: "PDF", cssClass: "pdf" },
  { key: "mobile_apps", label: "Mobile Apps", cssClass: "mob_apps" },
  { key: "document_builder", label: "Document Builder", cssClass: "doc_builder" },
  { key: "workspace", label: "Workspace", cssClass: "workspace" },
  { key: "connectors", label: "Connectors", cssClass: "connectors" },
  { key: "desktop_editors", label: "Desktop Editors", cssClass: "desk_editors" },
  { key: "resources_hub", label: "Resources Hub", cssClass: "resources_hub" },
  { key: "news", label: "News", cssClass: "news" },
];

export default class Categories extends Component {
  @service site;

  get categories() {
    const categoriesList = this.site.categoriesList;
    if (!categoriesList) {
      return [];
    }

    const bySlug = {};
    Object.values(categoriesList).forEach((category) => {
      bySlug[category.slug.replace("-", "_")] = category;
    });

    return CATEGORY_CONFIG.map(({ key, label, cssClass }) => {
      const category = bySlug[key];
      return {
        label,
        cssClass,
        link: category ? `/c/${category.slug}/${category.id}` : "",
        postCount: category ? category.post_count : 0,
      };
    });
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