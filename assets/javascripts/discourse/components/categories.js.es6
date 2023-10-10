import Component from "@ember/component";
import discourseComputed from "discourse-common/utils/decorators";

export default Component.extend({

    categories: {
        docspace: {
            link: "",
            postCount: 0
        },
        documents: {
            link: "",
            postCount: 0
        },
        workspace: {
            link: "",
            postCount: 0
        },
        connectors: {
            link: "",
            postCount: 0
        },
        desktop_editors: {
            link: "",
            postCount: 0
        },
        forms: {
            link: "",
            postCount: 0
        },
        mobile_apps: {
            link: "",
            postCount: 0
        },
        document_builder: {
            link: "",
            postCount: 0
        },
        plugins: {
            link: "",
            postCount: 0
        },
        api: {
            link: "",
            postCount: 0
        },
        news: {
            link: "",
            postCount: 0
        },
        suggestions: {
            link: "",
            postCount: 0
        }
    },

    @discourseComputed("categories")
    initCategories() {
        if (!this.site.get("categoriesList")) {
            return false;
        }

        Object.values(this.site.get("categoriesList")).forEach((category) => {

            let slug = category.slug.replace("-", "_");

            if (this.categories[slug]) {
                this.categories[slug].link += "/c/" + category.slug + "/" + category.id;
                this.categories[slug].postCount = category.post_count;
            }
        });

        return true;
    }
});