function doGet() {
  return HtmlService.createHtmlOutputFromFile('index')
    .setTitle('Classroom Seating Planner')
    .addMetaTag('viewport', 'width=device-width, initial-scale=1');
}
