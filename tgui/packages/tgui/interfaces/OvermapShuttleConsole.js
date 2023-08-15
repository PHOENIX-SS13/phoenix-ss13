import { useBackend, useLocalState } from '../backend';
import { Tabs, Box, Button, Dropdown, Flex, Icon, LabeledList, Modal, Section } from '../components';
import { Window } from '../layouts';


export const OvermapShuttleConsole = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    status,
  } = data;

  return (
    <Window width={300} height={180} title="Shuttle Controls">
      <Window.Content scrollable align="center">
        <br /> <Button
          ml={1}
          icon="plane"
          color="green"
          content="Depart To Overmap"
          onClick={() => act('overmap_launch')} /><br /><br />
        <Button
          ml={1}
          icon="battery-full"
          color="yellow"
          content="Engines On"
          onClick={() => act('engines_on')} />
        <Button
          ml={1}
          icon="battery-empty"
          color="red"
          content="Engines Off"
          onClick={() => act('engines_off')} /> <br /><br />
        <Button
          ml={1}
          icon="map"
          color="blue"
          content="Overmap View"
          onClick={() => act('overmap_view')} />
        <Button
          ml={1}
          icon="gamepad"
          content="Shuttle Controls"
          color="white"
          onClick={() => act('overmap_ship_controls')} />
      </Window.Content>
    </Window>
  );
};
