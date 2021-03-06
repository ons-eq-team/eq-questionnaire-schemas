local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'main-job-type-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'main-job-type-answer',
      mandatory: false,
      options: [
        {
          label: 'Employee',
          value: 'Employee',
        },
        {
          label: 'Self-employed or freelance without employees',
          value: 'Self-employed or freelance without employees',
        },
        {
          label: 'Self-employed with employees',
          value: 'Self-employed with employees',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'In your main job, what is your employment status?';
local proxyTitle = {
  text: 'In their main job, what is <em>{person_name_possessive}</em> employment status?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In your main job, what was your employment status?';
local pastProxyTitle = {
  text: 'In their main job, what was <em>{person_name_possessive}</em> employment status?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'main-job-type',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle),
      when: [rules.isNotProxy, rules.lastMainJob],
    },
    {
      question: question(pastProxyTitle),
      when: [rules.isProxy, rules.lastMainJob],
    },
  ],
}
