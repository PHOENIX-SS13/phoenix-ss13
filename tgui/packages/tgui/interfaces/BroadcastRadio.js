import { map } from 'common/collections';
import { toFixed } from 'common/math';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, NumberInput, Section, Dropdown, LabeledControls, Knob } from '../components';
import { RADIO_CHANNELS } from '../constants';
import { Window } from '../layouts';
import { sortBy } from 'common/collections';
import { flow } from 'common/fp';

export const BroadcastRadio = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    freqlock,
    frequency,
    minFrequency,
    maxFrequency,
    listening,
    canBroadcast,
    broadcasting,
    command,
    useCommand,
    subspace,
    subspaceSwitchable,
    musicActive,
    trackSelected,
    trackLength,
    volume,
  } = data;
  const songs = flow([
    sortBy(
      song => song.name),
  ])(data.songs || []);
  const tunedChannel = RADIO_CHANNELS
    .find(channel => channel.freq === frequency);
  const channels = map((value, key) => ({
    name: key,
    status: !!value,
  }))(data.channels);
  return (
    <Window
      width={400}
      height={450}>
      <Window.Content>
        <Section title="Voice Settings">
          <LabeledList>
            <LabeledList.Item label="Frequency">
              {freqlock && (
                <Box inline color="light-gray">
                  {toFixed(frequency / 10, 1) + ' kHz'}
                </Box>
              ) || (
                <NumberInput
                  animate
                  unit="kHz"
                  step={0.2}
                  stepPixelSize={10}
                  minValue={minFrequency / 10}
                  maxValue={maxFrequency / 10}
                  value={frequency / 10}
                  format={value => toFixed(value, 1)}
                  onDrag={(e, value) => act('frequency', {
                    adjust: (value - frequency / 10),
                  })} />
              )}
              {tunedChannel && (
                <Box inline color={tunedChannel.color} ml={2}>
                  [{tunedChannel.name}]
                </Box>
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Audio">
              <Button
                textAlign="center"
                width="37px"
                icon={listening ? 'volume-up' : 'volume-mute'}
                selected={listening}
                onClick={() => act('listen')} />
              {!!canBroadcast && (<Button
                textAlign="center"
                width="37px"
                icon={broadcasting ? 'microphone' : 'microphone-slash'}
                selected={broadcasting}
                onClick={() => act('broadcast')} />
              )}
              {!!command && (
                <Button
                  ml={1}
                  icon="bullhorn"
                  selected={useCommand}
                  content={`High volume ${useCommand ? 'ON' : 'OFF'}`}
                  onClick={() => act('command')} />
              )}
              {!!subspaceSwitchable && (
                <Button
                  ml={1}
                  icon="bullhorn"
                  selected={subspace}
                  content={`Subspace Tx ${subspace ? 'ON' : 'OFF'}`}
                  onClick={() => act('subspace')} />
              )}
            </LabeledList.Item>
            {!!subspace && (
              <LabeledList.Item label="Channels">
                {channels.length === 0 && (
                  <Box inline color="bad">
                    No encryption keys installed.
                  </Box>
                )}
                {channels.map(channel => (
                  <Box key={channel.name}>
                    <Button
                      icon={channel.status ? 'check-square-o' : 'square-o'}
                      selected={channel.status}
                      content={channel.name}
                      onClick={() => act('channel', {
                        channel: channel.name,
                      })} />
                  </Box>
                ))}
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section
          title="Song Player"
          buttons={!!canBroadcast && (
            <Button
              icon={musicActive ? 'pause' : 'play'}
              content={musicActive ? 'Stop' : 'Play'}
              selected={musicActive}
              onClick={() => act('toggle')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Track Selected">
              {!!canBroadcast && (<Dropdown
                overflow-y="scroll"
                width="240px"
                options={songs.map(song => song.name)}
                disabled={musicActive}
                selected={trackSelected || "Select a Track"}
                onSelected={value => act('select_track', {
                  track: value,
                })} />)}
              {!canBroadcast && ("No Track Selected")}
            </LabeledList.Item>
            <LabeledList.Item label="Track Length">
              {trackSelected ? trackLength : "No Track Selected"}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Machine Settings">
          <LabeledControls justify="center">
            <LabeledControls.Item label="Volume">
              <Box position="relative">
                <Knob
                  size={3.2}
                  color={volume >= 50 ? 'red' : 'green'}
                  value={volume}
                  unit="%"
                  minValue={0}
                  maxValue={100}
                  step={1}
                  stepPixelSize={1}
                  disabled={musicActive}
                  onDrag={(e, value) => act('set_volume', {
                    volume: value,
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="-2px"
                  right="-22px"
                  color="transparent"
                  icon="fast-backward"
                  onClick={() => act('set_volume', {
                    volume: "min",
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="16px"
                  right="-22px"
                  color="transparent"
                  icon="fast-forward"
                  onClick={() => act('set_volume', {
                    volume: "max",
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="34px"
                  right="-22px"
                  color="transparent"
                  icon="undo"
                  onClick={() => act('set_volume', {
                    volume: "reset",
                  })} />
              </Box>
            </LabeledControls.Item>
          </LabeledControls>
        </Section>
      </Window.Content>
    </Window>
  );
};
