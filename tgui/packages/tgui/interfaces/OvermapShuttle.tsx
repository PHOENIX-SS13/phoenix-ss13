import { classes } from 'common/react';
import { useBackend, useLocalState } from '../backend';
import { TextArea, Input, NumberInput, Table, Tabs, Box, Button, Dropdown, Flex, Icon, LabeledList, Modal, Section } from '../components';
import { Window } from '../layouts';

// act('action', { param1: 'value', })

type ShuttleData = {
  name: string;
  overmapView: boolean;
  status: string;
  // GENERAL
  shields: number;
  position_x: number;
  position_y: number;
  commsListen: boolean;
  commsBroadcast: boolean;
  // ENGINES
  engines: Engine[];
  // HELM
  destination_x: number;
  destination_y: number;
  speed: number;
  impulse: number;
  topSpeed: number;
  currentCommand: string;
  padControl: boolean;
  // SENSORS
  sensorTargets: Target[];
  // TARGET
  lockedTarget: Target;
  lockStatus: number;
  scanInfo: string;
  // DOCK
  docks: Dock[];
  freeformDocks: FreeDock[];
}

type Engine = {
  functioning: boolean;
  online: boolean;
  name: string;
  index: number;
  fuel_percent: number;
  efficiency: number;
}

type Target = {

}

type Dock = {

}

type FreeDock = {

}

export const OvermapShuttle = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const lockStates = {
    None: Symbol('none'),
    Locking: Symbol('locking'),
    Locked: Symbol('locked'),
  };
  const {
    name,
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
      title={name}
      width={600}
      height={400}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            General
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Engines
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 3}
            onClick={() => setTab(3)}>
            Helm
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 4}
            onClick={() => setTab(4)}>
            Sensors
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 5}
            onClick={() => setTab(5)}>
            Target
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 6}
            onClick={() => setTab(6)}>
            Dock
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <OvermapShuttleGeneral
            position_x={position_x}
            position_y={position_y} />
        )}
        {tab === 2 && (
          <OvermapShuttleEngines />
        )}
      </Window.Content>
    </Window>
  );
};

export const OvermapShuttleGeneral = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    position_x,
    position_y,
    commsListen,
    commsBroadcast,
  } = data;
  const [writingHail, setWritingHail] = useLocalState(context, "writingHail", false);
  return (
    <>
      <Section align="center">
        <Button
          content="Overmap View"
          onClick={() => act('overmap_view')}
        /><br />
        <b> POSITION: ( {position_x}, {position_y} ) </b>
      </Section>
      <Section title="Comms">
        <Button
          textAlign="center"
          width="37px"
          icon={commsListen ? 'volume-up' : 'volume-mute'}
          color={commsListen ? 'green' : 'red'}
          onClick={() => act('comms_output')}
        />
        <Button
          textAlign="center"
          width="37px"
          icon={commsBroadcast ? 'microphone' : 'microphone-slash'}
          color={commsBroadcast ? 'green' : 'red'}
          onClick={() => act('comms_input')}
        />
        {commsBroadcast ? <Button
          textAlign="center"
          content="Hail"
          selected={writingHail}
          onClick={() => setWritingHail(!writingHail)} /> : ''}
      </Section>
      {(writingHail && commsBroadcast) ? <HailWindow /> : ""}
    </>
  );
};

export const HailWindow = (props, context) => {
  const [hail, setHail] = useLocalState(context, "hail", "");
  return (
    <Section title="Compose Hail">
      <div align="center">
        <TextArea
          width="80%"
          height="100px"
          type="text"
          value={hail}
          placeholder="hail message here."
          onInput={(e, value) => setHail(value)}
        /><br />
        <Button
          content="sex" />
      </div>
    </Section>
  );
};

export const EngineDisplay = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    engine,
  } = props;
  return (
    <Table.Row>
      <Table.Cell bold>
        {engine.name}
      </Table.Cell>
      <Table.Cell>
        <Button
          content={engine.online ? "ONLINE" : "OFFLINE"}
          selected={engine.online}
          onClick={() => act('toggle_engine', { index: engine.index })}
        />
      </Table.Cell>
      <Table.Cell>
        {engine.fuel_percent * 100}%
      </Table.Cell>
      <Table.Cell>
        <NumberInput
          animate
          unit="%"
          step={1}
          minValue={0}
          maxValue={100}
          value={engine.efficiency}
          onDrag={(e, value) => act('set_efficiency', { index: engine.index, efficiency: value })}
        />
      </Table.Cell>
    </Table.Row>
  );
};

export const OvermapShuttleEngines = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    engines,
  } = data;
  return (
    <Section title="Engine Status">
      <Table>
        <Table.Row>
          <Table.Cell bold>
            <h3>ENGINE</h3>
          </Table.Cell>
          <Table.Cell bold>
            <h3>STATUS</h3>
          </Table.Cell>
          <Table.Cell bold>
            <h3>FUEL</h3>
          </Table.Cell>
          <Table.Cell bold>
            <h3>EFFICIENCY</h3>
          </Table.Cell>
        </Table.Row>
        {engines.map(engine => (
          <EngineDisplay
            key={engine.name}
            engine={engine} />
        ))}
      </Table><br />
      <div align="center">
        <Button
          ml={1}
          color="yellow"
          content="All Engines On"
          onClick={() => act("engines_on")} />
        <Button
          ml={1}
          color="red"
          content="All Engines Off"
          onClick={() => act("engines_off")} />
      </div>
    </Section>
  );
};
