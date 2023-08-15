import { useBackend, useLocalState } from '../backend';
import { Tabs, Box, Button, Dropdown, Flex, Icon, LabeledList, Modal, Section } from '../components';
import { Window } from '../layouts';

export const OvermapShuttle = (props, context) => {
  const { act, data } = useBackend(context);
  const lockStates = {
    None: Symbol('none'),
    Locking: Symbol('locking'),
    Locked: Symbol('locked'),
  };
  const {
    overmapView,
    status,
    // GENERAL
    shields,
    position_x,
    position_y,
    commsListen,
    commsBroadcast,
    // ENGINES
    engines,
    // HELM
    destination_x,
    destination_y,
    speed,
    impulse,
    topSpeed,
    currentCommand,
    padControl,
    // SENSORS
    sensorTargets,
    // TARGET
    lockedTarget,
    lockStatus,
    scanInfo,
    // DOCK
    docks,
    freeformDocks,
  } = data;
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  return (
    <Window
      title=""
      width={800}
      height={600}>
      <Window.Content scrollable>
        <b>TRANSIT STATUS: {status}</b>
        <Tabs>
          <Tabs.Tab
            select={tab === 1}
            onClick={() => setTab(1)}>
            General
          </Tabs.Tab>
          <Tabs.Tab
            select={tab === 2}
            onClick={() => setTab(2)}>
            Engines
          </Tabs.Tab>
          <Tabs.Tab
            select={tab === 3}
            onClick={() => setTab(3)}>
            Helm
          </Tabs.Tab>
          <Tabs.Tab
            select={tab === 4}
            onClick={() => setTab(4)}>
            Sensors
          </Tabs.Tab>
          <Tabs.Tab
            select={tab === 5}
            onClick={() => setTab(5)}>
            Target
          </Tabs.Tab>
          <Tabs.Tab
            select={tab === 6}
            onClick={() => setTab(6)}>
            Dock
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <OvermapShuttleGeneral
            position_x={position_x}
            position_y={position_y} />
        )}
      </Window.Content>
    </Window>
  );
};

export const OvermapShuttleGeneral = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    position_x,
    position_y,
  } = data;
  return (
    <Section>
      <Box>
        <b>POSITION: ( {position_x}, {position_y} ) </b>
      </Box>
    </Section>
  );
};
