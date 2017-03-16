module.exports = {
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
        ]
    }
};
