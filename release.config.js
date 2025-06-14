module.exports = {
  branches: ['main', 'helper'],
  repositoryUrl: 'https://github.com/WUonam04/gh-actions-test',
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    '@semantic-release/changelog',
    [
      '@semantic-release/github',
      {
        assets: [
          'dist/**',
          'python/main.py'
        ],
        message: 'chore(release): ${nextRelease.version} [skip ci]',
        failComment: false,
        failTitle: false,
        labels: []
      }
    ],
    '@semantic-release/git'
  ],
  preset: 'conventionalcommits',
  tagFormat: 'v${version}'
};
