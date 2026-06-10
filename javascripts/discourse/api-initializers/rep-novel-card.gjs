import { apiInitializer } from "discourse/lib/api";
import { i18n } from "discourse-i18n";

function fieldValue(fields, fieldId) {
  if (!fieldId) {
    return null;
  }

  return fields[String(fieldId)];
}

function isHttpUrl(url) {
  return /^https?:\/\//i.test(url);
}

function repNovel(user) {
  const fields = user?.user_fields;
  if (!fields) {
    return null;
  }

  const title = fieldValue(fields, settings.rep_novel_field_id_title);
  const url = fieldValue(fields, settings.rep_novel_field_id_url);

  if (!title || !url || !isHttpUrl(url)) {
    return null;
  }

  const cover = fieldValue(fields, settings.rep_novel_field_id_cover);
  const synopsis = fieldValue(fields, settings.rep_novel_field_id_synopsis);

  return {
    title,
    url,
    cover: cover && isHttpUrl(cover) ? cover : null,
    synopsis,
    target: settings.open_link_in_new_tab ? "_blank" : null,
    rel: settings.open_link_in_new_tab ? "noopener" : null,
  };
}

export default apiInitializer("1.0", (api) => {
  api.renderInOutlet(
    "user-card-metadata",
    <template>
      {{#let (repNovel @outletArgs.user) as |novel|}}
        {{#if novel}}
          <a class="rep-novel-card" href={{novel.url}} target={{novel.target}} rel={{novel.rel}}>
            {{#if novel.cover}}
              <img class="rep-novel-card__cover" src={{novel.cover}} alt="" loading="lazy" />
            {{/if}}
            <span class="rep-novel-card__body">
              <span class="rep-novel-card__label">{{i18n (themePrefix "rep_novel_card.label")}}</span>
              <span class="rep-novel-card__title">{{novel.title}}</span>
              {{#if novel.synopsis}}
                <span class="rep-novel-card__synopsis">{{novel.synopsis}}</span>
              {{/if}}
            </span>
          </a>
        {{/if}}
      {{/let}}
    </template>
  );

  api.renderInOutlet(
    "user-profile-primary",
    <template>
      {{#let (repNovel @outletArgs.model) as |novel|}}
        {{#if novel}}
          <a class="rep-novel-card rep-novel-card--profile" href={{novel.url}} target={{novel.target}} rel={{novel.rel}}>
            {{#if novel.cover}}
              <img class="rep-novel-card__cover" src={{novel.cover}} alt="" loading="lazy" />
            {{/if}}
            <span class="rep-novel-card__body">
              <span class="rep-novel-card__label">{{i18n (themePrefix "rep_novel_card.label")}}</span>
              <span class="rep-novel-card__title">{{novel.title}}</span>
              {{#if novel.synopsis}}
                <span class="rep-novel-card__synopsis">{{novel.synopsis}}</span>
              {{/if}}
            </span>
          </a>
        {{/if}}
      {{/let}}
    </template>
  );
});
