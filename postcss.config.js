module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('tailwindcss'),
    require('tailwindcss/nesting')(require('postcss-nested')),
    require('autoprefixer'),
  ]
}