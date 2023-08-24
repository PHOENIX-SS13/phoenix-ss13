import { keyOfMatchingRange } from 'common/math';
import { classes } from 'common/react';
import { useBackend, useLocalState } from '../backend';
import { TextArea, Input, NumberInput, Table, Tabs, Box, Button, Dropdown, Flex, Icon, LabeledList, Modal, Section } from '../components';
import { Window } from '../layouts';

// act('action', { param1: 'value', })

type ShuttleData = {
  name: string;
  overmapView: boolean;
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
  maxTargetDist: number;
  // TARGET
  hasTarget: boolean;
  lockedTarget: Target;
  lockStatus: number;
  targetCommand: number;
  scanInfo: string;
  scanId: number;
  scanAliveClients: Client[];
  scanDeadClients: Client[];
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
  id: number;
  name: string;
  x: number;
  y: number;
  dist: number;
}

type Client = {
  name: string;
  alive: boolean;
  status: number;
}

type Dock = {
  id: number;
  name: string;
  mapname: string;
}

type FreeDock = {
  name: string;
  mapId: number;
  vlevelId:number;
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
    position_x,
    position_y,
  } = data;
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  return (
    <Window
      title={name}
      width={600}
      height={400}>
      <Window.Content>
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
            selected={tab===6}
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
        {tab === 3 && (
          <OvermapShuttleHelm />
        )}
        {tab === 4 && (
          <OvermapShuttleSensors />
        )}
        {tab === 5 && (
          <OvermapShuttleTarget />
        )}
        {tab === 6 && (
          <OvermapShuttleDocks />
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
      {(writingHail && commsBroadcast) ? <HailWindow setWritingHail={setWritingHail} /> : ""}
    </>
  );
};

export const HailWindow = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const [hail, setHail] = useLocalState(context, "hail", "");
  const { setWritingHail } = props;
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
          content="Send Hail"
          onClick={(e, value) => { act('hail', { hail: hail }); setWritingHail(false); }} />
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

export const OvermapShuttleHelm = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    destination_x,
    destination_y,
    speed,
    impulse,
    topSpeed,
    currentCommand,
    padControl,
  } = data;
  return (
    <>
      <Section>
        <b>Current Command: </b>{currentCommand}<br /><br />
        <b>Destination: </b><br />
        X:
        <NumberInput
          animate
          step={1}
          minValue={0}
          maxValue={30}
          value={destination_x}
          onDrag={(e, value) => act('change_x', { new_x: value })} />
        &nbsp;Y:<NumberInput
          animate
          step={1}
          minValue={0}
          maxValue={30}
          value={destination_y}
          onDrag={(e, value) => act('change_y', { new_y: value })} />
      </Section>
      <Section title="Commands">
        <Button
          content="Idle"
          onClick={() => act("command_stop")} /><br />
        <Button
          content="Move to destination"
          onClick={() => act("command_move_dest")} /><br />
        <Button
          content="Turn to destination"
          onClick={() => act("command_turn_dest")} /><br />
        <Button
          content="Follow Target"
          onClick={() => act("command_follow_sensor")} /><br />
        <Button
          content="Turn to Target"
          onClick={() => act("command_turn_sensor")} /><br />
        <Button
          content="Show Helm Pad"
          onClick={() => act("show_helm_pad")} /><br />
      </Section>
    </>
  );
};

export const SensorDisplay = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const { target } = props;
  const {
    hasTarget,
    lockedTarget,
    destination_x,
    destination_y,
    maxTargetDist,
  } = data;
  return (
    <Table.Row>
      <Table.Cell>
        <b>{target.name}</b>
      </Table.Cell>
      <Table.Cell>
        ( {target.x}, {target.y} )
      </Table.Cell>
      <Table.Cell>
        <Button
          content="Target"
          disabled={target.dist > maxTargetDist}
          selected={hasTarget && (target.id === lockedTarget.id)}
          onClick={() => act("sensor", { target_id: target.id, sensor_action: "target" })} />
        <Button
          content="Set as Destination"
          selected={target.x === destination_x
            && target.y === destination_y}
          onClick={() => act("sensor", { target_id: target.id, sensor_action: "destination" })} />
      </Table.Cell>
    </Table.Row>
  );
};

export const OvermapShuttleSensors = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    sensorTargets,
    hasTarget,
    lockedTarget,
    lockStatus,
  } = data;
  return (
    <Section>
      <b>Current Target: </b> {hasTarget ? <>{lockedTarget.name} - {lockStatus}</> : "None"}
      <br /> <Button content="Scan" onClick={() => act('update_static_data')} />
      <Table>
        {sensorTargets.map(target =>
          (<SensorDisplay
            key={target.name}
            target={target} />))}
      </Table>
    </Section>
  );
};

export const TargetButtons = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    lockedTarget,
    targetCommand,
    scanInfo,
    scanId,
  } = data;
  return (
    <Section>
      <b>Target: </b> {lockedTarget.name}<br />
      <Button content="Disengage Lock"
        onClick={() => act('target', { target_action: 'disengage_lock' })} /><br />
      <Button content="Idle" selected={targetCommand === 0}
        onClick={() => act('target', { target_action: 'command_idle' })} /><br />
      <Button content="Fire Once" selected={targetCommand === 1}
        onClick={() => act('target', { target_action: 'command_fire_once' })} /><br />
      <Button content="Continuous Fire" selected={targetCommand === 2}
        onClick={() => act('target', { target_action: 'command_keep_firing' })} /><br />
      <Button content="Scan" selected={targetCommand === 3}
        onClick={() => act('target', { target_action: 'command_scan' })} /><br />
      <Button content="Beam On board" selected={targetCommand === 4}
        onClick={() => act('target', { target_action: 'command_beam_on_board' })} /><br />
    </Section>
  );
};

export const ScanInfoDisplay = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    scanInfo,
    lockedTarget,
    scanId,
    scanAliveClients,
    scanDeadClients,
  } = data;
  if (lockedTarget.id !== scanId) {
    return (
      <Section title="Scan Info">
        <p>Not yet scanned.</p>
      </Section>
    );
  }
  else {
    return (
      <>
        <Section title="Scan Info">
          { scanInfo }<br />
        </Section>
        <Section title="Sensors">
          {scanAliveClients.map(client =>
            <ScanClientDisplay key={client.name} client={client} />)}
          {scanDeadClients.map(client =>
            <ScanClientDisplay key={client.name} client={client} />)}
        </Section>
      </>
    );
  }
};

export const ScanClientDisplay = (props, context) => {
  const {
    client,
  } = props;
  return (
    <>
      <b>{client.name}</b> -&nbsp;
      <div color={GetStatusColor(client.status)}>
        {client.status}
      </div>
    </>
  );
};

const GetStatusColor = (status) => {
  if (status === 3) {
    return "green";
  }
  if (status === 2) {
    return "yellow";
  }
  if (status === 1) {
    return "orange";
  }
  else {
    return "red";
  }
};

export const OvermapShuttleTarget = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    hasTarget,
    lockedTarget,
    targetCommand,
    scanInfo,
    scanId,
  } = data;
  return (
    <div>{hasTarget
      ? <><TargetButtons /><ScanInfoDisplay /></>
      : <p>No target found.</p>}
    </div>
  );
};

export const OvermapShuttleDocks = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    docks,
    freeformDocks,
  } = data;
  return (
    <>
      <Button content="Scan" onClick={() => act('update_static_data')} /><br />
      <Section title="Docks">
        <Table>
          {docks.map(dock =>
            (<DockDisplay
              key={dock.name}
              dock={dock} />))}
        </Table>
      </Section>
      <Section title="Freeform Docks">
        <Table>
          {freeformDocks.map(dock =>
            (<FreeformDockDisplay
              key={dock.name}
              dock={dock} />))}
        </Table>
      </Section>
    </>
  );
};

export const DockDisplay = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    dock,
  } = props;
  return (
    <Table.Row>
      <Table.Cell>
        <b>{dock.name}</b>
      </Table.Cell>
      <Table.Cell>
        <Button
          content="Dock"
          onClick={() => act('designated_dock', { dock_id: dock.id })} />
      </Table.Cell>
    </Table.Row>
  );
};

export const FreeformDockDisplay = (props, context) => {
  const { act, data } = useBackend<ShuttleData>(context);
  const {
    dock,
  } = props;
  return (
    <Table.Row>
      <Table.Cell>
        <b>{dock.name}</b>
      </Table.Cell>
      <Table.Cell>
        <Button
          content="Dock"
          onClick={() => act('freeform_dock', { map_id: dock.mapId, sub_id: dock.vlevelId })} />
      </Table.Cell>
    </Table.Row>
  );
};
