local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'disability-other-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'disability-other-answer',
      mandatory: false,
      options: [
        {
          label: 'An intellectual or learning disability',
          value: 'An intellectual or learning disability',
          description: 'For example Down syndrome',
        },
        {
          label: 'A learning difficulty',
          value: 'A learning difficulty',
          description: 'For example dyslexia',
        },
        {
          label: 'Autism or Asperger syndrome',
          value: 'Autism or Asperger syndrome',
        },
        {
          label: 'An emotional, psychological or mental health condition',
          value: 'An emotional, psychological or mental health condition',
          description: 'For example depression or schizophrenia',
        },
        {
          label: 'Frequent periods of confusion or memory loss',
          value: 'Frequent periods of confusion or memory loss',
          description: 'For example dementia',
        },
        {
          label: 'Long-term pain or discomfort',
          value: 'Long-term pain or discomfort',
        },
        {
          label: 'Other condition',
          value: 'Other condition',
          description: 'For example cancer, diabetes or heart disease',
        },
      ],
      type: 'Checkbox',
    },
    {
      id: 'disability-other-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None of these conditions',
          value: 'None of these conditions',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'Do you have any of the following <em>other health conditions</em> which have lasted, or are expected to last, at least 12 months?';

local proxyTitle = {
  text: 'Does {person_name} have any of the following <em>other health conditions</em> which have lasted, or are expected to last, at least 12 months?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'disability-other',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        group: 'submit-group',
        when: [rules.under4],
      },
    },
    {
      goto: {
        block: 'carer',
        when: [rules.over5],
      },
    },
    {
      goto: {
        group: 'school-group',
      },
    },
  ],
}
