// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")

module.exports = {
  content: [
    "./js/**/*.js",
    "../../lib/*_web.ex",
    "../../lib/*_web/**/*.*ex"
  ],
  plugins: [
    require("@tailwindcss/forms"),
  ]
}
