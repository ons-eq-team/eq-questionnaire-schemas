local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'own-or-rent',
  question: {
    id: 'own-or-rent-question',
    title: {
      text: 'Does your household own or rent {household_address}?',
      placeholders: [placeholders.address],
    },
    instruction: 'Tell respondent to turn to <strong>Showcard 4</strong>',
    type: 'General',
    answers: [{
      id: 'own-or-rent-answer',
      mandatory: false,
      options: [
        {
          label: 'Owns outright',
          value: 'Owns outright',
        },
        {
          label: 'Owns with a mortgage or loan',
          value: 'Owns with a mortgage or loan',
        },
        {
          label: 'Part-owns and part-rents',
          value: 'Part-owns and part-rents',
          description: 'Shared ownership',
        },
        {
          label: 'Rents',
          value: 'Rents',
          description: 'With or without housing benefit',
        },
        {
          label: 'Lives here rent-free',
          value: 'Lives here rent-free',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'who-rent-from',
        when: [{
          id: 'own-or-rent-answer',
          condition: 'equals',
          value: 'Rents',
        }],
      },
    },
    {
      goto: {
        block: 'who-rent-from',
        when: [{
          id: 'own-or-rent-answer',
          condition: 'equals',
          value: 'Part-owns and part-rents',
        }],
      },
    },
    {
      goto: {
        block: 'who-rent-from',
        when: [{
          id: 'own-or-rent-answer',
          condition: 'equals',
          value: 'Lives here rent-free',
        }],
      },
    },
    {
      goto: {
        block: 'internet',
      },
    },
  ],
}
