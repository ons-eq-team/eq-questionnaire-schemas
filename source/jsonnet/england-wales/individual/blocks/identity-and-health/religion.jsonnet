local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your religion?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> religion?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local englandDescription = 'Including Church of England, Catholic, Protestant and all other Christian denominations';
local walesDescription = 'All denominations';

local question(title, region_code, otherReligionDescription) = (
  local optionDescription = if region_code == 'GB-WLS' then walesDescription else englandDescription;
  {
    id: 'religion-question',
    title: title,
    guidance: {
      contents: [
        {
          description: 'This question is <strong>voluntary</strong>',
        },
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'religion-answer',
        mandatory: false,
        label: '',
        voluntary: true,
        options: [
          {
            label: 'No religion',
            value: 'No religion',
          },
          {
            label: 'Christian',
            value: 'Christian',
            description: optionDescription,
          },
          {
            label: 'Buddhist',
            value: 'Buddhist',
          },
          {
            label: 'Hindu',
            value: 'Hindu',
          },
          {
            label: 'Jewish',
            value: 'Jewish',
          },
          {
            label: 'Muslim',
            value: 'Muslim',
          },
          {
            label: 'Sikh',
            value: 'Sikh',
          },
          {
            label: 'Any other religion',
            value: 'Any other religion',
            description: otherReligionDescription,
          },
        ],
        type: 'Radio',
      },
    ],
  }
);

function(region_code) {
  type: 'Question',
  id: 'religion',
  question_variants: [
    {
      question: question(nonProxyTitle, region_code, 'You can enter your religion on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, region_code, 'You can enter their religion on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'religion-other',
        when: [
          {
            id: 'religion-answer',
            condition: 'equals',
            value: 'Any other religion',
          },
        ],
      },
    },
    {
      goto: {
        block: 'passports',
        when: [
          rules.under3,
        ],
      },
    },
    {
      goto: {
        block: if region_code == 'GB-WLS' then 'understand-welsh' else 'language',
      },
    },
  ],
}
