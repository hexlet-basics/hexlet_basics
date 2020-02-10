// @ts-check

export default {
  nextLessonPath: (lesson) => `/lessons/${lesson.id}/redirect-to-next`,
  languageModuleLessonPath: (language, module, lesson) => `/languages/${language.slug}/modules/${module.slug}/lessons/${lesson.slug}`,
  lessonChecksPath: (lesson) => `/api/lessons/${lesson.id}/checks`,
};
