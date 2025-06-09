import MarkdownToHtml from 'ember-cli-showdown/components/markdown-to-html';

<template>
  <div class="page">
    <div class="content">
      <MarkdownToHtml @markdown={{@model}} />
    </div>
  </div>
</template>
