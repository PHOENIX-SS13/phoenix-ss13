import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../components';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';
import { Window } from '../layouts';

const DISEASE_THEASHOLD_LIST = [
  'Positive',
  'Harmless',
  'Minor',
  'Medium',
  'Harmful',
  'Dangerous',
  'BIOHAZARD',
];

const TARGET_SPECIES_LIST = [

  {
    name: 'Monkey',
    value: 'monkey',
  },
  {
    name: 'Human',
    value: 'human',
  },
  {
    name: 'Humanoid',
    value: 'humanoid',
  },
  {
    name: 'Felinid',
    value: 'felinid',
  },
  {
    name: 'Vulpkanin',
    value: 'vulpkanin',
  },
  {
    name: 'Tajaran',
    value: 'tajaran',
  },
  {
    name: 'Lizardperson',
    value: 'lizard',
  },
  {
    name: 'Ashwalker',
    value: 'lizard_ash',
  },
  {
    name: 'Silverscale',
    value: 'lizard_silver',
  },
  {
    name: 'Unathi',
    value: 'unathi',
  },
  {
    name: 'Teshari',
    value: 'teshari',
  },
  {
    name: 'Vox',
    value: 'vox',
  },
  {
    name: 'Aquatic',
    value: 'aquatic',
  },
  {
    name: 'Akula',
    value: 'akula',
  },
  {
    name: 'Skrell',
    value: 'skrell',
  },
  {
    name: 'Snailperson',
    value: 'snail',
  },
  {
    name: 'Anthromorphic Insect',
    value: 'insect',
  },
  {
    name: 'Mothperson',
    value: 'moth',
  },
  {
    name: 'Flyperson',
    value: 'fly',
  },
  {
    name: 'Slimeperson',
    value: 'slimeperson',
  },
  {
    name: 'Jellyslime',
    value: 'jelly_slime',
  },
  {
    name: 'Luminescent',
    value: 'jelly_luminescent',
  },
  {
    name: 'Stargazer',
    value: 'jelly_stargazer',
  },
  {
    name: 'Synthetic',
    value: 'synthetic',
  },
  {
    name: 'Android',
    value: 'android',
  },
  {
    name: 'Infiltration Android',
    value: 'android_infiltration',
  },
  {
    name: 'Militarized Infiltration Android',
    value: 'android_infiltration_militarized',
  },
  {
    name: 'Primal Podperson',
    value: 'pod',
  },
  {
    name: 'Podperson',
    value: 'podweak',
  },
  {
    name: 'Mushroomperson',
    value: 'mush',
  },
  {
    name: 'Diona',
    value: 'diona',
  },
  {
    name: 'Podgrown Diona',
    value: 'diona_pod',
  },
  {
    name: 'Anthromorph',
    value: 'anthromorph',
  },
  {
    name: 'Ethereal',
    value: 'ethereal',
  },
  {
    name: '???',
    value: 'shadow',
  },
  {
    name: 'Abductor',
    value: 'abductor',
  },
  {
    name: 'Xenomorph Hybrid',
    value: 'xenomorph_hybrid',
  },  
  {
    name: 'Plasmaman',
    value: 'plasmaman',
  },  
  {
    name: 'Skeleton',
    value: 'skeleton',
  },  
  {
    name: 'Dullahan',
    value: 'dullahan',
  }, 
  {
    name: 'Zombie',
    value: 'zombie',
  }, 
  {
    name: 'Zombie',
    value: 'memezombies',
  }, 
  {
    name: 'Zombie',
    value: 'goofzombies',
  }, 
  {
    name: 'Vampire',
    value: 'vampire',
  }, 
  {
    name: 'Golem',
    value: 'golem',
  },
  {
    name: 'Golem, Adamantine',
    value: 'adamantine',
  }, 
  {
    name: 'Golem, Plasma',
    value: 'plasma',
  },
  {
    name: 'Golem, Diamond',
    value: 'diamond',
  },
  {
    name: 'Golem, Gold',
    value: 'gold',
  }, 
  {
    name: 'Golem, Silver',
    value: 'silver',
  }, 
  {
    name: 'Golem, Uranium',
    value: 'uranium',
  }, 
];

const TARGET_NUTRITION_LIST = [
  {
    name: 'Starving',
    value: 150,
  },
  {
    name: 'Obese',
    value: 600,
  },
];

export const ScannerGate = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={400}
      height={300}>
      <Window.Content scrollable>
        <InterfaceLockNoticeBox
          onLockedStatusChange={() => act('toggle_lock')} />
        {!data.locked && (
          <ScannerGateControl />
        )}
      </Window.Content>
    </Window>
  );
};

const SCANNER_GATE_ROUTES = {
  Off: {
    title: 'Scanner Mode: Off',
    component: () => ScannerGateOff,
  },
  Wanted: {
    title: 'Scanner Mode: Wanted',
    component: () => ScannerGateWanted,
  },
  Guns: {
    title: 'Scanner Mode: Guns',
    component: () => ScannerGateGuns,
  },
  Mindshield: {
    title: 'Scanner Mode: Mindshield',
    component: () => ScannerGateMindshield,
  },
  Disease: {
    title: 'Scanner Mode: Disease',
    component: () => ScannerGateDisease,
  },
  Species: {
    title: 'Scanner Mode: Species',
    component: () => ScannerGateSpecies,
  },
  Nutrition: {
    title: 'Scanner Mode: Nutrition',
    component: () => ScannerGateNutrition,
  },
};

const ScannerGateControl = (props, context) => {
  const { act, data } = useBackend(context);
  const { scan_mode } = data;
  const route = SCANNER_GATE_ROUTES[scan_mode]
    || SCANNER_GATE_ROUTES.off;
  const Component = route.component();
  return (
    <Section
      title={route.title}
      buttons={scan_mode !== 'Off' && (
        <Button
          icon="arrow-left"
          content="back"
          onClick={() => act('set_mode', { new_mode: 'Off' })} />
      )}>
      <Component />
    </Section>
  );
};

const ScannerGateOff = (props, context) => {
  const { act } = useBackend(context);
  return (
    <>
      <Box mb={2}>
        Select a scanning mode below.
      </Box>
      <Box>
        <Button
          content="Wanted"
          onClick={() => act('set_mode', { new_mode: 'Wanted' })} />
        <Button
          content="Guns"
          onClick={() => act('set_mode', { new_mode: 'Guns' })} />
        <Button
          content="Mindshield"
          onClick={() => act('set_mode', { new_mode: 'Mindshield' })} />
        <Button
          content="Disease"
          onClick={() => act('set_mode', { new_mode: 'Disease' })} />
        <Button
          content="Species"
          onClick={() => act('set_mode', { new_mode: 'Species' })} />
        <Button
          content="Nutrition"
          onClick={() => act('set_mode', { new_mode: 'Nutrition' })} />
      </Box>
    </>
  );
};

const ScannerGateWanted = (props, context) => {
  const { data } = useBackend(context);
  const { reverse } = data;
  return (
    <>
      <Box mb={2}>
        Trigger if the person scanned {reverse ? 'does not have' : 'has'}
        {' '}any warrants for their arrest.
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateGuns = (props, context) => {
  const { data } = useBackend(context);
  const { reverse } = data;
  return (
    <>
      <Box mb={2}>
        Trigger if the person scanned {reverse ? 'does not have' : 'has'}
        {' '}any guns.
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateMindshield = (props, context) => {
  const { data } = useBackend(context);
  const { reverse } = data;
  return (
    <>
      <Box mb={2}>
        Trigger if the person scanned {reverse ? 'does not have' : 'has'}
        {' '}a mindshield.
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateDisease = (props, context) => {
  const { act, data } = useBackend(context);
  const { reverse, disease_threshold } = data;
  return (
    <>
      <Box mb={2}>
        Trigger if the person scanned {reverse ? 'does not have' : 'has'}
        {' '}a disease equal or worse than {disease_threshold}.
      </Box>
      <Box mb={2}>
        {DISEASE_THEASHOLD_LIST.map(threshold => (
          <Button.Checkbox
            key={threshold}
            checked={threshold === disease_threshold}
            content={threshold}
            onClick={() => act('set_disease_threshold', {
              new_threshold: threshold,
            })} />
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateSpecies = (props, context) => {
  const { act, data } = useBackend(context);
  const { reverse, target_species } = data;
  const species = TARGET_SPECIES_LIST.find(species => {
    return species.value === target_species;
  });
  return (
    <>
      <Box mb={2}>
        Trigger if the person scanned is {reverse ? 'not' : ''}
        {' '}of the {species.name} species.
        {target_species === 'zombie' && (
          ' All zombie types will be detected, including dormant zombies.'
        )}
      </Box>
      <Box mb={2}>
        {TARGET_SPECIES_LIST.map(species => (
          <Button.Checkbox
            key={species.value}
            checked={species.value === target_species}
            content={species.name}
            onClick={() => act('set_target_species', {
              new_species: species.value,
            })} />
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateNutrition = (props, context) => {
  const { act, data } = useBackend(context);
  const { reverse, target_nutrition } = data;
  const nutrition = TARGET_NUTRITION_LIST.find(nutrition => {
    return nutrition.value === target_nutrition;
  });
  return (
    <>
      <Box mb={2}>
        Trigger if the person scanned {reverse ? 'does not have' : 'has'}
        {' '}the {nutrition.name} nutrition level.
      </Box>
      <Box mb={2}>
        {TARGET_NUTRITION_LIST.map(nutrition => (
          <Button.Checkbox
            key={nutrition.name}
            checked={nutrition.value === target_nutrition}
            content={nutrition.name}
            onClick={() => act('set_target_nutrition', {
              new_nutrition: nutrition.name,
            })} />
        ))}
      </Box>
      <ScannerGateMode />
    </>
  );
};

const ScannerGateMode = (props, context) => {
  const { act, data } = useBackend(context);
  const { reverse } = data;
  return (
    <LabeledList>
      <LabeledList.Item label="Scanning Mode">
        <Button
          content={reverse ? 'Inverted' : 'Default'}
          icon={reverse ? 'random' : 'long-arrow-alt-right'}
          onClick={() => act('toggle_reverse')}
          color={reverse ? 'bad' : 'good'} />
      </LabeledList.Item>
    </LabeledList>
  );
};
