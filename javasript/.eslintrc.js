module.exports = {
  // "extends": "eslint:recommended",
  "extends": "airbnb",
  "plugins": [
    "react",
    "jsx-a11y",
    "import"
  ],
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "parser": "babel-eslint",
  "parserOptions": {
    "ecmaFeatures": {
      "experimentalObjectRestSpread": true,
      "jsx": true
    },
    "sourceType": "module"
  },
  "rules": {
    "react/jsx-filename-extension": [1, { "extensions": [".js", ".jsx"]  }],
    "prefer-stateless-function": [1, { "ignorePureComponents": true  }],
    "indent": [
      "error",
    ],
    "linebreak-style": [
      "error",
      "unix"
    ],
    "quotes": [
      "error",
      "single"
    ],
    "semi": [
      "error",
      "never"
    ],
    "prefer-stateless-function": [
      0,
      { "ignorePureComponents": true }
    ],
    "indent": [
      2,
      2,
      { "SwitchCase": 1 }
    ],
    "react/jsx-uses-vars": [
      1
    ]
  }
};
