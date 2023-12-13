import { map } from 'common/collections';
import { toFixed } from 'common/math';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section, Dropdown, LabeledControls, Knob } from '../components';
import { RADIO_CHANNELS } from '../constants';
import { Window } from '../layouts';
import { sortBy } from 'common/collections';
import { flow } from 'common/fp';

export const ShuttleComms = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    listening,
    broadcasting,
    distress,
    distress_threshold,
    health_threshold,
    monitoring,
    clients,
  } = data;
  return (
    <Window
      width={400}
      height={450}>
      <Window.Content>
        <Section title="Radio Settings">
          <Button
            textAlign="center"
            width="37px"
            icon={listening ? 'volume-up' : 'volume-mute'}
            selected={listening}
            onClick={() => act('listen')} />
          <Button
            textAlign="center"
            width="37px"
            icon={broadcasting ? 'microphone' : 'microphone-slash'}
            selected={broadcasting}
            onClick={() => act('broadcast')} />
        </Section>
        <Section title="Distress Beacon Configuration">
          <LabeledList>
            <LabeledList.Item label="Emergency Signal">
              <Button
                icon="exclamation-triangle"
                selected={distress}
                onClick={() => act('toggle_distress')} />
            </LabeledList.Item>
            <LabeledList.Item label="Health Threshold">
              <NumberInput
                animate
                unit="%"
                step={1}
                stepPixelSize={10}
                minValue={0}
                maxValue={50}
                value={health_threshold}
                format={value => value * 100}
                onDrag={(e, value) => act('health_threshold', {
                  adjust: (value / 100),
                })} />
            </LabeledList.Item>
            <LabeledList.Item label="Casualty Threshold">
              <NumberInput
                animate
                unit="%"
                step={1}
                stepPixelSize={10}
                minValue={0}
                maxValue={50}
                value={distress_threshold}
                format={value => value * 100}
                onDrag={(e, value) => act('distress_threshold', {
                  adjust: (value / 100),
                })} />
            </LabeledList.Item>
            <LabeledList.Item>
              <Dropdown
                overflow-y="scroll"
                width="120px"
                options={clients}
                onSelected={value => act('toggle_monitoring', {
                  target: value,
                })} />
            </LabeledList.Item>
            <LabeledList.Item label="Monitored Signals">
              {monitoring.map(mob => <p>{mob}</p>)}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
