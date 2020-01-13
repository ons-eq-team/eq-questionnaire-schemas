local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your main language?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> main language?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local walesString =
  'English or Welsh';

local englandString =
  'English';

local englandOption = {
  label: englandString,
  value: englandString,
};

local walesOption = {
  label: walesString,
  value: walesString,
};

local nonProxyDefinitionDescription = 'Your main language is the language you use most naturally. It could be the language you use at home.';
local proxyDefinitionDescription = 'Their main language is the language they use most naturally. It could be the language they use at home.';

local routing(region_code) = (
  local regionValue = if region_code == 'GB-WLS' then walesString else englandString;
  {
    block: 'national-identity',
    when: [
      {
        id: 'language-answer',
        condition: 'equals',
        value: regionValue,
      },
    ],
  }
);

local question(title, definitionDescription, region_code) = (
  local regionOption = if region_code == 'GB-WLS' then walesOption else englandOption;
  {
    id: 'language-question',
    title: title,
    type: 'General',
    definitions: [{
      title: 'What do we mean by “main language”?',
      contents: [
        {
          description: definitionDescription,
        },
      ],
    }],
    answers: [
      {
        id: 'language-answer',
        mandatory: false,
        type: 'Radio',
        options: [
          regionOption,
          {
            label: 'Other, including British Sign Language',
            value: 'Other, including British Sign Language',
            description: 'Select to enter answer',
            detail_answer: {
              id: 'language-answer-other',
              type: 'TextField',
              mandatory: false,
              label: 'Enter main language',
            },
          },
        ],
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'language',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDefinitionDescription, region_code),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDefinitionDescription, region_code),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto:
        routing(region_code),
    },
    {
      goto: {
        block: 'english',
      },
    },
  ],
}