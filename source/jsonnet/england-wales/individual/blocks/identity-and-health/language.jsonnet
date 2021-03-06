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

local nonProxyDefinitionDescription = 'This is the language you use most naturally. For example, it could be the language you use at home.';
local proxyDefinitionDescription = 'This is the language they use most naturally. For example, it could be the language they use at home.';

local routing(region_code) = (
  local regionValue = if region_code == 'GB-WLS' then walesString else englandString;
  {
    block: 'passports',
    when: [
      {
        id: 'language-answer',
        condition: 'equals',
        value: regionValue,
      },
    ],
  }
);

local question(title, definitionDescription, region_code, otherDescription) = (
  local regionOption = if region_code == 'GB-WLS' then walesOption else englandOption;
  {
    id: 'language-question',
    title: title,
    type: 'General',
    definitions: [{
      title: 'What we mean by “main language”',
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
            description: otherDescription,
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
      question: question(nonProxyTitle, nonProxyDefinitionDescription, region_code, 'You can enter your main language on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDefinitionDescription, region_code, 'You can enter their main language on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'language-other',
        when: [
          {
            id: 'language-answer',
            condition: 'equals',
            value: 'Other, including British Sign Language',
          },
        ],
      },
    },
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
